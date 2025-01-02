import 'package:flutter/services.dart';
import 'package:scmc_church_project/data/remote/remote_bible_json_data.dart';

class RemoteBibleJsonDataImpl implements RemoteBibleJsonData {
  @override
  Future<String> getBibleChapter() =>
      rootBundle.loadString('assets/bible_ko.json');
}
