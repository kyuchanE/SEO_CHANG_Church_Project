import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_event.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_state.dart';

@injectable
class BibleBloc extends Bloc<BibleEvent, BibleState> {
  BibleBloc() : super(BibleState(page: BiblePage.bibleCategory)) {
    on<ChangeBiblePageEvent>((event, emit) => _changeBiblePage(event, emit));

    on<ChangeBibleCategoryEvent>((event, emit) {});
  }

  /// 성경 페이지 변경
  Future _changeBiblePage(
    ChangeBiblePageEvent event,
    Emitter<BibleState> emit,
  ) async {
    emit(BibleState(
      page: event.page,
      category: event.category,
      chapter: event.chapter,
      verse: event.verse,
    ));
  }

  /// 성경 카테고리 변경
  Future _changeBibleCategoryEvent(
    ChangeBiblePageEvent event,
    Emitter<BibleState> emit,
  ) async {
    emit(BibleState(
      page: BiblePage.bibleCategory,
      category: event.category,
    ));
  }
}
