import 'package:flutter_kakao_login/flutter_kakao_login.dart';


class KaKaoAuth {

   Future<Null> signIn() async { 

       FlutterKakaoLogin kakaoSignIn = new FlutterKakaoLogin();
final KakaoLoginResult result = await kakaoSignIn.logIn();
switch (result.status) {
    case KakaoLoginStatus.loggedIn:
        // _updateMessage('LoggedIn by the user.\n'
        //                '- UserID is ${result.account.userID}\n'
        //                '- UserEmail is ${result.account.userEmail} ');
    break;
    case KakaoLoginStatus.loggedOut:
        // _updateMessage('LoggedOut by the user.');
    break;
    case KakaoLoginStatus.error:
        // _updateMessage('This is Kakao error message : ${result.errorMessage}');
    break;
   }
   }
}