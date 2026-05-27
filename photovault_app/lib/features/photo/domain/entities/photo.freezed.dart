// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Photo {
  String get id => throw _privateConstructorUsedError;
  String get localPath => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get caption => throw _privateConstructorUsedError;
  String? get audioDescription => throw _privateConstructorUsedError;
  String? get remoteUrl => throw _privateConstructorUsedError;
  String? get photographerName => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;

  /// Create a copy of Photo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhotoCopyWith<Photo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoCopyWith<$Res> {
  factory $PhotoCopyWith(Photo value, $Res Function(Photo) then) =
      _$PhotoCopyWithImpl<$Res, Photo>;
  @useResult
  $Res call(
      {String id,
      String localPath,
      DateTime createdAt,
      String? caption,
      String? audioDescription,
      String? remoteUrl,
      String? photographerName,
      bool isFavorite});
}

/// @nodoc
class _$PhotoCopyWithImpl<$Res, $Val extends Photo>
    implements $PhotoCopyWith<$Res> {
  _$PhotoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Photo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? localPath = null,
    Object? createdAt = null,
    Object? caption = freezed,
    Object? audioDescription = freezed,
    Object? remoteUrl = freezed,
    Object? photographerName = freezed,
    Object? isFavorite = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      localPath: null == localPath
          ? _value.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      caption: freezed == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      audioDescription: freezed == audioDescription
          ? _value.audioDescription
          : audioDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      remoteUrl: freezed == remoteUrl
          ? _value.remoteUrl
          : remoteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      photographerName: freezed == photographerName
          ? _value.photographerName
          : photographerName // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PhotoImplCopyWith<$Res> implements $PhotoCopyWith<$Res> {
  factory _$$PhotoImplCopyWith(
          _$PhotoImpl value, $Res Function(_$PhotoImpl) then) =
      __$$PhotoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String localPath,
      DateTime createdAt,
      String? caption,
      String? audioDescription,
      String? remoteUrl,
      String? photographerName,
      bool isFavorite});
}

/// @nodoc
class __$$PhotoImplCopyWithImpl<$Res>
    extends _$PhotoCopyWithImpl<$Res, _$PhotoImpl>
    implements _$$PhotoImplCopyWith<$Res> {
  __$$PhotoImplCopyWithImpl(
      _$PhotoImpl _value, $Res Function(_$PhotoImpl) _then)
      : super(_value, _then);

  /// Create a copy of Photo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? localPath = null,
    Object? createdAt = null,
    Object? caption = freezed,
    Object? audioDescription = freezed,
    Object? remoteUrl = freezed,
    Object? photographerName = freezed,
    Object? isFavorite = null,
  }) {
    return _then(_$PhotoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      localPath: null == localPath
          ? _value.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      caption: freezed == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      audioDescription: freezed == audioDescription
          ? _value.audioDescription
          : audioDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      remoteUrl: freezed == remoteUrl
          ? _value.remoteUrl
          : remoteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      photographerName: freezed == photographerName
          ? _value.photographerName
          : photographerName // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$PhotoImpl implements _Photo {
  const _$PhotoImpl(
      {required this.id,
      required this.localPath,
      required this.createdAt,
      this.caption,
      this.audioDescription,
      this.remoteUrl,
      this.photographerName,
      this.isFavorite = false});

  @override
  final String id;
  @override
  final String localPath;
  @override
  final DateTime createdAt;
  @override
  final String? caption;
  @override
  final String? audioDescription;
  @override
  final String? remoteUrl;
  @override
  final String? photographerName;
  @override
  @JsonKey()
  final bool isFavorite;

  @override
  String toString() {
    return 'Photo(id: $id, localPath: $localPath, createdAt: $createdAt, caption: $caption, audioDescription: $audioDescription, remoteUrl: $remoteUrl, photographerName: $photographerName, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhotoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.localPath, localPath) ||
                other.localPath == localPath) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.audioDescription, audioDescription) ||
                other.audioDescription == audioDescription) &&
            (identical(other.remoteUrl, remoteUrl) ||
                other.remoteUrl == remoteUrl) &&
            (identical(other.photographerName, photographerName) ||
                other.photographerName == photographerName) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, localPath, createdAt,
      caption, audioDescription, remoteUrl, photographerName, isFavorite);

  /// Create a copy of Photo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhotoImplCopyWith<_$PhotoImpl> get copyWith =>
      __$$PhotoImplCopyWithImpl<_$PhotoImpl>(this, _$identity);
}

