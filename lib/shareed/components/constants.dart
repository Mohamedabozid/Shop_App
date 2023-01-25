// base url : http://newsapi.org/
// method (url): v2/everything?
// queries : q=apple&from=2022-05-09&to=2022-05-09&sortBy=popularity&apiKey=c9f44bbc0a7441c7acbbbca5cf64616f




import '../../modules/shop_app/login/shop_login.dart';
import '../network/local/cache_helper.dart';
import 'compnnents.dart';

void signOut(context)
{
  CacheHelper.removeData(key: 'token',).then((value)
  {
    if(value)
    {
      navigateAndFinish(context, ShopLoginScreen(),);
    }
  });



}


// void printFullText(String text)
// {
//   final pattern = RegExp('{1,800}');//800 is the size of each chunk
//   pattern.allMatches(text!).forEach((match))=>print(match.group(0));
// }
dynamic token ='';

String? uId ='';