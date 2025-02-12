import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scmc_church_project/domain/models/main_item_data.dart';
import 'package:scmc_church_project/ui/bible/page/select_bible_category_screen.dart';
import 'package:scmc_church_project/ui/detail/main_carousel_detail_screen.dart';
import 'package:scmc_church_project/ui/main/widget/bottom_navigation_item_widget.dart';
import 'package:scmc_church_project/ui/main/widget/home/navigation_item_home_widget.dart';
import 'package:scmc_church_project/ui/splash/bloc/splash_init_bloc.dart';
import 'package:scmc_church_project/ui/splash/bloc/splash_init_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<Widget> _mainBottomNavItems;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      initMainBottomNavItems(_selectedIndex);
    });
  }

  @override
  void initState() {
    super.initState();

    initMainBottomNavItems(_selectedIndex);
  }

  /// 메인 바텀 네비게이션 아이템 초기화
  void initMainBottomNavItems(int selectedIndex) {
    _mainBottomNavItems = [
      Flexible(
        flex: 1,
        child: mainBottomNavigationItem(
          iconData: _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
          onClick: () {
            _onItemTapped(0);
          },
          label: "홈",
          isSelected: _selectedIndex == 0,
        ),
      ),
      Flexible(
        flex: 1,
        child: mainBottomNavigationItem(
          iconData: Icons.search,
          onClick: () {
            _onItemTapped(1);
          },
          label: "검색",
          isSelected: _selectedIndex == 1,
        ),
      ),
      Flexible(flex: 1, child: Container()),
      Flexible(
        flex: 1,
        child: mainBottomNavigationItem(
          iconData: Icons.print,
          onClick: () {
            _onItemTapped(3);
          },
          label: "인쇄",
          isSelected: _selectedIndex == 3,
        ),
      ),
      Flexible(
        flex: 1,
        child: mainBottomNavigationItem(
          iconData: Icons.people,
          onClick: () {
            _onItemTapped(4);
          },
          label: "인물",
          isSelected: _selectedIndex == 4,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SplashInitBloc, SplashInitState>(
        builder: (context, state) {
          return Center(
            child: mainBody(
              mainItemData: state.mainItemData,
            ),
          );
        },
      ),
      extendBody: true,
      floatingActionButton: SizedBox(
        width: 75,
        height: 75,
        child: FloatingActionButton(
          /// 성경 찾기 FAB
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SelectBibleCategoryScreen()));
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.book),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        color: Colors.cyan.shade400,
        notchMargin: 10,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _mainBottomNavItems,
        ),
      ),
    );
  }

// TODO: 성경 퀴즈 ??
  /// 메인 위젯
  Widget mainBody({
    required MainItemData? mainItemData,
  }) {
    switch (_selectedIndex) {
      case 0:
        return navItemHomeWidget(
          mainItemData: mainItemData,
          maxWidth: MediaQuery.of(context).size.width,
          onTapCarouselItem: (mainCarouselData) {
            /// 상세 페이지 이동
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MainCarouselDetailScreen(
                  data: mainCarouselData,
                ),
              ),
            );
          },
        );
      case 1:
        return Container(
          color: Colors.amberAccent,
          child: Text("Search Screen!!!"),
        );
      case 3:
        return Container(
          color: Colors.amberAccent,
          child: Text("Print Screen!!!"),
        );
      case 4:
        return Container(
          color: Colors.amberAccent,
          child: Text("People Screen!!!"),
        );
      default:
        return Container(
          color: Colors.amberAccent,
          child: Text("Main Screen!!!"),
        );
    }
  }
}
