// Cloudflare Worker: proxies RAWG API, hides the key, caches responses in KV.

const RAWG_BASE = "https://api.rawg.io/api";
const CACHE_TTL_SECONDS = 60 * 60; // 1 hour

// Console platform IDs on RAWG (excludes PC/mobile so results stay console-focused)
const CONSOLE_PLATFORMS = [
  187, // PS5
  18,  // PS4
  1,   // Xbox One
  186, // Xbox Series S/X
  7,   // Nintendo Switch
];

export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);

    try {
      if (url.pathname === "/games/upcoming") {
        return await handleUpcoming(url, env);
      }

      if (url.pathname === "/games/search") {
        return await handleSearch(url, env);
      }

      const detailMatch = url.pathname.match(/^\/games\/(\d+)$/);
      if (detailMatch) {
        return await handleDetail(detailMatch[1], env);
      }

      return jsonResponse({ error: "Not found" }, 404);
    } catch (err) {
      return jsonResponse({ error: "Internal error", detail: String(err) }, 500);
    }
  },
};

async function handleUpcoming(url, env) {
  const page = url.searchParams.get("page") || "1";
  const cacheKey = `upcoming:page:${page}`;

  const cached = await env.GAME_CACHE.get(cacheKey, "json");
  if (cached) {
    return jsonResponse(cached);
  }

  const today = new Date().toISOString().slice(0, 10);
  const oneYearOut = new Date();
  oneYearOut.setFullYear(oneYearOut.getFullYear() + 1);
  const future = oneYearOut.toISOString().slice(0, 10);

  const rawgUrl = new URL(`${RAWG_BASE}/games`);
  rawgUrl.searchParams.set("key", env.RAWG_API_KEY);
  rawgUrl.searchParams.set("dates", `${today},${future}`);
  rawgUrl.searchParams.set("ordering", "released");
  rawgUrl.searchParams.set("platforms", CONSOLE_PLATFORMS.join(","));
  rawgUrl.searchParams.set("page_size", "40");
  rawgUrl.searchParams.set("page", page);

  const res = await fetch(rawgUrl.toString());
  if (!res.ok) {
    return jsonResponse({ error: "RAWG upstream error", status: res.status }, 502);
  }
  const data = await res.json();

  const normalized = {
    count: data.count,
    next: data.next ? true : false,
    results: data.results.map(normalizeGameSummary),
  };

  await env.GAME_CACHE.put(cacheKey, JSON.stringify(normalized), {
    expirationTtl: CACHE_TTL_SECONDS,
  });

  return jsonResponse(normalized);
}

async function handleSearch(url, env) {
  const query = (url.searchParams.get("q") || "").trim();
  if (!query) {
    return jsonResponse({ error: "Missing required query param: q" }, 400);
  }

  const page = url.searchParams.get("page") || "1";
  // Cache key includes the query itself, so different searches don't collide
  const cacheKey = `search:${query.toLowerCase()}:page:${page}`;

  const cached = await env.GAME_CACHE.get(cacheKey, "json");
  if (cached) {
    return jsonResponse(cached);
  }

  const rawgUrl = new URL(`${RAWG_BASE}/games`);
  rawgUrl.searchParams.set("key", env.RAWG_API_KEY);
  rawgUrl.searchParams.set("search", query);
  rawgUrl.searchParams.set("platforms", CONSOLE_PLATFORMS.join(","));
  rawgUrl.searchParams.set("page_size", "20");
  rawgUrl.searchParams.set("page", page);

  const res = await fetch(rawgUrl.toString());
  if (!res.ok) {
    return jsonResponse({ error: "RAWG upstream error", status: res.status }, 502);
  }
  const data = await res.json();

  const normalized = {
    count: data.count,
    next: data.next ? true : false,
    results: data.results.map(normalizeGameSummary),
  };

  // Shorter TTL than /upcoming — search result freshness matters less,
  // but long-tail queries shouldn't sit stale for a full hour either
  await env.GAME_CACHE.put(cacheKey, JSON.stringify(normalized), {
    expirationTtl: 30 * 60, // 30 minutes
  });

  return jsonResponse(normalized);
}

async function handleDetail(id, env) {
  const cacheKey = `detail:${id}`;

  const cached = await env.GAME_CACHE.get(cacheKey, "json");
  if (cached) {
    return jsonResponse(cached);
  }

  const rawgUrl = new URL(`${RAWG_BASE}/games/${id}`);
  rawgUrl.searchParams.set("key", env.RAWG_API_KEY);

  const res = await fetch(rawgUrl.toString());
  if (!res.ok) {
    return jsonResponse({ error: "RAWG upstream error", status: res.status }, 502);
  }
  const data = await res.json();

  const normalized = normalizeGameDetail(data);

  await env.GAME_CACHE.put(cacheKey, JSON.stringify(normalized), {
    expirationTtl: CACHE_TTL_SECONDS,
  });

  return jsonResponse(normalized);
}

// Trim RAWG's response down to only what the app's GameModel needs.
function normalizeGameSummary(game) {
  return {
    id: game.id,
    name: game.name,
    coverUrl: game.background_image,
    releaseDate: game.released, // "YYYY-MM-DD" or null if TBA
    tba: game.tba === true,
    platforms: (game.platforms || []).map((p) => p.platform.name),
  };
}

function normalizeGameDetail(game) {
  return {
    id: game.id,
    name: game.name,
    coverUrl: game.background_image,
    releaseDate: game.released,
    tba: game.tba === true,
    platforms: (game.platforms || []).map((p) => p.platform.name),
    summary: stripHtml(game.description_raw || game.description || ""),
  };
}

function stripHtml(text) {
  return text.replace(/<[^>]*>/g, "").trim();
}

function jsonResponse(body, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { "Content-Type": "application/json" },
  });
}