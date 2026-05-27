// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appDatabaseHash() => r'96b544ff7ce456f0fc1edbdafdf332306a9affed';

/// See also [appDatabase].
@ProviderFor(appDatabase)
final appDatabaseProvider = Provider<AppDatabase>.internal(
  appDatabase,
  name: r'appDatabaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppDatabaseRef = ProviderRef<AppDatabase>;
String _$photoRepositoryHash() => r'800c4c9c814da2e6d87383cc3a15f2f1d46e7ec3';

/// See also [photoRepository].
@ProviderFor(photoRepository)
final photoRepositoryProvider = FutureProvider<PhotoRepository>.internal(
  photoRepository,
  name: r'photoRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$photoRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PhotoRepositoryRef = FutureProviderRef<PhotoRepository>;
String _$photoGalleryStreamHash() =>
    r'712233e7d780e30d08c03ec8482a8219df335ad7';

/// See also [photoGalleryStream].
@ProviderFor(photoGalleryStream)
final photoGalleryStreamProvider =
    AutoDisposeStreamProvider<List<Photo>>.internal(
  photoGalleryStream,
  name: r'photoGalleryStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$photoGalleryStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PhotoGalleryStreamRef = AutoDisposeStreamProviderRef<List<Photo>>;
String _$filteredPhotosHash() => r'394f617c5a48438898085b882256ef485a8f135b';

/// See also [filteredPhotos].
@ProviderFor(filteredPhotos)
final filteredPhotosProvider = AutoDisposeProvider<List<Photo>>.internal(
  filteredPhotos,
  name: r'filteredPhotosProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredPhotosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredPhotosRef = AutoDisposeProviderRef<List<Photo>>;
String _$photoGalleryHash() => r'747b82f51382ad8cd328a55c1c63c6c16227de14';

/// See also [PhotoGallery].
@ProviderFor(PhotoGallery)
final photoGalleryProvider =
    AutoDisposeAsyncNotifierProvider<PhotoGallery, List<Photo>>.internal(
  PhotoGallery.new,
  name: r'photoGalleryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$photoGalleryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PhotoGallery = AutoDisposeAsyncNotifier<List<Photo>>;
String _$photoFilterHash() => r'0c3fa265c95470ab2d29047b915f3dee7caead2f';

/// See also [PhotoFilter].
@ProviderFor(PhotoFilter)
final photoFilterProvider =
    AutoDisposeNotifierProvider<PhotoFilter, PhotoFilterState>.internal(
  PhotoFilter.new,
  name: r'photoFilterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$photoFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PhotoFilter = AutoDisposeNotifier<PhotoFilterState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
