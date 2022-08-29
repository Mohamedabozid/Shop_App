import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';

import '../../../models/shop_app/categories_model.dart';
import '../../../models/shop_app/change_favoriotes.dart';
import '../../../models/shop_app/home_model.dart';
import '../../../modules/shop_app/categories/categories_screen.dart';
import '../../../modules/shop_app/favorites/favorits_screen.dart';
import '../../../modules/shop_app/product/product_screen.dart';
import '../../../modules/shop_app/settings/settings_screen.dart';
import '../../../shareed/components/constants.dart';
import '../../../shareed/network/end_point.dart';
import '../../../shareed/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;

    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // print(homeModel!.data!.banners[0].image);
      // print(homeModel!.status);

      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });

      print(favorites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    DioHelper.postData(
      url: FAVORITES,
      data:
      {
        'product_id': productId,
      },
      token: token,
    ).then((value) {

      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      emit(ShopSuccessChangeFavoritesState());
    }).catchError(
          (error) {
            emit(ShopErrorChangeFavoritesState());
          },
        );
  }
}
