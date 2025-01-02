import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_event.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_state.dart';

class BibleBloc extends Bloc<BibleEvent, BibleState> {
  BibleBloc() : super(BibleState(page: BiblePage.bibleCategory)) {
    on<ChangeBiblePageEvent>((event, emit) {
      emit(BibleState(
        page: event.page,
        category: event.category,
        chapter: event.chapter,
        verse: event.verse,
      ));
    });

    on<ChangeBibleCategoryEvent>((event, emit) {
      emit(BibleState(
        page: BiblePage.bibleCategory,
        category: event.category,
      ));
    });
  }
}
