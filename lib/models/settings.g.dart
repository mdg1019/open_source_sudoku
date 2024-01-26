// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsImpl _$$SettingsImplFromJson(Map<String, dynamic> json) =>
    _$SettingsImpl(
      themeType: $enumDecode(_$SudokuThemeTypeEnumMap, json['theme_type']),
    );

Map<String, dynamic> _$$SettingsImplToJson(_$SettingsImpl instance) =>
    <String, dynamic>{
      'theme_type': _$SudokuThemeTypeEnumMap[instance.themeType]!,
    };

const _$SudokuThemeTypeEnumMap = {
  SudokuThemeType.light: 'light',
  SudokuThemeType.dark: 'dark',
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$settingsNotifierHash() => r'c6bf38d89cd54c1e6781b3be2ad73bbbcdafdc67';

/// See also [SettingsNotifier].
@ProviderFor(SettingsNotifier)
final settingsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<SettingsNotifier, Settings>.internal(
  SettingsNotifier.new,
  name: r'settingsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$settingsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SettingsNotifier = AutoDisposeAsyncNotifier<Settings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
