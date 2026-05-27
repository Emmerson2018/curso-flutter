// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_remote_ds.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$photoRemoteDsHash() => r'15f37a2d2dd3f85a3b82ebc180995a09d2acbee2';

/// See also [photoRemoteDs].
@ProviderFor(photoRemoteDs)
final photoRemoteDsProvider = FutureProvider<PhotoRemoteDataSource>.internal(
  photoRemoteDs,
  name: r'photoRemoteDsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$photoRemoteDsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PhotoRemoteDsRef = FutureProviderRef<PhotoRemoteDataSource>;
String _$unsplashSearchHash() => r'383d6e94ab0233edca72ac8bef5e4a17d80eaae3';

/// See also [UnsplashSearch].
@ProviderFor(UnsplashSearch)
final unsplashSearchProvider = AutoDisposeAsyncNotifierProvider<UnsplashSearch,
    List<UnsplashPhoto>>.internal(
  UnsplashSearch.new,
  name: r'unsplashSearchProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$unsplashSearchHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UnsplashSearch = AutoDisposeAsyncNotifier<List<UnsplashPhoto>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
