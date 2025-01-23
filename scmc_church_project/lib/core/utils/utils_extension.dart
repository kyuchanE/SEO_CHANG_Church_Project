import 'dart:ffi';

extension BiblePlaceHolder on String {
  String biblePlaceHolder() => 'assets/images/placeholder.png';
}

extension BibleBookmarkStringItem on String {
  String getBookmarkAbbrev() {
    try {
      return split("/")[0];
    } catch (e) {
      return '';
    }
  }

  String getBookmarkVerse() {
    try {
      return split("/")[1];
    } catch (e) {
      return '';
    }
  }

  int getBookmarkVerseToIndex(int index) {
    try {
      return int.parse(split(":")[index]);
    } catch (e) {
      return 0;
    }
  }
}

extension BibleItemAssets on String {
  String bibleItemAssets() {
    switch (this) {
      case '창':
        return 'assets/images/bg_gn_test.jpg';
      case '출':
        return 'assets/images/bg_test.jpg';
      case '레':
        return 'assets/images/bg_test.jpg';
      case '민':
        return 'assets/images/bg_test.jpg';
      case '신':
        return 'assets/images/bg_test.jpg';
      case '수':
        return 'assets/images/bg_test.jpg';
      case '삿':
        return 'assets/images/bg_test.jpg';
      case '룻':
        return 'assets/images/bg_test.jpg';
      case '삼상':
        return 'assets/images/bg_test.jpg';
      case '삼하':
        return 'assets/images/bg_test.jpg';
      case '왕상':
        return 'assets/images/bg_test.jpg';
      case '왕하':
        return 'assets/images/bg_test.jpg';
      case '대상':
        return 'assets/images/bg_test.jpg';
      case '대하':
        return 'assets/images/bg_test.jpg';
      case '스':
        return 'assets/images/bg_test.jpg';
      case '느':
        return 'assets/images/bg_test.jpg';
      case '에':
        return 'assets/images/bg_test.jpg';
      case '욥':
        return 'assets/images/bg_test.jpg';
      case '시':
        return 'assets/images/bg_test.jpg';
      case '잠':
        return 'assets/images/bg_test.jpg';
      case '전':
        return 'assets/images/bg_test.jpg';
      case '아':
        return 'assets/images/bg_test.jpg';
      case '사':
        return 'assets/images/bg_test.jpg';
      case '렘':
        return 'assets/images/bg_test.jpg';
      case '애':
        return 'assets/images/bg_test.jpg';
      case '겔':
        return 'assets/images/bg_test.jpg';
      case '단':
        return 'assets/images/bg_test.jpg';
      case '호':
        return 'assets/images/bg_test.jpg';
      case '욜':
        return 'assets/images/bg_test.jpg';
      case '암':
        return 'assets/images/bg_test.jpg';
      case '옵':
        return 'assets/images/bg_test.jpg';
      case '욘':
        return 'assets/images/bg_test.jpg';
      case '미':
        return 'assets/images/bg_test.jpg';
      case '나':
        return 'assets/images/bg_test.jpg';
      case '합':
        return 'assets/images/bg_test.jpg';
      case '습':
        return 'assets/images/bg_test.jpg';
      case '학':
        return 'assets/images/bg_test.jpg';
      case '슥':
        return 'assets/images/bg_test.jpg';
      case '말':
        return 'assets/images/bg_test.jpg';
      case '마':
        return 'assets/images/bg_test.jpg';
      case '막':
        return 'assets/images/bg_test.jpg';
      case '눅':
        return 'assets/images/bg_test.jpg';
      case '요':
        return 'assets/images/bg_test.jpg';
      case '행':
        return 'assets/images/bg_test.jpg';
      case '롬':
        return 'assets/images/bg_test.jpg';
      case '고전':
        return 'assets/images/bg_test.jpg';
      case '고후':
        return 'assets/images/bg_test.jpg';
      case '갈':
        return 'assets/images/bg_test.jpg';
      case '엡':
        return 'assets/images/bg_test.jpg';
      case '빌':
        return 'assets/images/bg_test.jpg';
      case '골':
        return 'assets/images/bg_test.jpg';
      case '살전':
        return 'assets/images/bg_test.jpg';
      case '살후':
        return 'assets/images/bg_test.jpg';
      case '딤전':
        return 'assets/images/bg_test.jpg';
      case '딤후':
        return 'assets/images/bg_test.jpg';
      case '딛':
        return 'assets/images/bg_test.jpg';
      case '몬':
        return 'assets/images/bg_test.jpg';
      case '히':
        return 'assets/images/bg_test.jpg';
      case '약':
        return 'assets/images/bg_test.jpg';
      case '벧전':
        return 'assets/images/bg_test.jpg';
      case '벧후':
        return 'assets/images/bg_test.jpg';
      case '요일':
        return 'assets/images/bg_test.jpg';
      case '요이':
        return 'assets/images/bg_test.jpg';
      case '요삼':
        return 'assets/images/bg_test.jpg';
      case '유':
        return 'assets/images/bg_test.jpg';
      case '계':
        return 'assets/images/bg_test.jpg';

      default:
        return 'assets/images/placeholder.png';
    }
  }
}

