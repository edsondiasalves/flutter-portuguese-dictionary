import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/service/definition_service.dart';

void main() {
  group('Definitions service', () {
    test('get definitions', () async {
      //Arrange
      final service = DefinitionService();

      //Act
      final definitions = await service.getAllEntries();

      //Assert
      expect(definitions.length, 2);
    });
  });
}
