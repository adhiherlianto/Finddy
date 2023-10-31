import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finddy/domain/entities/user/user_model.dart';
import 'package:flutter/foundation.dart';

class UserRepository {
  static Future<List<UserModel>> getAllUser() async {
    List<UserModel> listAllUser = [];
    try {
      final data = await FirebaseFirestore.instance.collection("users").get();
      listAllUser =
          List.from(data.docs.map((e) => UserModel.fromJson(e.data())));
      print("masuk all user");
      return listAllUser;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error : ${e.code} : ${e.message}");
      }
      return listAllUser;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<UserModel>> getNameSearch(String? name) async {
    List<UserModel> listAllUser = [];
    try {
      final data = await FirebaseFirestore.instance
          .collection("users")
          .where("name",
              isGreaterThanOrEqualTo: name,
              isLessThan: name!.substring(0, name.length - 1) +
                  String.fromCharCode(name.codeUnitAt(name.length - 1) + 1))
          .get();
      listAllUser =
          List.from(data.docs.map((e) => UserModel.fromJson(e.data())));
      print("masuk nama");
      return listAllUser;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error : ${e.code} : ${e.message}");
      }
      return listAllUser;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<UserModel>> getLocationSearch(String? locationId) async {
    List<UserModel> listAllUser = [];
    try {
      final data = await FirebaseFirestore.instance
          .collection("users")
          .where("location.locationId", isEqualTo: locationId)
          .get();
      listAllUser =
          List.from(data.docs.map((e) => UserModel.fromJson(e.data())));
      print("masuk lokasi");
      return listAllUser;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error : ${e.code} : ${e.message}");
      }
      return listAllUser;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<UserModel>> getSkillSearch(String skill) async {
    List<UserModel> listAllUser = [];
    try {
      final data = await FirebaseFirestore.instance
          .collection("users")
          .where("interest", arrayContains: {'skill': skill}).get();
      // .then((value) => listAllUser =
      //     List.from(value.docs.map((e) => UserModel.fromJson(e.data()))));
      // listAllUser =
      //     List.from(data.docs.map((e) => UserModel.fromJson(e.data())));
      print(data.size);
      print("masuk Skill");
      return listAllUser;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error : ${e.code} : ${e.message}");
      }
      return listAllUser;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // static Future<List<UserModel>> getInterestSearch(
  //     String interest) async {
  //   List<UserModel> listAllUser = [];
  //   try {
  //     final data = await FirebaseFirestore.instance
  //         .collection("users")
  //         .where("interest.name", arrayContains: interest)
  //         .get();
  //     listAllUser =
  //         List.from(data.docs.map((e) => UserModel.fromJson(e.data())));
  //     print("masuk lokasi");
  //     return listAllUser;
  //   } on FirebaseException catch (e) {
  //     if (kDebugMode) {
  //       print("Failed with error : ${e.code} : ${e.message}");
  //     }
  //     return listAllUser;
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  static Future<UserModel> getUser(String email) async {
    UserModel user = const UserModel();
    try {
      final userLogin = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: email)
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
    required String docId,
    required String email,
    required bool isVerified,
    required String name,
  }) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(docId).set({
        "email": email,
        "isVerified": isVerified,
        "name": name,
      });
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("failed with error ${e.code} : ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> updateUser({
    required String docId,
    required bool isVerified,
    String? phone,
    String? photo,
    String? university,
    String? username,
    List<dynamic>? interest,
    List<dynamic>? pref,
    Map<String, String>? location,
  }) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(docId).update({
        "isVerified": isVerified,
        "phone": phone,
        "photo": photo,
        "university": university,
        "username": username,
        "interest": FieldValue.arrayUnion(interest!),
        "pref": FieldValue.arrayUnion(pref!),
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
}
