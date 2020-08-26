import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portuguese_dictionary/services/home_service.dart';

class MockCollectionReference extends Mock implements CollectionReference {}

class MockQuerySnapshot extends Mock implements QuerySnapshot {}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Home service', () {
    final CollectionReference mockColRef = MockCollectionReference();
    final QuerySnapshot mockQuerySnapshot = MockQuerySnapshot();
    final DocumentSnapshot mockDocumentSnapshot1 = MockDocumentSnapshot();
    final DocumentSnapshot mockDocumentSnapshot2 = MockDocumentSnapshot();

    setUp(() {
      when(mockColRef.getDocuments()).thenAnswer(
        (_) => Future.value(mockQuerySnapshot),
      );

      when(mockQuerySnapshot.documents).thenReturn(
        [mockDocumentSnapshot1, mockDocumentSnapshot2],
      );

      when(mockDocumentSnapshot1.data).thenReturn(
        {
          'title': 'title1',
          'imageUrl': 'imageUrl1',
          'content': 'content1',
        },
      );

      when(mockDocumentSnapshot2.data).thenReturn(
        {
          'title': 'title2',
          'imageUrl': 'imageUrl2',
          'content': 'content2',
        },
      );
    });

    test('get home articles', () async {
      //Arrange
      final service = HomeService(collection: mockColRef);

      //Act
      final articles = await service.getHomeArticles();

      //Assert
      expect(articles.length, 2);
      final first = articles.first;
      final last = articles.last;

      expect(first.title, 'title1');
      expect(first.imageUrl, 'imageUrl1');
      expect(first.content, 'content1');

      expect(last.title, 'title2');
      expect(last.imageUrl, 'imageUrl2');
      expect(last.content, 'content2');
    });

    test('insert articles', () async {
      //Arrange
      final service = HomeService(collection: mockColRef);

      //Act
      await service.insertArticlesFromFile();

      //Assert
      expect(true, true);
    });
  });
}
