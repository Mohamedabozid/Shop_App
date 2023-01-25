
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_app/carts_model.dart';
import 'package:shop_app/shareed/styles/colors.dart';

class BuildCartItem extends StatelessWidget {
  final CartItems cartItems;



   const BuildCartItem({Key? key, required this.cartItems,}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(cartItems.product!.image!),
                  width: 120.0,
                  height: 120.0,
                ),
                if (cartItems.product!.discount != 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    color: Colors.red,
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 20.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItems.product!.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.4,
                    ),
                  ),
                  const Spacer(),
                  BlocConsumer<ShopCubit,ShopStates>(
                   listener: (context,state){},
                   builder: (context,state)
                   {
                    ShopCubit.get(context);
                     return  Row(
                       children: [
                         Text(
                           cartItems.product!.price!.toString(),
                           maxLines: 2,
                           overflow: TextOverflow.ellipsis,
                           style: const TextStyle(fontSize: 12.0, color: defaultColor),
                         ),
                         const SizedBox(
                           width: 5.0,
                         ),
                         if ( cartItems.product!.discount! != 0)
                           Text(
                             cartItems.product!.oldPrice.toString(),
                             maxLines: 2,
                             overflow: TextOverflow.ellipsis,
                             style: const TextStyle(
                               fontSize: 10.0,
                               color: Colors.grey,
                               decoration: TextDecoration.lineThrough,
                             ),
                           ),
                         const SizedBox(
                           width: 5.0,
                         ),

                         Expanded(
                           child: IconButton(
                             padding: EdgeInsets.zero,
                             onPressed: () {


                               ShopCubit.get(context).minusItem();

                             },
                             icon: Icon(
                               Icons.remove,
                               size: 14.0,
                               color: Colors.black,
                             ),
                           ),
                         ),
                         Text(
                             '${ShopCubit.get(context).total}'
                         ),
                         Expanded(
                           child: IconButton(
                             padding: EdgeInsets.zero,
                             onPressed: () {
                               ShopCubit.get(context).plusItem();

                             },
                             icon: Icon(
                               Icons.add,
                               size: 14.0,
                               color: Colors.black,
                             ),
                           ),
                         ),


                         Expanded(
                           child: IconButton(
                             padding: EdgeInsets.zero,
                             onPressed: () {

                               ShopCubit.get(context).changeCarts(cartItems.product!.id!);
                             },
                             icon: const CircleAvatar(
                               radius: 15.0,
                               backgroundColor://ShopCubit.get(context).carts[cartItems.product!.id]!

                               true
                                   ? defaultColor : Colors.grey,
                               child: Icon(
                                 Icons.add_shopping_cart_sharp,
                                 size: 14.0,
                                 color: Colors.white,
                               ),
                             ),
                           ),
                         ),
                       ],
                     );
                   },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );;
  }
}
