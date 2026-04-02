import 'package:notes_clean_architecture/data/dto/note_dto.dart';
import 'package:notes_clean_architecture/domain/note.dart';

class NoteFixtures {
  static NoteDto get valid => NoteDto(
        id: '1',
        title: 'Купить молоко',
        content: '2 литра',
        createdAt: DateTime(2025, 4, 2).millisecondsSinceEpoch,
      );

  static NoteDto get nullTitle => NoteDto(
        id: '2',
        title: null,
        content: 'Контент есть',
        createdAt: DateTime(2025, 4, 2).millisecondsSinceEpoch,
      );

  static NoteDto get nullCreatedAt => NoteDto(
        id: '3',
        title: 'null createdAt',
        content: 'Без даты',
        createdAt: null,
      );

  static NoteDto get emptyTitle => NoteDto(
        id: '4',
        title: '',
        content: 'Пустой title',
        createdAt: DateTime(2025, 4, 2).millisecondsSinceEpoch,
      );

  static NoteDto get emptyId => NoteDto(
        id: '',
        title: 'Без id',
        content: 'Проверка fallback',
        createdAt: 0,
      );

  static NoteDto get futureDate => NoteDto(
        id: '6',
        title: 'Будущая заметка',
        content: 'План на будущее',
        createdAt: DateTime(2030, 12, 31).millisecondsSinceEpoch,
      );

  static Note get domainValid => Note(
        id: '10',
        title: 'Новая заметка',
        content: 'Текст заметки',
        createdAt: DateTime(2025, 4, 2),
      );

  static Note get domainEmptyTitle => Note(
        id: '11',
        title: '   ',
        content: 'Некорректная заметка',
        createdAt: DateTime(2025, 4, 2),
      );
}
