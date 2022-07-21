import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final_seminario_restaurante/app/utils/utils.dart';
import 'package:proyecto_final_seminario_restaurante/app/widgets/widgets.dart';
import '../model_services/user_service.dart';
import '../../models/user_model.dart' as projectUser;
import 'database_service.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  ///signIn
  Future<dynamic> signIn(
      {required String email, required String password}) async {
    await connectionStatus.getAuthStatus();

    String errorMessage = '';
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          // errorMessage = "Your email address appears to be malformed.";
          errorMessage = "Tu correo electrónico parece que está mal escrito.";
          break;
        case "wrong-password":
          // errorMessage = "Your password is wrong.";
          errorMessage = "Contraseña incorrecta.";
          break;
        case "user-not-found":
          // errorMessage = "User with this email doesn't exist.";
          errorMessage =
              "No existe ningún usuario con este correo electrónico.";
          break;
        case "user-disabled":
          // errorMessage = "User with this email has been disabled.";
          errorMessage =
              "El usuario con este correo electrónico está inhabilitado.";
          break;
        default:
          // errorMessage = "An undefined Error happened.";
          errorMessage =
              "Hubo un error desconocido, por favor intenta de nuevo más tarde.";
      }
    }
    return errorMessage;
  }

  ///signUp can be UserCredential or error string code
  Future<dynamic> signUp(
      {required String email, required String password}) async {
    await connectionStatus.getAuthStatus();

    String errorMessage = '';

    try {
      // Returns an UserCredential
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      // Returns an error message
      switch (error.code) {
        case "email-already-in-use":
          errorMessage =
              "Ya hay un usuario registrado con este correo electrónico";
          break;
        case "invalid-email":
          errorMessage = "Tu correo electrónico parece que está mal escrito.";
          break;
        case "weak-password":
          errorMessage = "La contraseña es muy débil";
          break;
        default:
          errorMessage =
              "Hubo un error desconocido, por favor intenta de nuevo más tarde.";
      }
      return errorMessage;
    }
  }

  ///sendPasswordReset
  Future<String> sendPasswordReset(String email) async {
    await connectionStatus.getAuthStatus();

    String errorMessage = "";
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Tu correo electrónico parece que está mal escrito.";
          break;
        case "user-not-found":
          errorMessage = "No existe un usuario con este correo electrónico";
          break;
        default:
          errorMessage =
              "Hubo un error desconocido, por favor intenta de nuevo más tarde.";
      }
    }
    return errorMessage;
  }

  ///Change password
  Future<String> changePassword(
    String currentPassword,
    String email,
    String newPassword,
  ) async {
    await connectionStatus.getNormalStatus();

    try {
      var signInStatus = await signIn(email: email, password: currentPassword);
      if (signInStatus.isEmpty) {
        var user = _firebaseAuth.currentUser;

        await user!.updatePassword(newPassword);

        return "success";
      } else {
        return "error";
      }
    } catch (err) {
      debugPrint(err.toString());
      return "error";
    }
  }

  ///Delete User
  Future<bool> deleteUser() async {
    await connectionStatus.getAuthStatus();

    if (await getCurrentUserLocal() != null) {
      try {
        await _firebaseAuth.currentUser!.delete();
        await database.deleteDocument(_firebaseAuth.currentUser!.uid, 'users');
        return true;
      } on FirebaseAuthException catch (e) {
        print(e);
        return false;
      }
    } else {
      return false;
    }
  }

  ///Delete User
  Future<bool> deleteAccount({required String userId}) async {
    await connectionStatus.getAuthStatus();

    if (await getCurrentUserLocal() != null) {
      try {
        await _firebaseAuth.currentUser!.delete();
        await database.deleteDocument(userId, 'users');
        return true;
      } on FirebaseAuthException catch (error) {
        // Returns an error message

        switch (error.code) {
          case "requires-recent-login":
            SnackBars.showErrorSnackBar(
              'Por favor, vuelve a iniciar sesión para poder eliminar tu cuenta.',
            );
            return false;

          default:
            SnackBars.showErrorSnackBar(
              'Hubo un error al eliminar tu usuario, por favor intenta más tarde.',
            );
            return false;
        }
      }
    } else {
      print('getCurrentUserLocal');
      return false;
    }
  }

  ///SignOut
  Future<bool> signOut() async {
    await connectionStatus.getNormalStatus();

    try {
      await _firebaseAuth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  ///Get Currentuser
  User? getCurrentUser() {
    try {
      return _firebaseAuth.currentUser;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  ///Get Currentuser
  getCurrentUserLocal() async {
    try {
      return _firebaseAuth.currentUser;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<projectUser.User?> getCurrentUserHome() async {
    await connectionStatus.getNormalStatus();

    try {
      return (await userService.getCurrentUser())!;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}

final AuthService auth = AuthService(FirebaseAuth.instance);
