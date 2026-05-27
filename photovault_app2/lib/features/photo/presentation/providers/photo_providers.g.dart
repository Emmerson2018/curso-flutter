// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(photoRepository)
final photoRepositoryProvider = PhotoRepositoryProvider._();

final class PhotoRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<PhotoRepository>,
          PhotoRepository,
          FutureOr<PhotoRepository>
        >
    with $FutureModifier<PhotoRepository>, $FutureProvider<PhotoRepository> {
  PhotoRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photoRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photoRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<PhotoRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PhotoRepository> create(Ref ref) {
    return photoRepository(ref);
  }
}

String _$photoRepositoryHash() => r'1765c605b3b69226385d834c7343a10b335cf6eb';

@ProviderFor(photoGalleryStream)
final photoGalleryStreamProvider = PhotoGalleryStreamProvider._();

final class PhotoGalleryStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Photo>>,
          List<Photo>,
          Stream<List<Photo>>
        >
    with $FutureModifier<List<Photo>>, $StreamProvider<List<Photo>> {
  PhotoGalleryStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photoGalleryStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photoGalleryStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<Photo>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Photo>> create(Ref ref) {
    return photoGalleryStream(ref);
  }
}

String _$photoGalleryStreamHash() =>
    r'f467fe2aec39cd876bb7e6b74d8fc9a81c5c28a3';

@ProviderFor(PhotoGallery)
final photoGalleryProvider = PhotoGalleryProvider._();

final class PhotoGalleryProvider
    extends $AsyncNotifierProvider<PhotoGallery, List<Photo>> {
  PhotoGalleryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photoGalleryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photoGalleryHash();

  @$internal
  @override
  PhotoGallery create() => PhotoGallery();
}

String _$photoGalleryHash() => r'162acf040f4234be2425355da17c877298336cb0';

abstract class _$PhotoGallery extends $AsyncNotifier<List<Photo>> {
  FutureOr<List<Photo>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Photo>>, List<Photo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Photo>>, List<Photo>>,
              AsyncValue<List<Photo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(PhotoFilter)
final photoFilterProvider = PhotoFilterProvider._();

final class PhotoFilterProvider
    extends $NotifierProvider<PhotoFilter, PhotoFilterState> {
  PhotoFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photoFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photoFilterHash();

  @$internal
  @override
  PhotoFilter create() => PhotoFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhotoFilterState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhotoFilterState>(value),
    );
  }
}

String _$photoFilterHash() => r'0c3fa265c95470ab2d29047b915f3dee7caead2f';

abstract class _$PhotoFilter extends $Notifier<PhotoFilterState> {
  PhotoFilterState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PhotoFilterState, PhotoFilterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PhotoFilterState, PhotoFilterState>,
              PhotoFilterState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredPhotos)
final filteredPhotosProvider = FilteredPhotosProvider._();

final class FilteredPhotosProvider
    extends $FunctionalProvider<List<Photo>, List<Photo>, List<Photo>>
    with $Provider<List<Photo>> {
  FilteredPhotosProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredPhotosProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredPhotosHash();

  @$internal
  @override
  $ProviderElement<List<Photo>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Photo> create(Ref ref) {
    return filteredPhotos(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Photo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Photo>>(value),
    );
  }
}

String _$filteredPhotosHash() => r'666d521e10dde8ad307dec21fc35620db61e0764';
