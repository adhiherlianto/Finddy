import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finddy/domain/entities/preference/preference_model.dart';
import 'package:flutter/foundation.dart';

class PreferenceRepository {
  static Future<List<PreferenceModel>> getPref() async {
    List<PreferenceModel> listPref = [];
    try {
      final data =
          await FirebaseFirestore.instance.collection("preference").get();
      listPref =
          List.from(data.docs.map((e) => PreferenceModel.fromJson(e.data())));
      return listPref;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error : ${e.code} : ${e.message}");
      }
      return listPref;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