abstract class _Photo implements Photo {
  const factory _Photo(
      {required final String id,
      required final String localPath,
      required final DateTime createdAt,
      final String? caption,
      final String? audioDescription,
      final String? remoteUrl,
      final String? photographerName,
      final bool isFavorite}) = _$PhotoImpl;

  @override
  String get id;
  @override
  String get localPath;
  @override
  DateTime get createdAt;
  @override
  String? get caption;
  @override
  String? get audioDescription;
  @override
  String? get remoteUrl;
  @override
  String? get photographerName;
  @override
  bool get isFavorite;

  /// Create a copy of Photo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhotoImplCopyWith<_$PhotoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PhotoFilterState {
  String get searchQuery => throw _privateConstructorUsedError;
  SortOrder get sortOrder => throw _privateConstructorUsedError;

  /// Create a copy of PhotoFilterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhotoFilterStateCopyWith<PhotoFilterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoFilterStateCopyWith<$Res> {
  factory $PhotoFilterStateCopyWith(
          PhotoFilterState value, $Res Function(PhotoFilterState) then) =
      _$PhotoFilterStateCopyWithImpl<$Res, PhotoFilterState>;
  @useResult
  $Res call({String searchQuery, SortOrder sortOrder});
}

/// @nodoc
class _$PhotoFilterStateCopyWithImpl<$Res, $Val extends PhotoFilterState>
    implements $PhotoFilterStateCopyWith<$Res> {
  _$PhotoFilterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PhotoFilterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchQuery = null,
    Object? sortOrder = null,
  }) {
    return _then(_value.copyWith(
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as SortOrder,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PhotoFilterStateImplCopyWith<$Res>
    implements $PhotoFilterStateCopyWith<$Res> {
  factory _$$PhotoFilterStateImplCopyWith(_$PhotoFilterStateImpl value,
          $Res Function(_$PhotoFilterStateImpl) then) =
      __$$PhotoFilterStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String searchQuery, SortOrder sortOrder});
}

/// @nodoc
class __$$PhotoFilterStateImplCopyWithImpl<$Res>
    extends _$PhotoFilterStateCopyWithImpl<$Res, _$PhotoFilterStateImpl>
    implements _$$PhotoFilterStateImplCopyWith<$Res> {
  __$$PhotoFilterStateImplCopyWithImpl(_$PhotoFilterStateImpl _value,
      $Res Function(_$PhotoFilterStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PhotoFilterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchQuery = null,
    Object? sortOrder = null,
  }) {
    return _then(_$PhotoFilterStateImpl(
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as SortOrder,
    ));
  }
}

/// @nodoc

class _$PhotoFilterStateImpl implements _PhotoFilterState {
  const _$PhotoFilterStateImpl(
      {this.searchQuery = '', this.sortOrder = SortOrder.newest});

  @override
  @JsonKey()
  final String searchQuery;
  @override
  @JsonKey()
  final SortOrder sortOrder;

  @override
  String toString() {
    return 'PhotoFilterState(searchQuery: $searchQuery, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhotoFilterStateImpl &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @override
  int get hashCode => Object.hash(runtimeType, searchQuery, sortOrder);

  /// Create a copy of PhotoFilterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhotoFilterStateImplCopyWith<_$PhotoFilterStateImpl> get copyWith =>
      __$$PhotoFilterStateImplCopyWithImpl<_$PhotoFilterStateImpl>(
          this, _$identity);
}

abstract class _PhotoFilterState implements PhotoFilterState {
  const factory _PhotoFilterState(
      {final String searchQuery,
      final SortOrder sortOrder}) = _$PhotoFilterStateImpl;

  @override
  String get searchQuery;
  @override
  SortOrder get sortOrder;

  /// Create a copy of PhotoFilterState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhotoFilterStateImplCopyWith<_$PhotoFilterStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
