import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/shareed/components/compnnents.dart';

import '../../../widgets.dart';

class CartsScreen extends StatelessWidget {
  const CartsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocProvider
            .of<ShopCubit>(context)
            .cartsModel!
            .data!
            .cartItems!
            .isNotEmpty ? ListView.separated(
          itemBuilder: (context, index) =>
              BuildCartItem(cartItems:ShopCubit
                  .get(context)
                  .cartsModel!
                  .data!
                  .cartItems![index]),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: ShopCubit
              .get(context)
              .cartsModel!
              .data!
              .cartItems!
              .length,) :
         const Center(child:  CircularProgressIndicator(),);
      },
    );
  }


//   Widget buildCartItem(CartItems model) =>
//
 }
