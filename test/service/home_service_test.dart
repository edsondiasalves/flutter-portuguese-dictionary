import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/services/home_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Home service', () {
    setUp(() {});

    test('get home articles', () async {
      //Arrange
      final service = HomeService();

      //Act
      final articles = await service.getHomeArticles();

      //Assert
      expect(articles.length, 2);
      final first = articles.first;
      final last = articles.last;

      expect(first.title, 'Português do Brasil');
      expect(first.imageUrl, isNotNull);
      expect(first.content, isNotNull);

      expect(last.title, 'Português de Portugal');
      expect(last.imageUrl, isNotNull);
      expect(last.content, isNotNull);
    });
  });
}
