import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserRepository {
  static Future<void> createUser(
      {required String email,
      required bool isVerified,
      required String name,
      String? locationId,
      String? phone,
      String? photo,
      String? university,
      String? username}) async {
    try {
      await FirebaseFirestore.instance.collection("users").add({
        "email": email,
        "isVerified": isVerified,
        "locationID": locationId,
        "name": name,
        "phone": phone,
        "photo": photo,
        "university": university,
        "username": username,
      });
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("failed with error ${e.code} : ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
