import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_bloc.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_state.dart';
import 'package:scmc_church_project/ui/bible/page/select_bible_chapter_screen.dart';
import 'package:scmc_church_project/ui/bible/widget/bible_category_body_widget.dart';
import 'package:scmc_church_project/ui/common/widget/common_loading_widget.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_event.dart';

typedef OnBackPressed = void Function();

/// 성경 카테고리 선택 화면
class SelectBibleCategoryScreen extends StatefulWidget {
  const SelectBibleCategoryScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BibleBloc, BibleState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("성경 찾기"),
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
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
                bibleCategoryBody(
                  state: state,
                  tabController: _tabController,
                  onTapCallback: (abbrev) {
                    /// 성경 구약/신약 선택 이벤트
                    context.read<BibleBloc>().add(
                          ChangeBibleAbbrevEvent(
                            abbrev,
                          ),
                        );
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SelectBibleChapterScreen()));
                  },
                ),
                isShowBibleLoading(
                    isLoading: state.status == BibleStatus.loading),
              ],
            ),
          ),
        );
      },
    );
  }
}
