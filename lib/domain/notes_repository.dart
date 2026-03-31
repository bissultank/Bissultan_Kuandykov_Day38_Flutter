import 'note.dart';

abstract class NotesRepository {
  Future<List<Note>> getNotes();
  Future<void> addNote(Note note);
  Future<void> updateNote(Note note); // ← новое
  Future<void> deleteNote(String id); // ← новое
  Future<void> refresh();
}
