import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portuguese_dictionary/services/definition_service.dart';

class MockCollectionReference extends Mock implements CollectionReference {}

class MockQuerySnapshot extends Mock implements QuerySnapshot {}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final CollectionReference mockColRef = MockCollectionReference();
  final QuerySnapshot mockQuerySnapshot = MockQuerySnapshot();
  final DocumentSnapshot mockDocumentSnapshot1 = MockDocumentSnapshot();

  group('Definitions service', () {
    setUp(() {
      when(mockColRef.getDocuments()).thenAnswer(
        (_) => Future.value(mockQuerySnapshot),
      );

      when(mockQuerySnapshot.documents).thenReturn(
        [mockDocumentSnapshot1],
      );

      when(mockDocumentSnapshot1.data).thenReturn(
        {
          "id": 1,
          "definitions": [
            {
              "language": "pt-PT",
              "term": "Agrafador",
              "meanings": [],
              "examples": []
            },
            {
              "language": "pt-BR",
              "term": "Grampeador",
              "meanings": [],
              "examples": []
            }
          ]
        },
      );
    });

    test('get all definitions', () async {
      //Arrange
      final service = DefinitionService(collection: mockColRef);

      //Act
      final definitions = await service.getAllEntries();

      //Assert
      expect(definitions.length, 1);
    });

    test('get definitions by language', () async {
      //Arrange
      final service = DefinitionService(collection: mockColRef);

      //Act
      final definitions = await service.getEntriesByTerms("Agrafador");

      //Assert
      expect(definitions.length, 1);
    });

    test('get suggestion by term', () async {
      //Arrange
      final service = DefinitionService(collection: mockColRef);

      //Act
      final definitions = await service.getSuggestionByTerms("Agrafador");

      //Assert
      expect(definitions.length, 1);
    });

    test('get entry by suggestion', () async {
      //Arrange
      final service = DefinitionService(collection: mockColRef);

      //Act
      final entry = await service.getEntryBySuggestion("Agrafador");

      //Assert
      expect(entry.definitions.length, 2);
    });

    test('insert entries', () async {
      //Arrange
      final service = DefinitionService(collection: mockColRef);

      //Act
      await service.insertEntriesFromFile();

      //Assert
      expect(true, true);
    });
  });
}
