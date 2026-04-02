import 'package:flutter_test/flutter_test.dart';
import 'package:notes_clean_architecture/data/mapper/note_mapper.dart';
import 'fixtures/note_fixtures.dart';

void main() {
  group('NoteDto → Note (Mapper)', () {
    test('1. Happy path: все поля корректно маппятся', () {
      final dto = NoteFixtures.valid;
      final domain = dto.toDomain();

      expect(domain.id, '1');
      expect(domain.title, 'Купить молоко');
      expect(domain.content, '2 литра');
      expect(domain.createdAt.millisecondsSinceEpoch, dto.createdAt);
    });

    test('2. null title → fallback title', () {
      final dto = NoteFixtures.nullTitle;
      final domain = dto.toDomain();
      expect(domain.title, 'Без названия');
      expect(domain.content, 'Контент есть');
    });

    test('3. null createdAt → createdAt заполняется текущим временем', () {
      final dto = NoteFixtures.nullCreatedAt;
      final domain = dto.toDomain();
      expect(
        domain.createdAt.isAfter(DateTime.now().subtract(const Duration(seconds: 5))),
        true,
      );
    });

    test('4. Пустой title остается валидным значением', () {
      final dto = NoteFixtures.emptyTitle;
      final domain = dto.toDomain();
      expect(domain.title, '');
      expect(domain.content, 'Пустой title');
    });

    test('5. Пустой id → fallback id с префиксом unknown_', () {
      final dto = NoteFixtures.emptyId;
      final domain = dto.toDomain();
      expect(domain.id.startsWith('unknown_'), true);
      expect(domain.title, 'Без id');
    });
  });
}
