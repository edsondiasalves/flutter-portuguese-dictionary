import 'package:portuguese_dictionary/model/searchResult.dart';

class DictionaryService{
  List<SearchResult> getSearchResult(){
    List<SearchResult> searchResultList = List<SearchResult>();
    
    SearchResult searchResult1 = SearchResult();
    searchResult1.id = 1;
    searchResult1.portugueseTerm = "Fixe";
    searchResult1.brazilianTerm = "Legal";
    searchResult1.meanings = ["Interessante ou positivo", "Uma situação favorável"];
    searchResult1.examples = ["Sua roupa é muito fixe", "Bom dia, hoje estou fixe"];
    searchResultList.add(searchResult1);

    SearchResult searchResult2 = SearchResult();
    searchResult2.id = 2;
    searchResult2.portugueseTerm = "Comboio";
    searchResult2.brazilianTerm = "Trêm";
    searchResult2.meanings = ["Transporte sobre trilhos"];
    searchResult2.examples = ["O comboio chega às 13:00", "O trem já partiu"];
    searchResultList.add(searchResult2);

    return searchResultList;
  }
} 