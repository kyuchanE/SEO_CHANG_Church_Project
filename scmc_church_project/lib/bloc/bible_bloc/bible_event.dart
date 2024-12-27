import 'package:scmc_church_project/bloc/bible_bloc/bible_state.dart';

abstract class BibleEvent {}

class ChangeBiblePageEvent extends BibleEvent {
  BiblePage page = BiblePage.bibleCategory;
  String category = '';
  int chapter = 1;
  int verse = 1;

  ChangeBiblePageEvent(
    this.page,
    this.category,
    this.chapter,
    this.verse,
  );
}

class ChangeBibleCategoryEvent extends BibleEvent {
  String category = '';

  ChangeBibleCategoryEvent(this.category);
}
