import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/services/definition_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Definitions service', () {
    test('get all definitions', () async {
      //Arrange
      final service = DefinitionService();

      //Act
      final definitions = await service.getAllEntries();

      //Assert
      expect(definitions.length, 292);
    });

    test('get definitions by language', () async {
      //Arrange
      final service = DefinitionService();

      //Act
      final definitions = await service.getEntriesByTerms("Agrafador");

      //Assert
      expect(definitions.length, 2);
    });

    test('get suggestion by term', () async {
      //Arrange
      final service = DefinitionService();

      //Act
      final definitions = await service.getSuggestionByTerms("Agrafador");

      //Assert
      expect(definitions.length, 1);
    });

    test('get entry by suggestion', () async {
      //Arrange
      final service = DefinitionService();

      //Act
      final entry = await service.getEntryBySuggestion("Agrafador");

      //Assert
      expect(entry.definitions.length, 2);
    });
  });
}
