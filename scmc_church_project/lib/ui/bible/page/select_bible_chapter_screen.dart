import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scmc_church_project/core/resources/config.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_bloc.dart';
import 'package:scmc_church_project/ui/bible/page/bible_result_screen.dart';
import 'package:scmc_church_project/ui/bible/widget/bible_chapter_body_widget.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_event.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_state.dart';
import 'package:scmc_church_project/domain/models/bible_chapter_data.dart';
import 'package:scmc_church_project/ui/common/widget/common_bg_trans_parents_appbar_widget.dart';

typedef OnTapBibleChapterCallback = void Function(
    {required int? leftIndex, required int? rightIndex});

/// 성경 선택 화면
class SelectBibleChapterScreen extends StatefulWidget {
  const SelectBibleChapterScreen({super.key});

  @override
  _SelectBibleChapterScreenState createState() =>
      _SelectBibleChapterScreenState();
}

class _SelectBibleChapterScreenState extends State<SelectBibleChapterScreen> {
  BibleChapterData? selectedBibleChapter;
  int selectedLeftIndex = 0;
  int? selectedRightIndex;

  @override
  void initState() {
    super.initState();
    selectedBibleChapter = _getSelectedBibleChapter(
      selectedAbbrev: context.read<BibleBloc>().state.abbrev,
      list: context.read<BibleBloc>().state.allTestamentList,
    );
  }

  /// 선택된 성경
  BibleChapterData? _getSelectedBibleChapter({
    required String? selectedAbbrev,
    required List<BibleChapterData>? list,
  }) {
    BibleChapterData? returnValue;
    if (list != null) {
      for (var element in list) {
        if (selectedAbbrev == element.abbreviation) {
          returnValue = element;
          break;
        }
      }
    }
    return returnValue;
  }

  /// 성경 장/절 선택
  void _selectedListItem({
    required int leftIndex,
    required int? rightIndex,
  }) {
    setState(() {
      selectedLeftIndex = leftIndex;
      selectedRightIndex = rightIndex;
    });
  }

  /// 결과 페이지 이동
  Future _onPressedNextButton() async {
    if (selectedRightIndex == null) {
      /// 선택 관련 에러 메시지
    } else {
      /// Result Screen
      final bibleVerseEventCompleter = Completer<void>();
      context.read<BibleBloc>().add(
            ChangeBibleVerseEvent(
              "$selectedLeftIndex:${selectedRightIndex ?? "0"}",
              bibleVerseEventCompleter,
            ),
          );
      await bibleVerseEventCompleter.future;
      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const BibleResultScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BibleBloc, BibleState>(builder: (context, state) {
      return Scaffold(
        floatingActionButton: SizedBox(
          width: 80.0, // Set the desired width
          height: 80.0, // Set the desired height
          child: FloatingActionButton(
            enableFeedback: true,
            onPressed: () => _onPressedNextButton(),
            backgroundColor: Colors.blueGrey, // Change background color
            foregroundColor: Colors.white, // Change icon color
            shape: const CircleBorder(),
            elevation: 10.0,
            child: const Icon(
              Icons.search_outlined,
              size: 45.0,
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              /// 상단 - appbar + 선택된 성경 정보 (배경 이미지)
              Stack(
                children: [
                  _topBgContainer(
                    bgAssets:
                        selectedBibleChapter?.bgAssets ?? biblePlaceHolder,
                    title: selectedBibleChapter?.name ?? "",
                    summary: selectedBibleChapter?.summary ?? "",
                  ),
                  bgTransParentsAppbar(
                    onTapBackCallback: () => Navigator.of(context).pop(),
                  ),
                ],
              ),

              /// Content - 성경 장/절 선택
              Expanded(
                flex: 1,
                child: bibleChapterBody(
                  selectedData: selectedBibleChapter,
                  selectedLeftIndex: selectedLeftIndex,
                  selectedRightIndex: selectedRightIndex,
                  onTapBibleChapter: ({
                    required leftIndex,
                    required rightIndex,
                  }) {
                    _selectedListItem(
                      leftIndex: leftIndex ?? selectedLeftIndex,
                      rightIndex: rightIndex,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  /// 상단 배경 이미지/타이틀
  Widget _topBgContainer({
    String bgAssets = biblePlaceHolder,
    String title = "",
    String summary = "",
  }) {
    return SizedBox(
      width: double.infinity,
      height: 300.0,
      child: Stack(
        children: [
          /// 배경 이미지
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.35),
              BlendMode.dstATop,
            ),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: FadeInImage(
                placeholder: const AssetImage(biblePlaceHolder),
                image: AssetImage(bgAssets),
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, _) {
                  return Image.asset(
                    biblePlaceHolder,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),

          /// 선택된 성경 정보
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  /// Title
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 30.0,
                    ),
                  ),

                  /// Summary
                  Padding(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                        right: 15.0,
                        left: 15.0,
                      ),
                      child: Text(
                        summary,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21.0,
                          color: Colors.black,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
