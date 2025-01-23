import 'package:shared_preferences/shared_preferences.dart';

const String PREF_KEY_BOOK_MARK = 'bible_book_mark';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  /// 성경 북마크 조회 - ex) '창/1:1'
  List<String>? get bookMark =>
      _sharedPreferences.getStringList(PREF_KEY_BOOK_MARK);

  /// 성경 북마크 설정 - ex) '창/1:1'
  Future<void> setBookMark(List<String> bookMark) async {
    await _sharedPreferences.setStringList(PREF_KEY_BOOK_MARK, bookMark);
  }
}
