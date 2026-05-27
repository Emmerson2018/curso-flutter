// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unsplash_photo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UnsplashSearchResponse _$UnsplashSearchResponseFromJson(
    Map<String, dynamic> json) {
  return _UnsplashSearchResponse.fromJson(json);
}

/// @nodoc
mixin _$UnsplashSearchResponse {
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_pages')
  int get totalPages => throw _privateConstructorUsedError;
  List<UnsplashPhoto> get results => throw _privateConstructorUsedError;

  /// Serializes this UnsplashSearchResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UnsplashSearchResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UnsplashSearchResponseCopyWith<UnsplashSearchResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnsplashSearchResponseCopyWith<$Res> {
  factory $UnsplashSearchResponseCopyWith(UnsplashSearchResponse value,
          $Res Function(UnsplashSearchResponse) then) =
      _$UnsplashSearchResponseCopyWithImpl<$Res, UnsplashSearchResponse>;
  @useResult
  $Res call(
      {int total,
      @JsonKey(name: 'total_pages') int totalPages,
      List<UnsplashPhoto> results});
}

/// @nodoc
class _$UnsplashSearchResponseCopyWithImpl<$Res,
        $Val extends UnsplashSearchResponse>
    implements $UnsplashSearchResponseCopyWith<$Res> {
  _$UnsplashSearchResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UnsplashSearchResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? totalPages = null,
    Object? results = null,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<UnsplashPhoto>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UnsplashSearchResponseImplCopyWith<$Res>
    implements $UnsplashSearchResponseCopyWith<$Res> {
  factory _$$UnsplashSearchResponseImplCopyWith(
          _$UnsplashSearchResponseImpl value,
          $Res Function(_$UnsplashSearchResponseImpl) then) =
      __$$UnsplashSearchResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int total,
      @JsonKey(name: 'total_pages') int totalPages,
      List<UnsplashPhoto> results});
}

/// @nodoc
class __$$UnsplashSearchResponseImplCopyWithImpl<$Res>
    extends _$UnsplashSearchResponseCopyWithImpl<$Res,
        _$UnsplashSearchResponseImpl>
    implements _$$UnsplashSearchResponseImplCopyWith<$Res> {
  __$$UnsplashSearchResponseImplCopyWithImpl(
      _$UnsplashSearchResponseImpl _value,
      $Res Function(_$UnsplashSearchResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of UnsplashSearchResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? totalPages = null,
    Object? results = null,
  }) {
    return _then(_$UnsplashSearchResponseImpl(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<UnsplashPhoto>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnsplashSearchResponseImpl implements _UnsplashSearchResponse {
  const _$UnsplashSearchResponseImpl(
      {required this.total,
      @JsonKey(name: 'total_pages') required this.totalPages,
      required final List<UnsplashPhoto> results})
      : _results = results;

  factory _$UnsplashSearchResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnsplashSearchResponseImplFromJson(json);

  @override
  final int total;
  @override
  @JsonKey(name: 'total_pages')
  final int totalPages;
  final List<UnsplashPhoto> _results;
  @override
  List<UnsplashPhoto> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'UnsplashSearchResponse(total: $total, totalPages: $totalPages, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnsplashSearchResponseImpl &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, total, totalPages,
      const DeepCollectionEquality().hash(_results));

  /// Create a copy of UnsplashSearchResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnsplashSearchResponseImplCopyWith<_$UnsplashSearchResponseImpl>
      get copyWith => __$$UnsplashSearchResponseImplCopyWithImpl<
          _$UnsplashSearchResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UnsplashSearchResponseImplToJson(
      this,
    );
  }
}

abstract class _UnsplashSearchResponse implements UnsplashSearchResponse {
  const factory _UnsplashSearchResponse(
          {required final int total,
          @JsonKey(name: 'total_pages') required final int totalPages,
          required final List<UnsplashPhoto> results}) =
      _$UnsplashSearchResponseImpl;

  factory _UnsplashSearchResponse.fromJson(Map<String, dynamic> json) =
      _$UnsplashSearchResponseImpl.fromJson;

  @override
  int get total;
  @override
  @JsonKey(name: 'total_pages')
  int get totalPages;
  @override
  List<UnsplashPhoto> get results;

  /// Create a copy of UnsplashSearchResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnsplashSearchResponseImplCopyWith<_$UnsplashSearchResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UnsplashPhoto _$UnsplashPhotoFromJson(Map<String, dynamic> json) {
  return _UnsplashPhoto.fromJson(json);
}

/// @nodoc
mixin _$UnsplashPhoto {
  String get id => throw _privateConstructorUsedError;
  UnsplashUrls get urls => throw _privateConstructorUsedError;
  UnsplashUser get user => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'alt_description')
  String? get altDescription => throw _privateConstructorUsedError;
  int get likes => throw _privateConstructorUsedError;

  /// Serializes this UnsplashPhoto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UnsplashPhoto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UnsplashPhotoCopyWith<UnsplashPhoto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnsplashPhotoCopyWith<$Res> {
  factory $UnsplashPhotoCopyWith(
          UnsplashPhoto value, $Res Function(UnsplashPhoto) then) =
      _$UnsplashPhotoCopyWithImpl<$Res, UnsplashPhoto>;
  @useResult
  $Res call(
      {String id,
      UnsplashUrls urls,
      UnsplashUser user,
      String? description,
      @JsonKey(name: 'alt_description') String? altDescription,
      int likes});

  $UnsplashUrlsCopyWith<$Res> get urls;
  $UnsplashUserCopyWith<$Res> get user;
}

/// @nodoc
class _$UnsplashPhotoCopyWithImpl<$Res, $Val extends UnsplashPhoto>
    implements $UnsplashPhotoCopyWith<$Res> {
  _$UnsplashPhotoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UnsplashPhoto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? urls = null,
    Object? user = null,
    Object? description = freezed,
    Object? altDescription = freezed,
    Object? likes = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      urls: null == urls
          ? _value.urls
          : urls // ignore: cast_nullable_to_non_nullable
              as UnsplashUrls,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UnsplashUser,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      altDescription: freezed == altDescription
          ? _value.altDescription
          : altDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of UnsplashPhoto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UnsplashUrlsCopyWith<$Res> get urls {
    return $UnsplashUrlsCopyWith<$Res>(_value.urls, (value) {
      return _then(_value.copyWith(urls: value) as $Val);
    });
  }

  /// Create a copy of UnsplashPhoto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UnsplashUserCopyWith<$Res> get user {
    return $UnsplashUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UnsplashPhotoImplCopyWith<$Res>
    implements $UnsplashPhotoCopyWith<$Res> {
  factory _$$UnsplashPhotoImplCopyWith(
          _$UnsplashPhotoImpl value, $Res Function(_$UnsplashPhotoImpl) then) =
      __$$UnsplashPhotoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      UnsplashUrls urls,
      UnsplashUser user,
      String? description,
      @JsonKey(name: 'alt_description') String? altDescription,
      int likes});

  @override
  $UnsplashUrlsCopyWith<$Res> get urls;
  @override
  $UnsplashUserCopyWith<$Res> get user;
}

