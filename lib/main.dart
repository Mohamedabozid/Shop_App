import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shareed/bloc_observer.dart';
import 'package:shop_app/shareed/components/constants.dart';
import 'package:shop_app/shareed/cubit/cubit.dart';
import 'package:shop_app/shareed/cubit/states.dart';
import 'package:shop_app/shareed/styles/themes.dart';
import 'layout/shop_app/cubit/cubit.dart';
import 'layout/shop_app/shop_layout.dart';
import 'modules/shop_app/login/shop_login.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'shareed/network/local/cache_helper.dart';
import 'shareed/network/remote/dio_helper.dart';

void main()async
{
  WidgetsFlutterBinding.ensureInitialized();


  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  String? token = CacheHelper.getData(key: 'token');




  if(onBoarding!=null)
  {
    if(token!=null)widget =ShopLayout();
    else widget = ShopLoginScreen();
  }else
    {
      widget = OnBoardingScreen();
    }



  BlocOverrides.runZoned(
        () {
      runApp(MyApp(
        isDark: isDark,
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );


}
class MyApp extends StatelessWidget
{

  final bool? isDark;
  final Widget? startWidget;

  MyApp({
    this.isDark,
    this.startWidget,
  });


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=> ShopCubit()..getHomeData()..getCategories(),),

      ],
      child: BlocProvider(
        create: (BuildContext context)=>AppCubit() ,
        child: BlocConsumer<AppCubit,AppStates>(
          listener: (context,state){},
          builder: (context,state)
          {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme ,
              themeMode:AppCubit.get(context).isDark ? ThemeMode.dark :ThemeMode.light ,
              home:startWidget,
            );
          },
        ),
      ),
    );
  }
}