import 'package:finesse/src/features/home/controllers/shop_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/scroll_state.dart';

final shopListScrollProvider =
    StateNotifierProvider<ShopListScrollController, ScrollState>(
        (ref) => ShopListScrollController(ref: ref));

class ShopListScrollController extends StateNotifier<ScrollState> {
  final Ref? ref;

  ShopListScrollController({this.ref}) : super(const ScrollInitialState());

  ScrollController _scrollController = ScrollController();

  get controller {
    _scrollController.addListener(scrollListener);
    return _scrollController;
  }

  set setController(ScrollController scrollController) {
    _scrollController = scrollController;
  }

  get scrollNotifierState => state;

  scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      ref!.read(shopProvider.notifier).fetchMoreShopProductList();
      state = const ScrollReachedBottomState();
    }
  }

  resetState() {
    state = const ScrollInitialState();
  }
}
