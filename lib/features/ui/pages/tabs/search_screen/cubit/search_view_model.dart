import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/domain/use_cases/search_items_use_case.dart';

import '../../../../../../api/dio/dio_exceptions/app_exceptions.dart';
import 'search_states.dart';

@injectable
class SearchViewModel extends Cubit<SearchStates> {
  final SearchItemsUseCase searchItemsUseCase;
  Timer? _debounce;

  SearchViewModel(this.searchItemsUseCase) : super(SearchInitialState());

  // Called directly from the TextField's onChanged — no Timer logic in the widget.
  void onSearchQueryChanged(String query) {
    _debounce?.cancel();

    if (query
        .trim()
        .isEmpty) {
      emit(SearchInitialState());
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 450), () {
      _searchItems(query.trim());
    });
  }

  Future<void> _searchItems(String itemName) async {
    emit(SearchLoadingState());
    try {
      final items = await searchItemsUseCase.invoke(itemName: itemName);
      if (items.isEmpty) {
        emit(SearchEmptyState());
      } else {
        emit(SearchSuccessState(items: items));
      }
    } on ServerErrorException catch (e) {
      emit(SearchErrorState(errorMessage: e.errorMessage));
    } catch (e) {
      emit(SearchErrorState(
          errorMessage: "Something went wrong, please try again."));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}