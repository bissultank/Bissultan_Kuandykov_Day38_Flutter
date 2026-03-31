import '../../domain/note.dart';
import '../dto/note_dto.dart';

extension NoteDtoMapper on NoteDto {
  /// Маппинг DTO → Domain с обработкой 3 кейсов
  Note toDomain() {
    // Кейс 1: нормальные данные
    if (title != null && content != null && id.isNotEmpty) {
      return Note(
        id: id,
        title: title!,
        content: content!,
        createdAt: createdAt != null
            ? DateTime.fromMillisecondsSinceEpoch(createdAt!)
            : DateTime.now(),
      );
    }

    // Кейс 2: пустые / некорректные данные
    if (id.isEmpty || title == null || content == null) {
      return Note(
        id: id.isNotEmpty
            ? id
            : 'unknown_${DateTime.now().millisecondsSinceEpoch}',
        title: title ?? 'Без названия',
        content: content ?? 'Содержимое отсутствует',
        createdAt: DateTime.now(),
      );
    }

    // Кейс 3: полностью некорректные (fallback)
    return Note(
      id: 'error_${DateTime.now().millisecondsSinceEpoch}',
      title: 'Ошибка данных',
      content: 'Данные не удалось преобразовать',
      createdAt: DateTime.now(),
    );
  }
}

extension NoteMapper on Note {
  NoteDto toDto() {
    return NoteDto(
      id: id,
      title: title,
      content: content,
      createdAt: createdAt.millisecondsSinceEpoch,
    );
  }
}
