import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_form_notifier.freezed.dart';
part 'login_form_notifier.g.dart';

@freezed
class LoginFormState with _$LoginFormState {
  const factory LoginFormState({
    @Default('') String identifierText,
    @Default('') String passwordText,
    @Default(false) bool isPasswordVisible,
    String? identifierError,
    String? passwordError,
    @Default(false) bool isLoading,
  }) = _LoginFormState;
}

@riverpod
class LoginFormNotifier extends _$LoginFormNotifier {
  @override
  LoginFormState build() => const LoginFormState();

  void setIdentifierText(String value) {
    state = state.copyWith(identifierText: value, identifierError: null);
  }

  void setPasswordText(String value) {
    state = state.copyWith(passwordText: value, passwordError: null);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  Future<void> mockLogin() async {
    state = state.copyWith(isLoading: true);
    await Future<void>.delayed(const Duration(milliseconds: 1800));
    state = state.copyWith(isLoading: false);
  }

  void mockSetError() {
    state = state.copyWith(
      identifierError: 'يرجى إدخال الإيميل أو رقم الموبايل',
      passwordError: 'يرجى إدخال كلمة السر',
    );
  }

  void clearErrors() {
    state = state.copyWith(identifierError: null, passwordError: null);
  }
}
