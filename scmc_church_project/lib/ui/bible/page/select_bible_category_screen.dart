import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_bloc.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_state.dart';
import 'package:scmc_church_project/ui/bible/widget/bible_category_body_widget.dart';
import 'package:scmc_church_project/ui/bible/widget/bible_chapter_body_widget.dart';
import 'package:scmc_church_project/ui/bible/widget/bible_loading_widget.dart';
import 'package:scmc_church_project/injectable/configurations.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_event.dart';
import 'package:scmc_church_project/domain/models/bible_chapter_data.dart';

typedef OnBackPressed = void Function();

class SelectBibleCategoryScreen extends StatefulWidget {
  @override
  _SelectBibleCategoryScreenState createState() =>
      _SelectBibleCategoryScreenState();
}

class _SelectBibleCategoryScreenState extends State<SelectBibleCategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// 성경 찾기 화면에서 뒤로가기 버튼 클릭 시 이벤트 처리
  void _onBackPressed({
    required currentPage,
    required onBackPressed,
  }) {
    if (currentPage == BiblePage.bibleChapter) {
      /// 성경 장/절 선택 -> 구약/신약 선택으로 이동
      onBackPressed();
    } else {
      Navigator.of(context).pop();
    }
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<BibleBloc>()..add(InitFetchBibleDataEvent()),
        ),
      ],
      child: BlocBuilder<BibleBloc, BibleState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("성경 찾기"),
              leading: IconButton(
                onPressed: () {
                  _onBackPressed(
                      currentPage: state.page,
                      onBackPressed: () {
                        context.read<BibleBloc>().add(
                              ChangeBibleAbbrevEvent(
                                BiblePage.bibleCategory,
                                '',
                              ),
                            );
                      });
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Stack(
                children: [
                  if (state.page == BiblePage.bibleCategory)
                    bibleCategoryBody(
                      state: state,
                      tabController: _tabController,
                      onTapCallback: (abbrev) {
                        /// 성경 구약/신약 선택 이벤트
                        context.read<BibleBloc>().add(
                              ChangeBibleAbbrevEvent(
                                BiblePage.bibleChapter,
                                abbrev,
                              ),
                            );
                      },
                    ),
                  if (state.page == BiblePage.bibleChapter)
                    bibleChapterBody(
                      selectedData: _getSelectedBibleChapter(
                        selectedAbbrev: state.abbrev,
                        list: state.allTestamentList,
                      ),
                    ),
                  isShowBibleLoading(
                      isLoading: state.status == BibleStatus.loading),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
