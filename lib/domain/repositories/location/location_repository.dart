import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finddy/domain/entities/location/location_model.dart';
import 'package:flutter/foundation.dart';

class LocationRepository {
  static Future<List<LocationModel>> get() async {
    List<LocationModel> listLocation = [];

    try {
      final loc = await FirebaseFirestore.instance.collection("location").get();
      // ignore: avoid_function_literals_in_foreach_calls
      loc.docs.forEach((element) {
        return listLocation.add(LocationModel.fromJson(element.data()));
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
