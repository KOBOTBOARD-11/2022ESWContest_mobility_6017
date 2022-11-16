import 'package:firebase_auth/firebase_auth.dart';

class AuthManager {
  //회원가입
  Future<bool> signUpUser(String email, String pw) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pw);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('the password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('11111');
      }
      return false;
    }
    // authPersistence(); // 인증 영속
    return true;
  }

  Future<bool> signInUser(String email, String pw) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: pw); //아이디와 비밀번호로 로그인 시도
      //return value.user!.emailVerified; //이메일 인증 여부
    } on FirebaseAuthException catch (e) {
      //로그인 예외처리
      if (e.code == 'user-not-found') {
        print('등록되지 않은 이메일입니다');
      } else if (e.code == 'wrong-password') {
        print('비밀번호가 틀렸습니다');
      } else {
        print(e.code);
      }
      return false;
    }
    return true;
  }
}
