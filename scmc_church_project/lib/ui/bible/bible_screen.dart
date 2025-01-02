import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_bloc.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_state.dart';
import 'package:scmc_church_project/ui/bible/widget/bible_category_widget.dart';
import 'package:scmc_church_project/ui/bible/widget/bible_result_widget.dart';

class BibleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BibleBloc()),
      ],
      child: BlocBuilder<BibleBloc, BibleState>(
        builder: (context, state) {
          return state.page == BiblePage.bibleCategory
              ? BibleCategoryWidget()
              : BibleResultWidget();
        },
      ),
    );
  }
}
