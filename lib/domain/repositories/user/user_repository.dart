import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finddy/domain/entities/user/user_model.dart';
import 'package:flutter/foundation.dart';

class UserRepository {
  static Future<UserModel> getUser(String email) async {
    UserModel user = const UserModel();
    try {
      final userLogin = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: email)
          .limit(1)
          .get()
          .then((value) => value.docs);
      user = UserModel.fromJson(userLogin.first.data());
      return user;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error : ${e.code} : ${e.message}");
      }
      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> createUser({
    required String email,
    required bool isVerified,
    required String name,
    String? phone,
    String? photo,
    String? university,
    String? username,
    List<Map<String, String>>? interest,
    List<Map<String, String>>? pref,
    Map<String, String>? location,
  }) async {
    try {
      await FirebaseFirestore.instance.collection("users").add({
        "email": email,
        "isVerified": isVerified,
        "name": name,
        "phone": phone,
        "photo": photo,
        "university": university,
        "username": username,
        "interest": interest,
        "pref": pref,
        "location": location,
      });
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("failed with error ${e.code} : ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // static Future<void> updateUser({
  //   required String email,
  //   required bool isVerified,
  //   required String name,
  //   String? phone,
  //   String? photo,
  //   String? university,
  //   String? username,
  //   List<Map<String, String>>? interest,
  //   List<Map<String, String>>? pref,
  //   Map<String, String>? location,
  // }) async {
  //   try {
  //     await FirebaseFirestore.instance.collection("users").add({
  //       "email": email,
  //       "isVerified": isVerified,
  //       "name": name,
  //       "phone": phone,
  //       "photo": photo,
  //       "university": university,
  //       "username": username,
  //       "interest": interest,
  //       "pref": pref,
  //       "location": location,
  //     });
  //   } on FirebaseException catch (e) {
  //     if (kDebugMode) {
  //       print("failed with error ${e.code} : ${e.message}");
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }
}
