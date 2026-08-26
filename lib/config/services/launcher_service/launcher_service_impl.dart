import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

import 'launcher_service.dart';

@Injectable(as: LauncherService)
class LauncherServiceImpl implements LauncherService {
  @override
  Future<void> openPhone(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Future<void> openWhatsApp(String phone) async {
    final uri = Uri.parse('https://wa.me/$phone');

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