/// @nodoc
class __$$UnsplashPhotoImplCopyWithImpl<$Res>
    extends _$UnsplashPhotoCopyWithImpl<$Res, _$UnsplashPhotoImpl>
    implements _$$UnsplashPhotoImplCopyWith<$Res> {
  __$$UnsplashPhotoImplCopyWithImpl(
      _$UnsplashPhotoImpl _value, $Res Function(_$UnsplashPhotoImpl) _then)
      : super(_value, _then);

  /// Create a copy of UnsplashPhoto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? urls = null,
    Object? user = null,
    Object? description = freezed,
    Object? altDescription = freezed,
    Object? likes = null,
  }) {
    return _then(_$UnsplashPhotoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      urls: null == urls
          ? _value.urls
          : urls // ignore: cast_nullable_to_non_nullable
              as UnsplashUrls,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UnsplashUser,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      altDescription: freezed == altDescription
          ? _value.altDescription
          : altDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnsplashPhotoImpl implements _UnsplashPhoto {
  const _$UnsplashPhotoImpl(
      {required this.id,
      required this.urls,
      required this.user,
      this.description,
      @JsonKey(name: 'alt_description') this.altDescription,
      this.likes = 0});

  factory _$UnsplashPhotoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnsplashPhotoImplFromJson(json);

  @override
  final String id;
  @override
  final UnsplashUrls urls;
  @override
  final UnsplashUser user;
  @override
  final String? description;
  @override
  @JsonKey(name: 'alt_description')
  final String? altDescription;
  @override
  @JsonKey()
  final int likes;

  @override
  String toString() {
    return 'UnsplashPhoto(id: $id, urls: $urls, user: $user, description: $description, altDescription: $altDescription, likes: $likes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnsplashPhotoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.urls, urls) || other.urls == urls) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.altDescription, altDescription) ||
                other.altDescription == altDescription) &&
            (identical(other.likes, likes) || other.likes == likes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, urls, user, description, altDescription, likes);

  /// Create a copy of UnsplashPhoto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnsplashPhotoImplCopyWith<_$UnsplashPhotoImpl> get copyWith =>
      __$$UnsplashPhotoImplCopyWithImpl<_$UnsplashPhotoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UnsplashPhotoImplToJson(
      this,
    );
  }
}

abstract class _UnsplashPhoto implements UnsplashPhoto {
  const factory _UnsplashPhoto(
      {required final String id,
      required final UnsplashUrls urls,
      required final UnsplashUser user,
      final String? description,
      @JsonKey(name: 'alt_description') final String? altDescription,
      final int likes}) = _$UnsplashPhotoImpl;

  factory _UnsplashPhoto.fromJson(Map<String, dynamic> json) =
      _$UnsplashPhotoImpl.fromJson;

  @override
  String get id;
  @override
  UnsplashUrls get urls;
  @override
  UnsplashUser get user;
  @override
  String? get description;
  @override
  @JsonKey(name: 'alt_description')
  String? get altDescription;
  @override
  int get likes;

  /// Create a copy of UnsplashPhoto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnsplashPhotoImplCopyWith<_$UnsplashPhotoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UnsplashUrls _$UnsplashUrlsFromJson(Map<String, dynamic> json) {
  return _UnsplashUrls.fromJson(json);
}

/// @nodoc
mixin _$UnsplashUrls {
  String get raw => throw _privateConstructorUsedError;
  String get full => throw _privateConstructorUsedError;
  String get regular =>
      throw _privateConstructorUsedError; // 1080px — use para exibir
  String get small =>
      throw _privateConstructorUsedError; // 400px — use no detalhe
  String get thumb => throw _privateConstructorUsedError;

  /// Serializes this UnsplashUrls to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UnsplashUrls
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UnsplashUrlsCopyWith<UnsplashUrls> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnsplashUrlsCopyWith<$Res> {
  factory $UnsplashUrlsCopyWith(
          UnsplashUrls value, $Res Function(UnsplashUrls) then) =
      _$UnsplashUrlsCopyWithImpl<$Res, UnsplashUrls>;
  @useResult
  $Res call(
      {String raw, String full, String regular, String small, String thumb});
}

/// @nodoc
class _$UnsplashUrlsCopyWithImpl<$Res, $Val extends UnsplashUrls>
    implements $UnsplashUrlsCopyWith<$Res> {
  _$UnsplashUrlsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UnsplashUrls
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? raw = null,
    Object? full = null,
    Object? regular = null,
    Object? small = null,
    Object? thumb = null,
  }) {
    return _then(_value.copyWith(
      raw: null == raw
          ? _value.raw
          : raw // ignore: cast_nullable_to_non_nullable
              as String,
      full: null == full
          ? _value.full
          : full // ignore: cast_nullable_to_non_nullable
              as String,
      regular: null == regular
          ? _value.regular
          : regular // ignore: cast_nullable_to_non_nullable
              as String,
      small: null == small
          ? _value.small
          : small // ignore: cast_nullable_to_non_nullable
              as String,
      thumb: null == thumb
          ? _value.thumb
          : thumb // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UnsplashUrlsImplCopyWith<$Res>
    implements $UnsplashUrlsCopyWith<$Res> {
  factory _$$UnsplashUrlsImplCopyWith(
          _$UnsplashUrlsImpl value, $Res Function(_$UnsplashUrlsImpl) then) =
      __$$UnsplashUrlsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String raw, String full, String regular, String small, String thumb});
}

/// @nodoc
class __$$UnsplashUrlsImplCopyWithImpl<$Res>
    extends _$UnsplashUrlsCopyWithImpl<$Res, _$UnsplashUrlsImpl>
    implements _$$UnsplashUrlsImplCopyWith<$Res> {
  __$$UnsplashUrlsImplCopyWithImpl(
      _$UnsplashUrlsImpl _value, $Res Function(_$UnsplashUrlsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UnsplashUrls
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? raw = null,
    Object? full = null,
    Object? regular = null,
    Object? small = null,
    Object? thumb = null,
  }) {
    return _then(_$UnsplashUrlsImpl(
      raw: null == raw
          ? _value.raw
          : raw // ignore: cast_nullable_to_non_nullable
              as String,
      full: null == full
          ? _value.full
          : full // ignore: cast_nullable_to_non_nullable
              as String,
      regular: null == regular
          ? _value.regular
          : regular // ignore: cast_nullable_to_non_nullable
              as String,
      small: null == small
          ? _value.small
          : small // ignore: cast_nullable_to_non_nullable
              as String,
      thumb: null == thumb
          ? _value.thumb
          : thumb // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnsplashUrlsImpl implements _UnsplashUrls {
  const _$UnsplashUrlsImpl(
      {required this.raw,
      required this.full,
      required this.regular,
      required this.small,
      required this.thumb});

  factory _$UnsplashUrlsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnsplashUrlsImplFromJson(json);

  @override
  final String raw;
  @override
  final String full;
  @override
  final String regular;
// 1080px — use para exibir
  @override
  final String small;
// 400px — use no detalhe
  @override
  final String thumb;

  @override
  String toString() {
    return 'UnsplashUrls(raw: $raw, full: $full, regular: $regular, small: $small, thumb: $thumb)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnsplashUrlsImpl &&
            (identical(other.raw, raw) || other.raw == raw) &&
            (identical(other.full, full) || other.full == full) &&
            (identical(other.regular, regular) || other.regular == regular) &&
            (identical(other.small, small) || other.small == small) &&
            (identical(other.thumb, thumb) || other.thumb == thumb));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, raw, full, regular, small, thumb);

  /// Create a copy of UnsplashUrls
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnsplashUrlsImplCopyWith<_$UnsplashUrlsImpl> get copyWith =>
      __$$UnsplashUrlsImplCopyWithImpl<_$UnsplashUrlsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UnsplashUrlsImplToJson(
      this,
    );
  }
}

abstract class _UnsplashUrls implements UnsplashUrls {
  const factory _UnsplashUrls(
      {required final String raw,
      required final String full,
      required final String regular,
      required final String small,
      required final String thumb}) = _$UnsplashUrlsImpl;

  factory _UnsplashUrls.fromJson(Map<String, dynamic> json) =
      _$UnsplashUrlsImpl.fromJson;

  @override
  String get raw;
  @override
  String get full;
  @override
  String get regular; // 1080px — use para exibir
  @override
  String get small; // 400px — use no detalhe
  @override
  String get thumb;

  /// Create a copy of UnsplashUrls
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnsplashUrlsImplCopyWith<_$UnsplashUrlsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UnsplashUser _$UnsplashUserFromJson(Map<String, dynamic> json) {
  return _UnsplashUser.fromJson(json);
}

/// @nodoc
mixin _$UnsplashUser {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;

  /// Serializes this UnsplashUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UnsplashUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UnsplashUserCopyWith<UnsplashUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnsplashUserCopyWith<$Res> {
  factory $UnsplashUserCopyWith(
          UnsplashUser value, $Res Function(UnsplashUser) then) =
      _$UnsplashUserCopyWithImpl<$Res, UnsplashUser>;
  @useResult
  $Res call({String id, String name, String username});
}

/// @nodoc
class _$UnsplashUserCopyWithImpl<$Res, $Val extends UnsplashUser>
    implements $UnsplashUserCopyWith<$Res> {
  _$UnsplashUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UnsplashUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? username = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UnsplashUserImplCopyWith<$Res>
    implements $UnsplashUserCopyWith<$Res> {
  factory _$$UnsplashUserImplCopyWith(
          _$UnsplashUserImpl value, $Res Function(_$UnsplashUserImpl) then) =
      __$$UnsplashUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String username});
}

/// @nodoc
class __$$UnsplashUserImplCopyWithImpl<$Res>
    extends _$UnsplashUserCopyWithImpl<$Res, _$UnsplashUserImpl>
    implements _$$UnsplashUserImplCopyWith<$Res> {
  __$$UnsplashUserImplCopyWithImpl(
      _$UnsplashUserImpl _value, $Res Function(_$UnsplashUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of UnsplashUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? username = null,
  }) {
    return _then(_$UnsplashUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnsplashUserImpl implements _UnsplashUser {
  const _$UnsplashUserImpl(
      {required this.id, required this.name, required this.username});

  factory _$UnsplashUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnsplashUserImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String username;

  @override
  String toString() {
    return 'UnsplashUser(id: $id, name: $name, username: $username)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnsplashUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, username);

  /// Create a copy of UnsplashUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnsplashUserImplCopyWith<_$UnsplashUserImpl> get copyWith =>
      __$$UnsplashUserImplCopyWithImpl<_$UnsplashUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UnsplashUserImplToJson(
      this,
    );
  }
}

abstract class _UnsplashUser implements UnsplashUser {
  const factory _UnsplashUser(
      {required final String id,
      required final String name,
      required final String username}) = _$UnsplashUserImpl;

  factory _UnsplashUser.fromJson(Map<String, dynamic> json) =
      _$UnsplashUserImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get username;

  /// Create a copy of UnsplashUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnsplashUserImplCopyWith<_$UnsplashUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
