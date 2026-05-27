// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_remote_ds.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(photoRemoteDs)
final photoRemoteDsProvider = PhotoRemoteDsProvider._();

final class PhotoRemoteDsProvider
    extends
        $FunctionalProvider<
          AsyncValue<PhotoRemoteDataSource>,
          PhotoRemoteDataSource,
          FutureOr<PhotoRemoteDataSource>
        >
    with
        $FutureModifier<PhotoRemoteDataSource>,
        $FutureProvider<PhotoRemoteDataSource> {
  PhotoRemoteDsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photoRemoteDsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photoRemoteDsHash();

  @$internal
  @override
  $FutureProviderElement<PhotoRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PhotoRemoteDataSource> create(Ref ref) {
    return photoRemoteDs(ref);
  }
}

String _$photoRemoteDsHash() => r'ec4ab91ed9cbbf91c6b7a9718e54d2a490c7819d';

@ProviderFor(UnsplashSearch)
final unsplashSearchProvider = UnsplashSearchProvider._();

final class UnsplashSearchProvider
    extends $AsyncNotifierProvider<UnsplashSearch, List<UnsplashPhoto>> {
  UnsplashSearchProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unsplashSearchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unsplashSearchHash();

  @$internal
  @override
  UnsplashSearch create() => UnsplashSearch();
}

String _$unsplashSearchHash() => r'a88a2f0112c16add93fbc31734f53b7519137e77';

abstract class _$UnsplashSearch extends $AsyncNotifier<List<UnsplashPhoto>> {
  FutureOr<List<UnsplashPhoto>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<UnsplashPhoto>>, List<UnsplashPhoto>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<UnsplashPhoto>>, List<UnsplashPhoto>>,
              AsyncValue<List<UnsplashPhoto>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
