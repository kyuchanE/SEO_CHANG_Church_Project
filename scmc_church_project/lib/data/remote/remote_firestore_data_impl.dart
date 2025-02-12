import 'package:scmc_church_project/data/remote/remote_firestore_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemoteFirestoreDataImpl implements RemoteFirestoreData {
  final FirebaseFirestore _firestore;

  RemoteFirestoreDataImpl(this._firestore);

  /// 버전 정보 조회
  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getVersion() =>
      _firestore.collection('version_check').get();

  /// 메인 아이템 조회
  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getMainCarouselItem() =>
      _firestore.collection('main_items').get();
}
