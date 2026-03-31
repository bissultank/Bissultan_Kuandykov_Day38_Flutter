// lib/presentation/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/note.dart';
import '../../domain/notes_repository.dart';
import 'add_note_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> _notes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final notes = await context.read<NotesRepository>().getNotes();
    if (!mounted) return;
    setState(() {
      _notes = notes;
      _isLoading = false;
    });
  }

  Future<void> _editNote(Note note) async {
    final updated = await showDialog<Note>(
      context: context,
      builder: (_) => AddNoteDialog(noteToEdit: note),
    );
    if (updated != null && mounted) {
      await context.read<NotesRepository>().updateNote(updated);
      _loadNotes();
    }
  }

  Future<void> _deleteNote(Note note) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Удалить?'),
        content: Text('«${note.title}»'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Отмена')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child:
                  const Text('Удалить', style: TextStyle(color: Colors.red))),
        ],
      ),
    );

    if (confirm == true && mounted) {
      await context.read<NotesRepository>().deleteNote(note.id);
      _loadNotes();
    }
  }

  Future<void> _addNote() async {
    final newNote = await showDialog<Note>(
      context: context,
      builder: (_) => const AddNoteDialog(),
    );
    if (newNote != null && mounted) {
      await context.read<NotesRepository>().addNote(newNote);
      _loadNotes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Планнер')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notes.isEmpty
              ? const Center(
                  child: Text(
                    'Пока нет заметок\nДобавьте первую!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _notes.length,
                  itemBuilder: (context, index) {
                    final note = _notes[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(note.title,
                            style: const TextStyle(fontSize: 17)),
                        subtitle: Text(note.content),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteNote(note),
                        ),
                        onTap: () => _editNote(note),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}
