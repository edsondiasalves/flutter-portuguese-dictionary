import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portuguese_dictionary/services/definition_service.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock implements CollectionReference {}

class MockQuerySnapshot extends Mock implements QuerySnapshot {}

class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final FirebaseFirestore firebaseFirestore = MockFirebaseFirestore();
  final CollectionReference mockColRef = MockCollectionReference();
  final QuerySnapshot mockQuerySnapshot = MockQuerySnapshot();
  final QueryDocumentSnapshot mockDocumentSnapshot1 =
      MockQueryDocumentSnapshot();

  group('Definitions service', () {
    setUp(() {
      when(firebaseFirestore.collection('entries')).thenReturn(
        mockColRef,
      );

      when(mockColRef.get()).thenAnswer(
        (_) => Future.value(mockQuerySnapshot),
      );

      when(mockQuerySnapshot.docs).thenReturn(
        [mockDocumentSnapshot1],
      );

      when(mockDocumentSnapshot1.data()).thenReturn(
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
      final service = DefinitionService(firestore: firebaseFirestore);

      //Act
      final definitions = await service.getAllEntries();

      //Assert
      expect(definitions.length, 1);
    });

    test('get definitions by language', () async {
      //Arrange
      final service = DefinitionService(firestore: firebaseFirestore);

      //Act
      final definitions = await service.getEntriesByTerms("Agrafador");

      //Assert
      expect(definitions.length, 1);
    });

    test('get suggestion by term', () async {
      //Arrange
      final service = DefinitionService(firestore: firebaseFirestore);

      //Act
      final definitions = await service.getSuggestionByTerms("Agrafador");

      //Assert
      expect(definitions.length, 1);
    });

    test('get entry by suggestion', () async {
      //Arrange
      final service = DefinitionService(firestore: firebaseFirestore);

      //Act
      final entry = await service.getEntryBySuggestion("Agrafador");

      //Assert
      expect(entry.definitions.length, 2);
    });

    test('insert entries', () async {
      //Arrange
      final service = DefinitionService(firestore: firebaseFirestore);

      //Act
      final result = await service.insertEntriesFromFile();

      //Assert
      expect(true, result);
    });
  });
}
