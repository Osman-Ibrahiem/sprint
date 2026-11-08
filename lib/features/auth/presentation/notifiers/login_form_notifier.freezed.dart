// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_form_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginFormState {

 String get identifierText; String get passwordText; bool get isPasswordVisible; String? get identifierError; String? get passwordError; bool get isLoading;
/// Create a copy of LoginFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginFormStateCopyWith<LoginFormState> get copyWith => _$LoginFormStateCopyWithImpl<LoginFormState>(this as LoginFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LoginFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginFormState&&(identical(other.identifierText, _this.identifierText) || other.identifierText == _this.identifierText)&&(identical(other.passwordText, _this.passwordText) || other.passwordText == _this.passwordText)&&(identical(other.isPasswordVisible, _this.isPasswordVisible) || other.isPasswordVisible == _this.isPasswordVisible)&&(identical(other.identifierError, _this.identifierError) || other.identifierError == _this.identifierError)&&(identical(other.passwordError, _this.passwordError) || other.passwordError == _this.passwordError)&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading));
}


@override
int get hashCode {
  final _this = this as LoginFormState;
  return Object.hash(runtimeType,_this.identifierText,_this.passwordText,_this.isPasswordVisible,_this.identifierError,_this.passwordError,_this.isLoading);
}

@override
String toString() {
  final _this = this as LoginFormState;
  return 'LoginFormState(identifierText: ${_this.identifierText}, passwordText: ${_this.passwordText}, isPasswordVisible: ${_this.isPasswordVisible}, identifierError: ${_this.identifierError}, passwordError: ${_this.passwordError}, isLoading: ${_this.isLoading})';
}


}

/// @nodoc
abstract mixin class $LoginFormStateCopyWith<$Res>  {
  factory $LoginFormStateCopyWith(LoginFormState value, $Res Function(LoginFormState) _then) = _$LoginFormStateCopyWithImpl;
@useResult
$Res call({
 String identifierText, String passwordText, bool isPasswordVisible, String? identifierError, String? passwordError, bool isLoading
});




}
/// @nodoc
class _$LoginFormStateCopyWithImpl<$Res>
    implements $LoginFormStateCopyWith<$Res> {
  _$LoginFormStateCopyWithImpl(this._self, this._then);

  final LoginFormState _self;
  final $Res Function(LoginFormState) _then;

/// Create a copy of LoginFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? identifierText = null,Object? passwordText = null,Object? isPasswordVisible = null,Object? identifierError = freezed,Object? passwordError = freezed,Object? isLoading = null,}) {
  return _then(LoginFormState(
identifierText: null == identifierText ? _self.identifierText : identifierText // ignore: cast_nullable_to_non_nullable
as String,passwordText: null == passwordText ? _self.passwordText : passwordText // ignore: cast_nullable_to_non_nullable
as String,isPasswordVisible: null == isPasswordVisible ? _self.isPasswordVisible : isPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,identifierError: freezed == identifierError ? _self.identifierError : identifierError // ignore: cast_nullable_to_non_nullable
as String?,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginFormState].
extension LoginFormStatePatterns on LoginFormState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginFormState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginFormState value)  $default,){
final _that = this;
switch (_that) {
case _LoginFormState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginFormState value)?  $default,){
final _that = this;
switch (_that) {
case _LoginFormState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String identifierText,  String passwordText,  bool isPasswordVisible,  String? identifierError,  String? passwordError,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginFormState() when $default != null:
return $default(_that.identifierText,_that.passwordText,_that.isPasswordVisible,_that.identifierError,_that.passwordError,_that.isLoading);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String identifierText,  String passwordText,  bool isPasswordVisible,  String? identifierError,  String? passwordError,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _LoginFormState():
return $default(_that.identifierText,_that.passwordText,_that.isPasswordVisible,_that.identifierError,_that.passwordError,_that.isLoading);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String identifierText,  String passwordText,  bool isPasswordVisible,  String? identifierError,  String? passwordError,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _LoginFormState() when $default != null:
return $default(_that.identifierText,_that.passwordText,_that.isPasswordVisible,_that.identifierError,_that.passwordError,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _LoginFormState implements LoginFormState {
  const _LoginFormState({this.identifierText = '', this.passwordText = '', this.isPasswordVisible = false, this.identifierError, this.passwordError, this.isLoading = false});
  

@override@JsonKey() final  String identifierText;
@override@JsonKey() final  String passwordText;
@override@JsonKey() final  bool isPasswordVisible;
@override final  String? identifierError;
@override final  String? passwordError;
@override@JsonKey() final  bool isLoading;

/// Create a copy of LoginFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginFormStateCopyWith<_LoginFormState> get copyWith => __$LoginFormStateCopyWithImpl<_LoginFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginFormState&&(identical(other.identifierText, identifierText) || other.identifierText == identifierText)&&(identical(other.passwordText, passwordText) || other.passwordText == passwordText)&&(identical(other.isPasswordVisible, isPasswordVisible) || other.isPasswordVisible == isPasswordVisible)&&(identical(other.identifierError, identifierError) || other.identifierError == identifierError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode {
    return Object.hash(runtimeType,identifierText,passwordText,isPasswordVisible,identifierError,passwordError,isLoading);
}

@override
String toString() {
    return 'LoginFormState(identifierText: $identifierText, passwordText: $passwordText, isPasswordVisible: $isPasswordVisible, identifierError: $identifierError, passwordError: $passwordError, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$LoginFormStateCopyWith<$Res> implements $LoginFormStateCopyWith<$Res> {
  factory _$LoginFormStateCopyWith(_LoginFormState value, $Res Function(_LoginFormState) _then) = __$LoginFormStateCopyWithImpl;
@override @useResult
$Res call({
 String identifierText, String passwordText, bool isPasswordVisible, String? identifierError, String? passwordError, bool isLoading
});




}
/// @nodoc
class __$LoginFormStateCopyWithImpl<$Res>
    implements _$LoginFormStateCopyWith<$Res> {
  __$LoginFormStateCopyWithImpl(this._self, this._then);

  final _LoginFormState _self;
  final $Res Function(_LoginFormState) _then;

/// Create a copy of LoginFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? identifierText = null,Object? passwordText = null,Object? isPasswordVisible = null,Object? identifierError = freezed,Object? passwordError = freezed,Object? isLoading = null,}) {
  return _then(_LoginFormState(
identifierText: null == identifierText ? _self.identifierText : identifierText // ignore: cast_nullable_to_non_nullable
as String,passwordText: null == passwordText ? _self.passwordText : passwordText // ignore: cast_nullable_to_non_nullable
as String,isPasswordVisible: null == isPasswordVisible ? _self.isPasswordVisible : isPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,identifierError: freezed == identifierError ? _self.identifierError : identifierError // ignore: cast_nullable_to_non_nullable
as String?,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
