import 'package:scmc_church_project/ui/bible/bloc/bible_state.dart';

abstract class BibleEvent {}

class ChangeBiblePageEvent extends BibleEvent {
  BiblePage page = BiblePage.bibleCategory;
  String abbrev = '';
  int chapter = 1;
  int verse = 1;

  ChangeBiblePageEvent(
    this.page,
    this.abbrev,
    this.chapter,
    this.verse,
  );
}

class ChangeBibleAbbrevEvent extends BibleEvent {
  final BiblePage page;
  final String abbrev;

  ChangeBibleAbbrevEvent(this.page, this.abbrev);
}

class InitFetchBibleDataEvent extends BibleEvent {}
