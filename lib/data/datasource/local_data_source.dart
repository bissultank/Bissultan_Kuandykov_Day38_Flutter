// lib/data/datasource/local_data_source.dart
import 'package:hive_flutter/hive_flutter.dart';
import '../dto/note_dto.dart';
import '../../domain/note.dart';
import '../mapper/note_mapper.dart';

class LocalDataSource {
  static const String boxName = 'notes';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<List<dynamic>>(boxName);
  }

  Future<List<Note>> getAll() async {
    final box = Hive.box<List<dynamic>>(boxName);
    final rawList = box.get('notes', defaultValue: <dynamic>[]) ?? <dynamic>[];

    final List<Map<String, dynamic>> jsonList = rawList
        .whereType<Map<dynamic, dynamic>>()
        .map((map) => Map<String, dynamic>.from(map))
        .toList();

    final dtos = jsonList.map((json) => NoteDto.fromJson(json)).toList();
    return dtos.map((dto) => dto.toDomain()).toList();
  }

  Future<void> saveAll(List<Note> notes) async {
    final box = Hive.box<List<dynamic>>(boxName);
    final jsonList = notes.map((note) => note.toDto().toJson()).toList();
    await box.put('notes', jsonList);
  }

  Future<void> add(Note note) async {
    final current = await getAll();
    await saveAll([...current, note]);
  }

  // Новые методы
  Future<void> update(Note updatedNote) async {
    final current = await getAll();
    final index = current.indexWhere((n) => n.id == updatedNote.id);
    if (index != -1) {
      current[index] = updatedNote;
      await saveAll(current);
    }
  }

  Future<void> delete(String id) async {
    final current = await getAll();
    current.removeWhere((n) => n.id == id);
    await saveAll(current);
  }
}
