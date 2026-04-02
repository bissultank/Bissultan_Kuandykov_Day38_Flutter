import '../note.dart';
import '../notes_repository.dart';

class AddNoteUseCase {
  final NotesRepository _repository;

  AddNoteUseCase(this._repository);

  Future<void> call(Note note) async {
    if (note.title.trim().isEmpty) {
      throw Exception('Title cannot be empty');
    }
    await _repository.addNote(note);
  }
}
