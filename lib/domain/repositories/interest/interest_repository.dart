import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finddy/domain/entities/interest/interest_model.dart';
import 'package:flutter/foundation.dart';

class InterestRepository {
  static Future<List<InterestModel>> getCity() async {
    List<InterestModel> listInterest = [];
    try {
      final interest =
          await FirebaseFirestore.instance.collection("interests").get();
      listInterest =
          List.from(interest.docs.map((e) => InterestModel.fromJson(e.data())));
      return listInterest;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error : ${e.code} : ${e.message}");
      }
      return listInterest;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
