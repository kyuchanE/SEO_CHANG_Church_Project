import 'package:scmc_church_project/bloc/splash_init/splash_init_event.dart';
import 'package:scmc_church_project/bloc/splash_init/splash_init_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// 스플래시 초기화 Bloc
class SplashInitBloc extends Bloc<SplashInitEvent, SplashInitState> {
  SplashInitBloc() : super(SplashInitState(SplashInitStatus.initial, null)) {
    on<InitFetchDataEvent>((event, emit) async {
      emit(SplashInitState(SplashInitStatus.loading, null));

      var isSuccessVersion = await fetchUsers((str) {
        emit(SplashInitState(SplashInitStatus.loading, str));
      });
      if (isSuccessVersion) {
        emit(SplashInitState(SplashInitStatus.success, state.strData));
      } else {
        emit(SplashInitState(SplashInitStatus.error, null));
      }
    });
  }
}

Future<bool> fetchUsers(
  Function(String str)? updateData,
) async {
  var returnValue = false;

  CollectionReference users =
      FirebaseFirestore.instance.collection('version_check');

  await users.get().then((QuerySnapshot snapshot) {
    snapshot.docs.forEach((doc) {
      print('${doc.id} => ${doc.data()}');
      updateData?.call(doc.data().toString());
    });
    returnValue = true;
  }).catchError((error) {
    print("Failed to fetch users: $error");
  });

  return returnValue;
}
