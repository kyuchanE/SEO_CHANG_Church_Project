import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scmc_church_project/core/resources/config.dart';
import 'package:scmc_church_project/core/utils/utils_extension.dart';
import 'package:scmc_church_project/domain/models/bible_chapter_data.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_bloc.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_event.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_state.dart';
import 'package:scmc_church_project/ui/common/widget/common_bg_trans_parents_appbar_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:turn_page_transition/turn_page_transition.dart';

typedef OnTapBiblePageNavigatorCallback = void Function(
    {required bool isPrevious});
typedef OnTapZoomInOutCallback = void Function({required bool isZoomIn});

const double pageNavigatorButtonSize = 80.0;
const double buttonOpacity = 0.2;

/// 성경 구절 결과 페이지
class BibleResultScreen extends StatefulWidget {
  const BibleResultScreen({super.key});

  @override
  _BibleResultScreenState createState() => _BibleResultScreenState();
}

class _BibleResultScreenState extends State<BibleResultScreen> {
  List<BibleChapterData>? bibleItemList; // 성경 구절 리스트
  int categoryIndex = 0; // 구약/신약 Index
  int chapterIndex = 0; // 성경 장 Index
  int verseIndex = 0; // 성경 절 Index
  int lastStayVerseIndex = 0; // 마지막 머무른 성경 절 Index
  String bgAssets = bibleDefaultImg; // 배경 이미지 Assets
  double bibleVerseFontSize = 30.0; // 성경 구절 폰트 사이즈
  late bool isFirstBiblePage; // 성경 페이지 처음 여부
  late bool isLastBiblePage; // 성경 페이지 마지막 여부

  ItemScrollController? _itemScrollController;
  ScrollOffsetController? _scrollOffsetController;
  ItemPositionsListener? _itemPositionsListener;
  ScrollOffsetListener? _scrollOffsetListener;

