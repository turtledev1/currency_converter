// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'converter_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConverterState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConverterState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConverterState()';
}


}

/// @nodoc
class $ConverterStateCopyWith<$Res>  {
$ConverterStateCopyWith(ConverterState _, $Res Function(ConverterState) __);
}


/// Adds pattern-matching-related methods to [ConverterState].
extension ConverterStatePatterns on ConverterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ConverterInitial value)?  initial,TResult Function( ConverterLoading value)?  loading,TResult Function( ConverterLoaded value)?  loaded,TResult Function( ConverterError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ConverterInitial() when initial != null:
return initial(_that);case ConverterLoading() when loading != null:
return loading(_that);case ConverterLoaded() when loaded != null:
return loaded(_that);case ConverterError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ConverterInitial value)  initial,required TResult Function( ConverterLoading value)  loading,required TResult Function( ConverterLoaded value)  loaded,required TResult Function( ConverterError value)  error,}){
final _that = this;
switch (_that) {
case ConverterInitial():
return initial(_that);case ConverterLoading():
return loading(_that);case ConverterLoaded():
return loaded(_that);case ConverterError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ConverterInitial value)?  initial,TResult? Function( ConverterLoading value)?  loading,TResult? Function( ConverterLoaded value)?  loaded,TResult? Function( ConverterError value)?  error,}){
final _that = this;
switch (_that) {
case ConverterInitial() when initial != null:
return initial(_that);case ConverterLoading() when loading != null:
return loading(_that);case ConverterLoaded() when loaded != null:
return loaded(_that);case ConverterError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ExchangeRates rates,  Currency sourceCurrency,  Currency targetCurrency,  double sourceAmount,  double convertedAmount,  DateTime lastUpdated)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ConverterInitial() when initial != null:
return initial();case ConverterLoading() when loading != null:
return loading();case ConverterLoaded() when loaded != null:
return loaded(_that.rates,_that.sourceCurrency,_that.targetCurrency,_that.sourceAmount,_that.convertedAmount,_that.lastUpdated);case ConverterError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ExchangeRates rates,  Currency sourceCurrency,  Currency targetCurrency,  double sourceAmount,  double convertedAmount,  DateTime lastUpdated)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ConverterInitial():
return initial();case ConverterLoading():
return loading();case ConverterLoaded():
return loaded(_that.rates,_that.sourceCurrency,_that.targetCurrency,_that.sourceAmount,_that.convertedAmount,_that.lastUpdated);case ConverterError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ExchangeRates rates,  Currency sourceCurrency,  Currency targetCurrency,  double sourceAmount,  double convertedAmount,  DateTime lastUpdated)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ConverterInitial() when initial != null:
return initial();case ConverterLoading() when loading != null:
return loading();case ConverterLoaded() when loaded != null:
return loaded(_that.rates,_that.sourceCurrency,_that.targetCurrency,_that.sourceAmount,_that.convertedAmount,_that.lastUpdated);case ConverterError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ConverterInitial implements ConverterState {
  const ConverterInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConverterInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConverterState.initial()';
}


}




/// @nodoc


class ConverterLoading implements ConverterState {
  const ConverterLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConverterLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConverterState.loading()';
}


}




/// @nodoc


class ConverterLoaded implements ConverterState {
  const ConverterLoaded({required this.rates, required this.sourceCurrency, required this.targetCurrency, required this.sourceAmount, required this.convertedAmount, required this.lastUpdated});
  

 final  ExchangeRates rates;
 final  Currency sourceCurrency;
 final  Currency targetCurrency;
 final  double sourceAmount;
 final  double convertedAmount;
 final  DateTime lastUpdated;

/// Create a copy of ConverterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConverterLoadedCopyWith<ConverterLoaded> get copyWith => _$ConverterLoadedCopyWithImpl<ConverterLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConverterLoaded&&(identical(other.rates, rates) || other.rates == rates)&&(identical(other.sourceCurrency, sourceCurrency) || other.sourceCurrency == sourceCurrency)&&(identical(other.targetCurrency, targetCurrency) || other.targetCurrency == targetCurrency)&&(identical(other.sourceAmount, sourceAmount) || other.sourceAmount == sourceAmount)&&(identical(other.convertedAmount, convertedAmount) || other.convertedAmount == convertedAmount)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}


@override
int get hashCode => Object.hash(runtimeType,rates,sourceCurrency,targetCurrency,sourceAmount,convertedAmount,lastUpdated);

@override
String toString() {
  return 'ConverterState.loaded(rates: $rates, sourceCurrency: $sourceCurrency, targetCurrency: $targetCurrency, sourceAmount: $sourceAmount, convertedAmount: $convertedAmount, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $ConverterLoadedCopyWith<$Res> implements $ConverterStateCopyWith<$Res> {
  factory $ConverterLoadedCopyWith(ConverterLoaded value, $Res Function(ConverterLoaded) _then) = _$ConverterLoadedCopyWithImpl;
@useResult
$Res call({
 ExchangeRates rates, Currency sourceCurrency, Currency targetCurrency, double sourceAmount, double convertedAmount, DateTime lastUpdated
});


$ExchangeRatesCopyWith<$Res> get rates;

}
/// @nodoc
class _$ConverterLoadedCopyWithImpl<$Res>
    implements $ConverterLoadedCopyWith<$Res> {
  _$ConverterLoadedCopyWithImpl(this._self, this._then);

  final ConverterLoaded _self;
  final $Res Function(ConverterLoaded) _then;

/// Create a copy of ConverterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rates = null,Object? sourceCurrency = null,Object? targetCurrency = null,Object? sourceAmount = null,Object? convertedAmount = null,Object? lastUpdated = null,}) {
  return _then(ConverterLoaded(
rates: null == rates ? _self.rates : rates // ignore: cast_nullable_to_non_nullable
as ExchangeRates,sourceCurrency: null == sourceCurrency ? _self.sourceCurrency : sourceCurrency // ignore: cast_nullable_to_non_nullable
as Currency,targetCurrency: null == targetCurrency ? _self.targetCurrency : targetCurrency // ignore: cast_nullable_to_non_nullable
as Currency,sourceAmount: null == sourceAmount ? _self.sourceAmount : sourceAmount // ignore: cast_nullable_to_non_nullable
as double,convertedAmount: null == convertedAmount ? _self.convertedAmount : convertedAmount // ignore: cast_nullable_to_non_nullable
as double,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of ConverterState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExchangeRatesCopyWith<$Res> get rates {
  
  return $ExchangeRatesCopyWith<$Res>(_self.rates, (value) {
    return _then(_self.copyWith(rates: value));
  });
}
}

/// @nodoc


class ConverterError implements ConverterState {
  const ConverterError({required this.message});
  

 final  String message;

/// Create a copy of ConverterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConverterErrorCopyWith<ConverterError> get copyWith => _$ConverterErrorCopyWithImpl<ConverterError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConverterError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ConverterState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ConverterErrorCopyWith<$Res> implements $ConverterStateCopyWith<$Res> {
  factory $ConverterErrorCopyWith(ConverterError value, $Res Function(ConverterError) _then) = _$ConverterErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ConverterErrorCopyWithImpl<$Res>
    implements $ConverterErrorCopyWith<$Res> {
  _$ConverterErrorCopyWithImpl(this._self, this._then);

  final ConverterError _self;
  final $Res Function(ConverterError) _then;

/// Create a copy of ConverterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ConverterError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
