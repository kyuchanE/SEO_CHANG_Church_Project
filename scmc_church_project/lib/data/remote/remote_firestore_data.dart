import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RemoteFirestoreData {
  Future<QuerySnapshot<Map<String, dynamic>>> getVersion();

  Future<QuerySnapshot<Map<String, dynamic>>> getMainCarouselItem();
}