  @override
  void initState() {
    super.initState();

    BibleState bibleState = context.read<BibleBloc>().state;
    isFirstBiblePage = bibleState.isFirstBiblePage;
    isLastBiblePage = bibleState.isLastBiblePage;
    bibleItemList = bibleState.allTestamentList;
    if (bibleItemList != null) {
      for (int i = 0; i < bibleItemList!.length; i++) {
        if ((bibleState.abbrev ?? "") == bibleItemList![i].abbreviation) {
          categoryIndex = i;
          break;
        }
      }

      try {
        List<String> chapterVerse = (bibleState.verse ?? "").split(":");
        chapterIndex = int.parse(chapterVerse[0]);
        verseIndex = int.parse(chapterVerse[1]);
      } catch (e) {}

      bgAssets = bibleItemList![categoryIndex].abbreviation.bibleItemAssets();

      _initScrollController();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// scrollable_positioned_list 초기화
  void _initScrollController() {
    _itemScrollController = ItemScrollController();
    _scrollOffsetController = ScrollOffsetController();
    _itemPositionsListener = ItemPositionsListener.create()
      ..itemPositions.addListener(() {
        final positions = _itemPositionsListener?.itemPositions.value;
        final firstVisibleItem = positions
            ?.where((ItemPosition position) => position.itemLeadingEdge >= 0)
            .reduce((ItemPosition min, ItemPosition position) =>
                position.itemLeadingEdge < min.itemLeadingEdge
                    ? position
                    : min);
        print('First visible item index: ${firstVisibleItem?.index}');
        lastStayVerseIndex = firstVisibleItem?.index ?? 0;
        _refreshBookmarkUi();
      });
    _scrollOffsetListener = ScrollOffsetListener.create();
  }

  /// 북마크 클릭
  void _onTabBibleBookmark() {
    final String bookMarkItem =
        '${bibleItemList![categoryIndex].abbreviation}/$chapterIndex:$lastStayVerseIndex';
    final Completer bookmarkEventCompleter = Completer<void>();
    context.read<BibleBloc>().add(
          BookmarkEvent(bookMarkItem, bookmarkEventCompleter),
        );
  }

  /// 북마크 UI 갱신
  void _refreshBookmarkUi() {
    context.read<BibleBloc>().add(
          BookmarkVisibleEvent(
              '${bibleItemList![categoryIndex].abbreviation}/$chapterIndex:$lastStayVerseIndex'),
        );
  }

  /// 성경 구절 변경
  void _changeVersePage({required bool isPrevious}) async {
    final Completer changeVerseEventCompleter = Completer<void>();
    if (isPrevious) {
      /// 이전
      context.read<BibleBloc>().add(
            PreviousBiblePageEvent(changeVerseEventCompleter),
          );
    } else {
      /// 다음
      context.read<BibleBloc>().add(
            NextBiblePageEvent(changeVerseEventCompleter),
          );
    }
    await changeVerseEventCompleter.future;

    if (mounted) {
      Navigator.of(context).pushReplacement(
        TurnPageRoute(
          overleafColor: Colors.grey,
          animationTransitionPoint: 0.5,
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          builder: (context) => const BibleResultScreen(),
        ),
      );
    }
  }

  /// 확대 축소
  void _zommInOut({required bool isZoomIn}) {
    setState(() {
      if (isZoomIn) {
        /// 확대
        bibleVerseFontSize += 10.0;
      } else {
        /// 축소
        if (bibleVerseFontSize > 30.0) {
          bibleVerseFontSize -= 10.0;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BibleBloc, BibleState>(
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Stack(
              children: [
                /// bg
                _backgroundImageContainer(),

                /// bible contents
                _bibleVerseBody(
                  isBookmark: state.isBookmark,
                ),

                /// page navigator button
                _floatingBtnContainer(
                  /// 확대 축소
                  onTapZoomInOutCallback: ({required isZoomIn}) =>
                      _zommInOut(isZoomIn: isZoomIn),

                  /// 이전, 다음
                  onTapPageNavigatorCallback: ({required isPrevious}) =>
                      _changeVersePage(isPrevious: isPrevious),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// 배경 이미지
  Widget _backgroundImageContainer() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.3),
          BlendMode.dstATop,
        ),
        child: Image.asset(
          bgAssets,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// 선탠된 성경 구절
  Widget _bibleVerseBody({
    required bool isBookmark,
  }) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          /// top appbar
          bgTransParentsActionIconAppbar(
            onTapBackCallback: () {
              Navigator.of(context).pop();
            },
            onTabAppbarActionCallback: () => _onTabBibleBookmark(),
            padding: const EdgeInsets.only(
              top: 60.0,
              left: 15.0,
              right: 15.0,
              bottom: 20.0,
            ),
            title:
                "${bibleItemList![categoryIndex].name} ${chapterIndex + 1} 장",
            actionIcon: isBookmark ? Icons.bookmark : Icons.bookmark_border,
          ),

          /// bible verse
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 35.0,
                  right: 35.0,
                  bottom: 65.0,
                ),
                child: ScrollablePositionedList.separated(
                  initialScrollIndex: verseIndex,
                  itemScrollController: _itemScrollController,
                  scrollOffsetController: _scrollOffsetController,
                  itemPositionsListener: _itemPositionsListener,
                  scrollOffsetListener: _scrollOffsetListener,
                  itemCount: bibleItemList![categoryIndex]
                      .chapters[chapterIndex]
                      .length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${index + 1}.',
                          style: TextStyle(
                            fontSize: bibleVerseFontSize,
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              bibleItemList![categoryIndex]
                                  .chapters[chapterIndex][index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: bibleVerseFontSize,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.black,
                      thickness: 1.0,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 플로팅 버튼 컨테이너 (성경 구절 이동 / 확대 축소)
  Widget _floatingBtnContainer({
    required OnTapBiblePageNavigatorCallback onTapPageNavigatorCallback,
    required OnTapZoomInOutCallback onTapZoomInOutCallback,
  }) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: 70.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _zoomInOutButton(onTap: onTapZoomInOutCallback),
            Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: _pageNavigatorButton(
                  onTap: onTapPageNavigatorCallback,
                )),
          ],
        ),
      ),
    );
  }

  /// 확대 축소 버튼
  Widget _zoomInOutButton({
    required OnTapZoomInOutCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Align(
        alignment: Alignment.topRight,
        child: Column(
          children: [
            /// +
            IconButton(
              onPressed: () => onTap(isZoomIn: true),
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(buttonOpacity),
                  BlendMode.srcIn,
                ),
                child: const Icon(
                  Icons.add_circle,
                  size: pageNavigatorButtonSize,
                ),
              ),
            ),

            /// -
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: IconButton(
                onPressed: () => onTap(isZoomIn: false),
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(buttonOpacity),
                    BlendMode.srcIn,
                  ),
                  child: const Icon(
                    Icons.remove_circle,
                    size: pageNavigatorButtonSize,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 성경 구절 이동 버튼 (이전, 다음)
  Widget _pageNavigatorButton({
    required OnTapBiblePageNavigatorCallback onTap,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _pageNavigatorBtnIcon(
          isShow: !isFirstBiblePage,
          iconButton: IconButton(
            onPressed: () => onTap(isPrevious: true),
            icon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(buttonOpacity),
                BlendMode.srcIn,
              ),
              child: const Icon(
                Icons.arrow_circle_left,
                size: pageNavigatorButtonSize,
              ),
            ),
          ),
        ),
        _pageNavigatorBtnIcon(
          isShow: !isLastBiblePage,
          iconButton: IconButton(
            onPressed: () => onTap(isPrevious: false),
            icon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(buttonOpacity),
                BlendMode.srcIn,
              ),
              child: const Icon(
                Icons.arrow_circle_right,
                size: pageNavigatorButtonSize,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 성경 구절 이동 버튼 아이콘
  Widget _pageNavigatorBtnIcon({
    required bool isShow,
    required Widget iconButton,
  }) {
    if (isShow) {
      return iconButton;
    } else {
      return Container();
    }
  }
}
