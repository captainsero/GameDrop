import '../../generated/l10n.dart';
import 'app_error.dart';

extension AppErrorLocalization on AppError {
  String localize(S l10n) {
    return switch (this) {
      ConnectionTimeoutError() => l10n.connectionTimeout,
      RequestTimeoutError() => l10n.requestTimeout,
      NetworkError() => l10n.networkError,
      NotFoundError() => l10n.notFound,
      ServerError() => l10n.serverError,
      ApiMessageError(message: final m) => m,
      UnknownError() => l10n.errorMessageGeneric,
      LocalStorageError(:final key) =>
        key != null
            ? '${l10n.noValueKeyFound}$key'
            : l10n.secureStorageErrorMessage,
      ServiceDisabled() => l10n.serviceDisabled,
      PermissionDenied() => l10n.permissionDenied,
      PermissionDeniedForever() => l10n.permissionDeniedForever,
    };
  }
}
