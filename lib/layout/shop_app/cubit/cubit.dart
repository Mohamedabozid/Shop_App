import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_app/carts_model.dart';
import 'package:shop_app/models/shop_app/favorites_model.dart';

import '../../../models/shop_app/categories_model.dart';
import '../../../models/shop_app/change_cart.dart';
import '../../../models/shop_app/change_favoriotes.dart';
import '../../../models/shop_app/home_model.dart';
import '../../../modules/shop_app/carts/carts_screen.dart';
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

  int total = 1;

  List<Widget> bottomScreens = [
    ProductScreen(),
    CategoriesScreen(),
    CartsScreen(),
    FavoritesScreen(),
    SettingsScreen(),

  ];

  void changeBottom(int index) {
    currentIndex = index;

    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  Map<int, bool> carts = {};

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
      homeModel!.data!.products.forEach((element)
      {
        carts.addAll({
          element.id! :element.inCart!
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
    favorites[productId] = !favorites[productId]!;

    emit(ShopChangeFavoritesState());


    DioHelper.postData(
      url: FAVORITES,
      data:
      {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      print(value.data);

      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritesState());
    }).catchError(
          (error) {
        emit(ShopErrorChangeFavoritesState());
      },
    );
  }


  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }


  ChangeCartModel? changeCartModel;

  void changeCarts(int productId) {
    carts[productId] = !carts[productId]!;

    emit(ShopChangeCartState());


    DioHelper.postData(
      url: CART,
      data:
      {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeCartModel = ChangeCartModel.fromJson(value.data);

      print(value.data);

      if (!changeCartModel!.status!) {
        carts[productId] = !carts[productId]!;
      }else
        {
          getCarts();
        }

      emit(ShopSuccessChangeCartState());
    }).catchError(
          (error) {
        emit(ShopErrorChangeCartState());
      },
    );
  }

  CartsModel? cartsModel;

  void getCarts() {
    emit(ShopLoadingGetCartsState());
    DioHelper.getData(
      url: CART,
      token: token,
    ).then((value) {
     cartsModel = CartsModel.fromJson(value.data);

     print(value.data);


      emit(ShopSuccessGetCartsState());


    }).catchError((error) {
      log(error.toString());
      emit(ShopErrorGetCartsState(error.toString()));
    });
  }

  void plusItem()
  {


    total++;
    emit(ShopPlusItemState());
  }

  void minusItem()
  {
    if(total >=1)
    {
      total--;
      emit(ShopMinusItemState());
    }

  }

}
