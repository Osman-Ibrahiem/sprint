// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_form_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$LoginFormState {
  String get identifierText => throw _privateConstructorUsedError;
  String get passwordText => throw _privateConstructorUsedError;
  bool get isPasswordVisible => throw _privateConstructorUsedError;
  String? get identifierError => throw _privateConstructorUsedError;
  String? get passwordError => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of LoginFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginFormStateCopyWith<LoginFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginFormStateCopyWith<$Res> {
  factory $LoginFormStateCopyWith(
    LoginFormState value,
    $Res Function(LoginFormState) then,
  ) = _$LoginFormStateCopyWithImpl<$Res, LoginFormState>;
  @useResult
  $Res call({
    String identifierText,
    String passwordText,
    bool isPasswordVisible,
    String? identifierError,
    String? passwordError,
    bool isLoading,
  });
}

/// @nodoc
class _$LoginFormStateCopyWithImpl<$Res, $Val extends LoginFormState>
    implements $LoginFormStateCopyWith<$Res> {
  _$LoginFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifierText = null,
    Object? passwordText = null,
    Object? isPasswordVisible = null,
    Object? identifierError = freezed,
    Object? passwordError = freezed,
    Object? isLoading = null,
  }) {
    return _then(
      _value.copyWith(
            identifierText: null == identifierText
                ? _value.identifierText
                : identifierText // ignore: cast_nullable_to_non_nullable
                      as String,
            passwordText: null == passwordText
                ? _value.passwordText
                : passwordText // ignore: cast_nullable_to_non_nullable
                      as String,
            isPasswordVisible: null == isPasswordVisible
                ? _value.isPasswordVisible
                : isPasswordVisible // ignore: cast_nullable_to_non_nullable
                      as bool,
            identifierError: freezed == identifierError
                ? _value.identifierError
                : identifierError // ignore: cast_nullable_to_non_nullable
                      as String?,
            passwordError: freezed == passwordError
                ? _value.passwordError
                : passwordError // ignore: cast_nullable_to_non_nullable
                      as String?,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoginFormStateImplCopyWith<$Res>
    implements $LoginFormStateCopyWith<$Res> {
  factory _$$LoginFormStateImplCopyWith(
    _$LoginFormStateImpl value,
    $Res Function(_$LoginFormStateImpl) then,
  ) = __$$LoginFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String identifierText,
    String passwordText,
    bool isPasswordVisible,
    String? identifierError,
    String? passwordError,
    bool isLoading,
  });
}

/// @nodoc
class __$$LoginFormStateImplCopyWithImpl<$Res>
    extends _$LoginFormStateCopyWithImpl<$Res, _$LoginFormStateImpl>
    implements _$$LoginFormStateImplCopyWith<$Res> {
  __$$LoginFormStateImplCopyWithImpl(
    _$LoginFormStateImpl _value,
    $Res Function(_$LoginFormStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifierText = null,
    Object? passwordText = null,
    Object? isPasswordVisible = null,
    Object? identifierError = freezed,
    Object? passwordError = freezed,
    Object? isLoading = null,
  }) {
    return _then(
      _$LoginFormStateImpl(
        identifierText: null == identifierText
            ? _value.identifierText
            : identifierText // ignore: cast_nullable_to_non_nullable
                  as String,
        passwordText: null == passwordText
            ? _value.passwordText
            : passwordText // ignore: cast_nullable_to_non_nullable
                  as String,
        isPasswordVisible: null == isPasswordVisible
            ? _value.isPasswordVisible
            : isPasswordVisible // ignore: cast_nullable_to_non_nullable
                  as bool,
        identifierError: freezed == identifierError
            ? _value.identifierError
            : identifierError // ignore: cast_nullable_to_non_nullable
                  as String?,
        passwordError: freezed == passwordError
            ? _value.passwordError
            : passwordError // ignore: cast_nullable_to_non_nullable
                  as String?,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$LoginFormStateImpl implements _LoginFormState {
  const _$LoginFormStateImpl({
    this.identifierText = '',
    this.passwordText = '',
    this.isPasswordVisible = false,
    this.identifierError,
    this.passwordError,
    this.isLoading = false,
  });

  @override
  @JsonKey()
  final String identifierText;
  @override
  @JsonKey()
  final String passwordText;
  @override
  @JsonKey()
  final bool isPasswordVisible;
  @override
  final String? identifierError;
  @override
  final String? passwordError;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'LoginFormState(identifierText: $identifierText, passwordText: $passwordText, isPasswordVisible: $isPasswordVisible, identifierError: $identifierError, passwordError: $passwordError, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginFormStateImpl &&
            (identical(other.identifierText, identifierText) ||
                other.identifierText == identifierText) &&
            (identical(other.passwordText, passwordText) ||
                other.passwordText == passwordText) &&
            (identical(other.isPasswordVisible, isPasswordVisible) ||
                other.isPasswordVisible == isPasswordVisible) &&
            (identical(other.identifierError, identifierError) ||
                other.identifierError == identifierError) &&
            (identical(other.passwordError, passwordError) ||
                other.passwordError == passwordError) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    identifierText,
    passwordText,
    isPasswordVisible,
    identifierError,
    passwordError,
    isLoading,
  );

  /// Create a copy of LoginFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginFormStateImplCopyWith<_$LoginFormStateImpl> get copyWith =>
      __$$LoginFormStateImplCopyWithImpl<_$LoginFormStateImpl>(
        this,
        _$identity,
      );
}

abstract class _LoginFormState implements LoginFormState {
  const factory _LoginFormState({
    final String identifierText,
    final String passwordText,
    final bool isPasswordVisible,
    final String? identifierError,
    final String? passwordError,
    final bool isLoading,
  }) = _$LoginFormStateImpl;

  @override
  String get identifierText;
  @override
  String get passwordText;
  @override
  bool get isPasswordVisible;
  @override
  String? get identifierError;
  @override
  String? get passwordError;
  @override
  bool get isLoading;

  /// Create a copy of LoginFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginFormStateImplCopyWith<_$LoginFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
