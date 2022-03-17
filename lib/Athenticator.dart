import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authenticator{
  //creamos un metodo
  static Future<User?> iniciarSesion({required BuildContext context}) async{
    FirebaseAuth authenticator= FirebaseAuth.instance; //peticion a un servidor
    User? user;
    GoogleSignIn objGoogleSignIn =GoogleSignIn();
    GoogleSignInAccount? objGoogleSignInAccount =await objGoogleSignIn.signIn(); //valida si el perfil existe en google

    //condicones
  if(objGoogleSignInAccount!= null){//valida que el perfil no vaya a venir nulo
    GoogleSignInAuthentication objGoogleSignInAuthentication= await objGoogleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential( //obtenemos las crdenciales
      accessToken: objGoogleSignInAuthentication.accessToken,
      idToken: objGoogleSignInAuthentication.idToken
    );
    //si esto falla vamos y tenemos que controlarlo -- esto esta dentro de if
    try{
      UserCredential userCredential=await authenticator.signInWithCredential(credential);

      user = userCredential.user;
      return user;


    }on FirebaseAuthException catch(e){ //mostrara el error producido
      print('error e la autenticacion');

    }



  }




  }
}