import 'package:flutter_test/flutter_test.dart';
import 'package:notes_clean_architecture/domain/note.dart';
import 'package:notes_clean_architecture/domain/notes_repository.dart';
import 'package:notes_clean_architecture/domain/usecases/add_note_usecase.dart';
import 'fixtures/note_fixtures.dart';

class FakeNotesRepository implements NotesRepository {
  bool addCalled = false;
  Note? addedNote;

  @override
  Future<void> addNote(Note note) async {
    addCalled = true;
    addedNote = note;
  }

  @override
  Future<void> deleteNote(String id) async {}

  @override
  Future<List<Note>> getNotes() async => [];

  @override
  Future<void> refresh() async {}

  @override
  Future<void> updateNote(Note note) async {}
}

void main() {
  late FakeNotesRepository fakeRepo;
  late AddNoteUseCase useCase;

  setUp(() {
    fakeRepo = FakeNotesRepository();
    useCase = AddNoteUseCase(fakeRepo);
  });

  test('AddNoteUseCase: happy path вызывает repository.addNote', () async {
    final note = NoteFixtures.domainValid;
    await useCase(note);
    expect(fakeRepo.addCalled, true);
    expect(fakeRepo.addedNote?.id, note.id);
  });

  test('AddNoteUseCase: ошибка при пустом title и правильное сообщение', () async {
    final note = NoteFixtures.domainEmptyTitle;

    expect(
      () => useCase(note),
      throwsA(
        isA<Exception>().having(
          (e) => e.toString().toLowerCase(),
          'message',
          contains('title cannot be empty'),
        ),
      ),
    );
    expect(fakeRepo.addCalled, false);
  });
}
