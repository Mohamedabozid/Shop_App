abstract class ShopStates{}


class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{}

class ShopSuccessChangeFavoritesState extends ShopStates{}
class ShopErrorChangeFavoritesState extends ShopStates{}
class ShopChangeFavoritesState extends ShopStates{}

class ShopSuccessChangeCartState extends ShopStates{}
class ShopErrorChangeCartState extends ShopStates{}
class ShopChangeCartState extends ShopStates{}

class ShopSuccessGetFavoritesState extends ShopStates{}
class ShopErrorGetFavoritesState extends ShopStates{}
class ShopLoadingGetFavoritesState extends ShopStates{}


class ShopSuccessGetCartsState extends ShopStates{}
class ShopErrorGetCartsState extends ShopStates{
  final String Error;

  ShopErrorGetCartsState(this.Error);
}
class ShopLoadingGetCartsState extends ShopStates{}


class ShopPlusItemState extends ShopStates{}
class ShopMinusItemState extends ShopStates{}





