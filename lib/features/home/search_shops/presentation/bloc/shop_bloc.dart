import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tire_tech_mobile/core/bloc/common/common_event.dart';
import 'package:tire_tech_mobile/core/bloc/common/common_state.dart';
import 'package:tire_tech_mobile/features/home/search_shops/data/models/shop.dart';
import 'package:tire_tech_mobile/features/home/search_shops/data/repositories/search_shops_repository_impl.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(const InitialState()) {
    on<InitialEvent>(_initialEvent);
    on<SearchShopEvent>(_searchShops);
  }

  void _initialEvent(InitialEvent event, Emitter<ShopState> emit) {
    return emit(const InitialState());
  }

  Future<void> _searchShops(
      SearchShopEvent event, Emitter<ShopState> emit) async {
    emit(const LoadingState());

    try {
      final shops = await SearchShopsRepositoryImpl().searchShop(event.query);
      emit(ShopLoaded(shops: shops));
    } catch (err) {
      emit(ErrorState(err.toString()));
    }
  }
}
