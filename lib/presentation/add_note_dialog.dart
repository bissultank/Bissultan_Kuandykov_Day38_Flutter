// lib/presentation/add_note_dialog.dart
import 'package:flutter/material.dart';
import '../../domain/note.dart';

class AddNoteDialog extends StatefulWidget {
  final Note? noteToEdit; // если null — добавление, если есть — редактирование

  const AddNoteDialog({this.noteToEdit, super.key});

  @override
  State<AddNoteDialog> createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> {
  late final TextEditingController _titleCtrl;
  late final TextEditingController _contentCtrl;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.noteToEdit?.title ?? '');
    _contentCtrl =
        TextEditingController(text: widget.noteToEdit?.content ?? '');
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.noteToEdit != null;

    return AlertDialog(
      title: Text(isEditing ? 'Редактировать заметку' : 'Новая заметка'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleCtrl,
            decoration: const InputDecoration(labelText: 'Заголовок'),
          ),
          TextField(
            controller: _contentCtrl,
            decoration: const InputDecoration(labelText: 'Содержание'),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            final note = Note(
              id: widget.noteToEdit?.id ??
                  DateTime.now().millisecondsSinceEpoch.toString(),
              title: _titleCtrl.text.trim(),
              content: _contentCtrl.text.trim(),
              createdAt: widget.noteToEdit?.createdAt ?? DateTime.now(),
            );
            Navigator.pop(context, note);
          },
          child: Text(isEditing ? 'Сохранить' : 'Добавить'),
        ),
      ],
    );
  }
}
