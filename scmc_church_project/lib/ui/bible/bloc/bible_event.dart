import 'package:scmc_church_project/ui/bible/bloc/bible_state.dart';

abstract class BibleEvent {}

class ChangeBiblePageEvent extends BibleEvent {
  BiblePage page = BiblePage.bibleCategory;
  final String abbrev;
  final int chapter;
  final String verse;

  ChangeBiblePageEvent(
    this.page,
    this.abbrev,
    this.chapter,
    this.verse,
  );
}

class ChangeBibleAbbrevEvent extends BibleEvent {
  final String abbrev;

  ChangeBibleAbbrevEvent(this.abbrev);
}

class ChangeBibleVerseEvent extends BibleEvent {
  final String verse;

  ChangeBibleVerseEvent(this.verse);
}

class PreviousBibleVerseEvent extends BibleEvent {}

class NextBibleVerseEvent extends BibleEvent {}

class InitFetchBibleDataEvent extends BibleEvent {}
