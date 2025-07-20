// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsState()';
}


}

/// @nodoc
class $SettingsStateCopyWith<$Res>  {
$SettingsStateCopyWith(SettingsState _, $Res Function(SettingsState) __);
}


/// Adds pattern-matching-related methods to [SettingsState].
extension SettingsStatePatterns on SettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SettingsInitial value)?  initial,TResult Function( SettingsLoading value)?  loading,TResult Function( SettingsLoaded value)?  loaded,TResult Function( SettingsUpdated value)?  updated,TResult Function( SettingsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SettingsInitial() when initial != null:
return initial(_that);case SettingsLoading() when loading != null:
return loading(_that);case SettingsLoaded() when loaded != null:
return loaded(_that);case SettingsUpdated() when updated != null:
return updated(_that);case SettingsError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SettingsInitial value)  initial,required TResult Function( SettingsLoading value)  loading,required TResult Function( SettingsLoaded value)  loaded,required TResult Function( SettingsUpdated value)  updated,required TResult Function( SettingsError value)  error,}){
final _that = this;
switch (_that) {
case SettingsInitial():
return initial(_that);case SettingsLoading():
return loading(_that);case SettingsLoaded():
return loaded(_that);case SettingsUpdated():
return updated(_that);case SettingsError():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SettingsInitial value)?  initial,TResult? Function( SettingsLoading value)?  loading,TResult? Function( SettingsLoaded value)?  loaded,TResult? Function( SettingsUpdated value)?  updated,TResult? Function( SettingsError value)?  error,}){
final _that = this;
switch (_that) {
case SettingsInitial() when initial != null:
return initial(_that);case SettingsLoading() when loading != null:
return loading(_that);case SettingsLoaded() when loaded != null:
return loaded(_that);case SettingsUpdated() when updated != null:
return updated(_that);case SettingsError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( Settings settings)?  loaded,TResult Function( Settings settings)?  updated,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SettingsInitial() when initial != null:
return initial();case SettingsLoading() when loading != null:
return loading();case SettingsLoaded() when loaded != null:
return loaded(_that.settings);case SettingsUpdated() when updated != null:
return updated(_that.settings);case SettingsError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( Settings settings)  loaded,required TResult Function( Settings settings)  updated,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case SettingsInitial():
return initial();case SettingsLoading():
return loading();case SettingsLoaded():
return loaded(_that.settings);case SettingsUpdated():
return updated(_that.settings);case SettingsError():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( Settings settings)?  loaded,TResult? Function( Settings settings)?  updated,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case SettingsInitial() when initial != null:
return initial();case SettingsLoading() when loading != null:
return loading();case SettingsLoaded() when loaded != null:
return loaded(_that.settings);case SettingsUpdated() when updated != null:
return updated(_that.settings);case SettingsError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class SettingsInitial implements SettingsState {
  const SettingsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsState.initial()';
}


}




/// @nodoc


class SettingsLoading implements SettingsState {
  const SettingsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsState.loading()';
}


}




/// @nodoc


class SettingsLoaded implements SettingsState {
  const SettingsLoaded({required this.settings});
  

 final  Settings settings;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsLoadedCopyWith<SettingsLoaded> get copyWith => _$SettingsLoadedCopyWithImpl<SettingsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsLoaded&&(identical(other.settings, settings) || other.settings == settings));
}


@override
int get hashCode => Object.hash(runtimeType,settings);

@override
String toString() {
  return 'SettingsState.loaded(settings: $settings)';
}


}

/// @nodoc
abstract mixin class $SettingsLoadedCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory $SettingsLoadedCopyWith(SettingsLoaded value, $Res Function(SettingsLoaded) _then) = _$SettingsLoadedCopyWithImpl;
@useResult
$Res call({
 Settings settings
});


$SettingsCopyWith<$Res> get settings;

}
/// @nodoc
class _$SettingsLoadedCopyWithImpl<$Res>
    implements $SettingsLoadedCopyWith<$Res> {
  _$SettingsLoadedCopyWithImpl(this._self, this._then);

  final SettingsLoaded _self;
  final $Res Function(SettingsLoaded) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? settings = null,}) {
  return _then(SettingsLoaded(
settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as Settings,
  ));
}

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SettingsCopyWith<$Res> get settings {
  
  return $SettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}

/// @nodoc


class SettingsUpdated implements SettingsState {
  const SettingsUpdated({required this.settings});
  

 final  Settings settings;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsUpdatedCopyWith<SettingsUpdated> get copyWith => _$SettingsUpdatedCopyWithImpl<SettingsUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsUpdated&&(identical(other.settings, settings) || other.settings == settings));
}


@override
int get hashCode => Object.hash(runtimeType,settings);

@override
String toString() {
  return 'SettingsState.updated(settings: $settings)';
}


}

/// @nodoc
abstract mixin class $SettingsUpdatedCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory $SettingsUpdatedCopyWith(SettingsUpdated value, $Res Function(SettingsUpdated) _then) = _$SettingsUpdatedCopyWithImpl;
@useResult
$Res call({
 Settings settings
});


$SettingsCopyWith<$Res> get settings;

}
/// @nodoc
class _$SettingsUpdatedCopyWithImpl<$Res>
    implements $SettingsUpdatedCopyWith<$Res> {
  _$SettingsUpdatedCopyWithImpl(this._self, this._then);

  final SettingsUpdated _self;
  final $Res Function(SettingsUpdated) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? settings = null,}) {
  return _then(SettingsUpdated(
settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as Settings,
  ));
}

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SettingsCopyWith<$Res> get settings {
  
  return $SettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}

/// @nodoc


class SettingsError implements SettingsState {
  const SettingsError(this.message);
  

 final  String message;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsErrorCopyWith<SettingsError> get copyWith => _$SettingsErrorCopyWithImpl<SettingsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SettingsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $SettingsErrorCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory $SettingsErrorCopyWith(SettingsError value, $Res Function(SettingsError) _then) = _$SettingsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SettingsErrorCopyWithImpl<$Res>
    implements $SettingsErrorCopyWith<$Res> {
  _$SettingsErrorCopyWithImpl(this._self, this._then);

  final SettingsError _self;
  final $Res Function(SettingsError) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SettingsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
