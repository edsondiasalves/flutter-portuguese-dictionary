import 'package:portuguese_dictionary/model/model.dart';

class HomeService {
  Future<List<Article>> getHomeArticles() async {
    final List<Article> articles = [];
    articles.add(
      Article(
        title: 'Português do Brasil',
        imageUrl: 'assets/images/br_flag.png',
        content:
            'Português brasileiro ou português do Brasil (abreviado como pt-BR) é o termo utilizado para classificar a variedade da língua portuguesa falada pelos mais de 200 milhões de brasileiros que vivem dentro e fora do Brasil. A grande população brasileira, quando comparada com a dos demais países lusófonos, implica que o português brasileiro seja a variante do português mais falada, lida e escrita do mundo, 14 vezes mais que a variante do país de origem, Portugal.',
      ),
    );

    articles.add(
      Article(
        title: 'Português de Portugal',
        imageUrl: 'assets/images/pt_flag.png',
        content:
            'O português europeu, português lusitano, português continental ou português de Portugal é a designação dada à variedade linguística da língua portuguesa falada em Portugal, nos PALOP, em Timor-Leste, em Macau e pelos emigrantes portugueses, dos PALOP, de Timor-Leste e de Macau espalhados pelo mundo, englobando os seus dialectos regionais, vocabulário, gramática e ortografia ' +
                'De acordo com a legislação da União Europeia, o português é uma das línguas oficiais da União (sendo língua de trabalho do Parlamento Europeu, mas não da Comissão Europeia), pelo que em textos internacionais da União, bem como nos respectivos sítios oficiais, é usada a norma europeia.[4] Também é ensinado em Espanha, sobretudo na comunidade autónoma da Estremadura[5] e em todo o mundo através do Instituto Camões.',
      ),
    );

    return Future.delayed(Duration(seconds: 2), () => articles);
  }
}
