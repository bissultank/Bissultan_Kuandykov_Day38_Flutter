// lib/data/repository/notes_repository_impl.dart
import '../../domain/note.dart';
import '../../domain/notes_repository.dart';
import '../datasource/local_data_source.dart';
import '../datasource/remote_data_source.dart';
import '../mapper/note_mapper.dart';

class NotesRepositoryImpl implements NotesRepository {
  final LocalDataSource local;
  final RemoteDataSource remote;

  NotesRepositoryImpl({required this.local, required this.remote});

  // Самая простая логика: берём ТОЛЬКО из локального кэша
  @override
  Future<List<Note>> getNotes() async {
    return await local.getAll(); // ← всегда локальный кэш
  }

  // Обновление с сервера ТОЛЬКО по кнопке
  @override
  Future<void> refresh() async {
    final remoteDtos = await remote.getNotes();
    final notes = remoteDtos.map((dto) => dto.toDomain()).toList();
    await local.saveAll(notes);
  }

  @override
  Future<void> addNote(Note note) async {
    await local.add(note);
  }

  @override
  Future<void> updateNote(Note note) async {
    await local.update(note);
  }

  @override
  Future<void> deleteNote(String id) async {
    await local.delete(id);
  }
}
