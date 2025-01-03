import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scmc_church_project/injectable/configurations.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_bloc.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_state.dart';
import 'package:scmc_church_project/ui/bible/widget/bible_category_widget.dart';
import 'package:scmc_church_project/ui/bible/widget/bible_result_widget.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_event.dart';

class BibleScreen extends StatelessWidget {
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
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Stack(
                children: [
                  _bibleScreenBody(state),
                  _isShowCircularProgressIndicator(
                      state.status == BibleStatus.loading),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _bibleScreenBody(BibleState state) {
    switch (state.status) {
      case BibleStatus.success:
        return state.page == BiblePage.bibleCategory
            ? BibleCategoryWidget()
            : BibleResultWidget();
      case BibleStatus.error:
        return Container();
      default:
        return Container();
    }
  }

  Widget _isShowCircularProgressIndicator(bool isLoading) {
    if (isLoading) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white60,
        child: const Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Container();
    }
  }
}
