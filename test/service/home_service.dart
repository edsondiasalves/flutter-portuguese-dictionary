import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/services/home_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Home service', () {
    test('get home articles', () async {
      //Arrange
      final service = HomeService();

      //Act
      final articles = await service.getHomeArticles();

      //Assert
      expect(articles.length, 2);
      expect(articles[0].title != null, true);
      expect(articles[0].imageUrl != null, true);
      expect(articles[0].content != null, true);

      expect(articles[1].title != null, true);
      expect(articles[1].imageUrl != null, true);
      expect(articles[1].content != null, true);
    });
  });
}
