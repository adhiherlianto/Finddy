import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finddy/domain/entities/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserRepository {
  static Future<List<UserModel>> getAllUser() async {
    List<UserModel> listAllUser = [];
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final data = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isNotEqualTo: auth.currentUser?.email)
          .get();
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

  static Future<List<UserModel>> getAllFriend(List<String> friendUid) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<UserModel> friends = [];
    for (String uid in friendUid) {
      DocumentReference userRef = firestore.collection("users").doc(uid);
      try {
        DocumentSnapshot userSnapshot = await userRef.get();

        if (userSnapshot.exists) {
          friends.add(
              UserModel.fromJson(userSnapshot.data() as Map<String, dynamic>));
        }
      } catch (e) {
        throw Exception(e.toString());
      }
    }
    return friends;
  }

  static Future<List<UserModel>> getAllFriendRequest(
      List<String> friendUid) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<UserModel> friendRequest = [];
    for (String uid in friendUid) {
      DocumentReference userRef = firestore.collection("users").doc(uid);
      try {
        DocumentSnapshot userSnapshot = await userRef.get();

        if (userSnapshot.exists) {
          friendRequest.add(
              UserModel.fromJson(userSnapshot.data() as Map<String, dynamic>));
        }
      } catch (e) {
        throw Exception(e.toString());
      }
    }
    return friendRequest;
  }

  static Future<List<UserModel>> getNameSearch(String? name) async {
    List<UserModel> listAllUser = [];
    try {
      final String? email = FirebaseAuth.instance.currentUser?.email;
      final data = await FirebaseFirestore.instance
          .collection("users")
          .where("name",
              isGreaterThanOrEqualTo: name,
              isLessThan: name!.substring(0, name.length - 1) +
                  String.fromCharCode(name.codeUnitAt(name.length - 1) + 1))
          .get();
      listAllUser =
          List.from(data.docs.map((e) => UserModel.fromJson(e.data())));
      listAllUser.removeWhere(
          (element) => element.email == email || element.isVerified == false);
      print(listAllUser);
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
      final String? email = FirebaseAuth.instance.currentUser?.email;
      final data = await FirebaseFirestore.instance
          .collection("users")
          .where("location.locationId", isEqualTo: locationId)
          .get();
      listAllUser =
          List.from(data.docs.map((e) => UserModel.fromJson(e.data())));
      listAllUser.removeWhere(
          (element) => element.email == email || element.isVerified == false);
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
      final String? email = FirebaseAuth.instance.currentUser?.email;
      final data = await FirebaseFirestore.instance
          .collection("users")
          .where("interestSkill", arrayContains: skill)
          .get();
      listAllUser =
          List.from(data.docs.map((e) => UserModel.fromJson(e.data())));
      listAllUser.removeWhere(
          (element) => element.email == email || element.isVerified == false);
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

  static Future<List<UserModel>> getInterestSearch(
      String? interestId, String? interestName) async {
    List<UserModel> listAllUser = [];
    try {
      final String? email = FirebaseAuth.instance.currentUser?.email;
      final data = await FirebaseFirestore.instance.collection("users").where(
          "interest",
          arrayContains: {"id": interestId, "name": interestName}).get();
      listAllUser =
          List.from(data.docs.map((e) => UserModel.fromJson(e.data())));
      listAllUser.removeWhere(
          (element) => element.email == email || element.isVerified == false);
      print(data.size);
      print("masuk interest");
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

  static Future<UserModel> getUser(String email) async {
    UserModel user = const UserModel();
    try {
      final userLogin = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: email)
          .get()
          .then((value) => value.docs);
      user = UserModel.fromJson(userLogin.first.data());
      print(user.name);
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
        "uid": docId,
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
    List<String>? interestSkill,
  }) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(docId).update({
        "interest": FieldValue.delete(),
        "pref": FieldValue.delete(),
      });
      await FirebaseFirestore.instance.collection("users").doc(docId).update({
        "isVerified": isVerified,
        "phone": phone,
        "photo": photo,
        "university": university,
        "username": username,
        "interest": FieldValue.arrayUnion(interest!),
        "pref": FieldValue.arrayUnion(pref!),
        "location": location,
        "interestSkill": interestSkill,
      });
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("failed with error ${e.code} : ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> addFriend(String uid) async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      List listUid = [];
      listUid.add(uid);
      List listCurrentUserId = [currentUserId];
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId)
          .update({"friends": FieldValue.arrayUnion(listUid)});
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .update({"friends": FieldValue.arrayUnion(listCurrentUserId)});
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("failed with error ${e.code} : ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> deleteFriend(String uid) async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      List listUid = [];
      listUid.add(uid);
      List listCurrentUserId = [currentUserId];
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId)
          .update({"friends": FieldValue.arrayRemove(listUid)});
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .update({"friends": FieldValue.arrayRemove(listCurrentUserId)});
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("failed with error ${e.code} : ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> addFriendRequest(String uid) async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      List listCurrentUserId = [currentUserId];
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .update({"friendRequests": FieldValue.arrayUnion(listCurrentUserId)});
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("failed with error ${e.code} : ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> deleteFriendRequest(String uid, bool? isAccept) async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      if (isAccept == false || isAccept == null) {
        List listUid = [currentUserId];
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .update({"friendRequests": FieldValue.arrayRemove(listUid)});
      } else {
        List listUid = [uid];
        await FirebaseFirestore.instance
            .collection("users")
            .doc(currentUserId)
            .update({"friendRequests": FieldValue.arrayRemove(listUid)});
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("failed with error ${e.code} : ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
