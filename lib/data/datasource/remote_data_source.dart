// lib/data/datasource/remote_data_source.dart
import '../dto/note_dto.dart';

class RemoteDataSource {
  Future<List<NoteDto>> getNotes() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      NoteDto(
        id: '1',
        title: 'Купить молоко',
        content: '2 литра',
        createdAt: DateTime.now().millisecondsSinceEpoch - 86400000,
      ),
      NoteDto(
        id: '2',
        title: 'Сдать проект',
        content: 'Clean Architecture',
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),
    ];
  }

  Future<void> addNote(NoteDto dto) async =>
      Future.delayed(const Duration(milliseconds: 800));
  Future<void> updateNote(NoteDto dto) async =>
      Future.delayed(const Duration(milliseconds: 800));
  Future<void> deleteNote(String id) async =>
      Future.delayed(const Duration(milliseconds: 800));
}
