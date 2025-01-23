import 'dart:async';

import 'package:scmc_church_project/ui/bible/bloc/bible_state.dart';

abstract class BibleEvent {}

// TODO: 이벤트 사용하나? 제거할까?
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

/// 성경 구약/신약 선택 이벤트
class ChangeBibleAbbrevEvent extends BibleEvent {
  final String abbrev;
  final Completer<void> completer;

  ChangeBibleAbbrevEvent(this.abbrev, this.completer);
}

/// 성경 구절 선택 이벤트 (장:절)
class ChangeBibleVerseEvent extends BibleEvent {
  final String verse; // 장:절 ex) 1:1
  final Completer<void> completer;

  ChangeBibleVerseEvent(this.verse, this.completer);
}

/// 성경 구약/신약, 구절 선택 이벤트
class ChangeBibleAbbrevVerseEvent extends BibleEvent {
  final String abbrev;
  final String verse;
  final Completer<void> completer;

  ChangeBibleAbbrevVerseEvent(this.abbrev, this.verse, this.completer);
}

/// 성경 결과 페이지 하단 이전 버튼 이벤트
class PreviousBiblePageEvent extends BibleEvent {
  final Completer<void> completer;

  PreviousBiblePageEvent(this.completer);
}

/// 성경 겨로가 페이지 하단 다음 버튼 이벤트
class NextBiblePageEvent extends BibleEvent {
  final Completer<void> completer;

  NextBiblePageEvent(this.completer);
}

/// 성경 json 데이터 조회 이벤트
class InitFetchBibleDataEvent extends BibleEvent {}

/// 북마크 클릭 이벤트
class BookmarkEvent extends BibleEvent {
  final String bookMarkItem;
  final Completer<void> completer;

  BookmarkEvent(this.bookMarkItem, this.completer);
}

/// 북마크 UI 이벤트
class BookmarkVisibleEvent extends BibleEvent {
  final String targetBookmark;

  BookmarkVisibleEvent(this.targetBookmark);
}