extension BibleTitle on String {
  String bibleItemTitle() {
    switch (this) {
      case '창':
        return '창세기';
      case '출':
        return '출애굽기';
      case '레':
        return '레위기';
      case '민':
        return '민수기';
      case '신':
        return '신명기';
      case '수':
        return '여호수아';
      case '삿':
        return '사사기';
      case '룻':
        return '룻기';
      case '삼상':
        return '사무엘상';
      case '삼하':
        return '사무엘하';
      case '왕상':
        return '열왕기상';
      case '왕하':
        return '열왕기하';
      case '대상':
        return '역대상';
      case '대하':
        return '역대하';
      case '스':
        return '에스라';
      case '느':
        return '느헤미아';
      case '에':
        return '에스더';
      case '욥':
        return '욥기';
      case '시':
        return '시편';
      case '잠':
        return '잠언';
      case '전':
        return '전도서';
      case '아':
        return '아가';
      case '사':
        return '이사야';
      case '렘':
        return '예레미아';
      case '애':
        return '예레미아애가';
      case '겔':
        return '에스겔';
      case '단':
        return '다니엘';
      case '호':
        return '호세아';
      case '욜':
        return '요엘';
      case '암':
        return '아모스';
      case '옵':
        return '오바댜';
      case '욘':
        return '요나';
      case '미':
        return '미가';
      case '나':
        return '나훔';
      case '합':
        return '하박국';
      case '습':
        return '스바냐';
      case '학':
        return '학개';
      case '슥':
        return '스가랴';
      case '말':
        return '말라기';
      case '마':
        return '마태복음';
      case '막':
        return '마가복음';
      case '눅':
        return '누가복음';
      case '요':
        return '요한복음';
      case '행':
        return '사도행전';
      case '롬':
        return '로마서';
      case '고전':
        return '고린도전서';
      case '고후':
        return '고린도후서';
      case '갈':
        return '갈라디아서';
      case '엡':
        return '에베소서';
      case '빌':
        return '빌립보서';
      case '골':
        return '골로새서';
      case '살전':
        return '데살로니가전서';
      case '살후':
        return '데살로니가후서';
      case '딤전':
        return '디모데전서';
      case '딤후':
        return '디모데후서';
      case '딛':
        return '디도서';
      case '몬':
        return '빌레몬서';
      case '히':
        return '히브리서';
      case '약':
        return '야고보서';
      case '벧전':
        return '베드로전서';
      case '벧후':
        return '베드로후서';
      case '요일':
        return '요한1서';
      case '요이':
        return '요한2서';
      case '요삼':
        return '요한3서';
      case '유':
        return '유다서';
      case '계':
        return '요한계시록';

      default:
        return '';
    }
  }
}
