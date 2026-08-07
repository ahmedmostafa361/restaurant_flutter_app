import '../../../../../../domain/entinties/response/menu/menu_item.dart';

abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {
  final List<MenuItem> items;

  SearchSuccessState({required this.items});
}

class SearchEmptyState extends SearchStates {}

class SearchErrorState extends SearchStates {
  final String errorMessage;

  SearchErrorState({required this.errorMessage});
}
