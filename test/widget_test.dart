import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:notes_clean_architecture/main.dart';
import 'package:notes_clean_architecture/domain/note.dart';
import 'package:notes_clean_architecture/domain/notes_repository.dart';

class FakeNotesRepository implements NotesRepository {
  @override
  Future<void> addNote(Note note) async {}

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
  testWidgets('MyApp показывает пустое состояние, если заметок нет', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      Provider<NotesRepository>.value(
        value: FakeNotesRepository(),
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Пока нет заметок\nДобавьте первую!'), findsOneWidget);
  });
}
