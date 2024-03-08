import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finddy/domain/entities/location/location_model.dart';
import 'package:flutter/foundation.dart';

class LocationRepository {
  static Future<List<String>> getProvince() async {
    List<String> list = [];
    try {
      var data = await FirebaseFirestore.instance.collection("location").get();
      list = List.from(data.docs.map((e) => e.id).toList());
      return list;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error : ${e.code} : ${e.message}");
      }
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<LocationModel>> getCity(String province) async {
    List<LocationModel> listLocation = [];
    try {
      await FirebaseFirestore.instance
          .collection("location")
          .doc(province)
          .get()
          .then((value) {
        // ignore: avoid_function_literals_in_foreach_calls
        List.from(value.data()?["member"]).forEach((element) {
          return listLocation.add(LocationModel.fromJson(element));
        });
      });
      return listLocation;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error : ${e.code} : ${e.message}");
      }
      return listLocation;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
