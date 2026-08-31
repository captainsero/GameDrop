import '../../core/errors/app_error_localizer.dart';
import '../../generated/l10n.dart';
import '../base_response/base_response.dart';
import '../base_state/base_state.dart';

abstract class ResponseToStateMapper {
  static BaseState<T> handle<T>(BaseResponse<T> response) {
    switch (response) {
      case SuccessBaseResponse<T>():
        return BaseState(
          data: response.data,
        );
      case ErrorBaseResponse<T>():
        return BaseState(
          errorMessage:
              response.errorMessage ?? response.appError.localize(S.current),
        );
    }
  }
}
