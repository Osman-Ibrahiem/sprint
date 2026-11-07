import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/features/auth/presentation/notifiers/login_form_notifier.dart';

void main() {
  group('LoginFormNotifier', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
      container.listen(loginFormProvider, (_, _) {});
    });

    tearDown(() {
      container.dispose();
    });

    LoginFormNotifier notifier() =>
        container.read(loginFormProvider.notifier);

    LoginFormState state() => container.read(loginFormProvider);

    test('initial state has all defaults', () {
      expect(state().identifierText, '');
      expect(state().passwordText, '');
      expect(state().isPasswordVisible, false);
      expect(state().identifierError, null);
      expect(state().passwordError, null);
      expect(state().isLoading, false);
    });

    test('setIdentifierText updates text and clears identifierError', () {
      notifier().mockSetError();
      expect(state().identifierError, isNotNull);

      notifier().setIdentifierText('test@email.com');

      expect(state().identifierText, 'test@email.com');
      expect(state().identifierError, null);
      expect(state().passwordError, isNotNull);
    });

    test('setPasswordText updates text and clears passwordError', () {
      notifier().mockSetError();
      expect(state().passwordError, isNotNull);

      notifier().setPasswordText('secret123');

      expect(state().passwordText, 'secret123');
      expect(state().passwordError, null);
      expect(state().identifierError, isNotNull);
    });

    test('togglePasswordVisibility flips isPasswordVisible', () {
      expect(state().isPasswordVisible, false);

      notifier().togglePasswordVisibility();
      expect(state().isPasswordVisible, true);

      notifier().togglePasswordVisibility();
      expect(state().isPasswordVisible, false);
    });

    test('mockLogin sets isLoading true then false after delay', () async {
      expect(state().isLoading, false);

      final future = notifier().mockLogin();
      expect(state().isLoading, true);

      await future;
      expect(state().isLoading, false);
    });

    test('mockSetError sets both error fields', () {
      notifier().mockSetError();

      expect(state().identifierError, isNotNull);
      expect(state().identifierError, isNotEmpty);
      expect(state().passwordError, isNotNull);
      expect(state().passwordError, isNotEmpty);
    });

    test('clearErrors nulls both error fields', () {
      notifier().mockSetError();
      expect(state().identifierError, isNotNull);
      expect(state().passwordError, isNotNull);

      notifier().clearErrors();

      expect(state().identifierError, null);
      expect(state().passwordError, null);
    });
  });
}
