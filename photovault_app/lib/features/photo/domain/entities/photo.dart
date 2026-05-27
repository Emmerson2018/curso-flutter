import 'package:freezed_annotation/freezed_annotation.dart';
part 'photo.freezed.dart';

// @freezed gera: copyWith, ==, hashCode, toString — imutável
@freezed
abstract class Photo with _$Photo {
  const factory Photo({
    required String   id,
    required String   localPath,
    required DateTime createdAt,
             String?  caption,
             String?  audioDescription,
             String?  remoteUrl,
             String?  photographerName,
    @Default(false) bool isFavorite,
  }) = _Photo;
}

enum SortOrder {
  newest('Mais recentes'), oldest('Mais antigas');
  const SortOrder(this.label);
  final String label;
}

@freezed
abstract class PhotoFilterState with _$PhotoFilterState {
  const factory PhotoFilterState({
    @Default('')               String    searchQuery,
    @Default(SortOrder.newest) SortOrder sortOrder,
  }) = _PhotoFilterState;
  factory PhotoFilterState.initial() => const PhotoFilterState();
}