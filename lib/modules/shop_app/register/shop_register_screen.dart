import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/shop_layout.dart';
import '../../../shareed/components/compnnents.dart';
import '../../../shareed/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopRegisterScreen extends StatelessWidget {
  const ShopRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,state){
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                navigateAndFinish(
                  context,
                  ShopLayout(),
                );
              });
            } else {
              print(state.loginModel.message);
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context,state){
          return  Scaffold(
            appBar: AppBar(),
            body:  Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style:
                          Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'user name',
                          prefix: Icons.person,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your name ';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address ';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          // suffix:ShopRegisterCubit.get(context).suffix ,
                          // isPass: ShopRegisterCubit.get(context).isPassword,
                          suffixPressed: () {
                            //ShopRegisterCubit.get(context).changePasswordVisibility();
                          },
                          onSubmited: (value)
                          {

                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'password is too short ';
                            }
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'phone',
                          prefix: Icons.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone ';
                            }
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                               ShopRegisterCubit.get(context).userRegister(
                                 name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                 phone: phoneController.text,
                                );
                              }
                            },
                            text: 'Register',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
