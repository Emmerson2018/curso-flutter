// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppSettings)
final appSettingsProvider = AppSettingsProvider._();

final class AppSettingsProvider
    extends $AsyncNotifierProvider<AppSettings, SettingsData> {
  AppSettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appSettingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appSettingsHash();

  @$internal
  @override
  AppSettings create() => AppSettings();
}

String _$appSettingsHash() => r'f36be5fa414640081e1575e1cc61e136133b5189';

abstract class _$AppSettings extends $AsyncNotifier<SettingsData> {
  FutureOr<SettingsData> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SettingsData>, SettingsData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SettingsData>, SettingsData>,
              AsyncValue<SettingsData>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
