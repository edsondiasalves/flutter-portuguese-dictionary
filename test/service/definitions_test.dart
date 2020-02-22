import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/service/definition_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Definitions service', () {
    test('get all definitions', () async {
      //Arrange
      final service = DefinitionService();

      //Act
      final definitions = await service.getAllEntries();

      //Assert
      expect(definitions.length, 2);
    });

    test('get definitions by language', () async {
      //Arrange
      final service = DefinitionService();

      //Act
      final definitions = await service.getEntriesByTerms("Agrafador");

      //Assert
      expect(definitions.length, 1);
    });
  });
}
