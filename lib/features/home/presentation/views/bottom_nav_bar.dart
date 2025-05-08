import 'package:codekids/core/utils/assets.dart';
import 'package:codekids/features/courses/presentation/views/courses_view.dart';
import 'package:codekids/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../games/presentation/views/games_view.dart';
import '../manger/bottom_nav_bar/bottom_nav_bar_cubit.dart';


class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  final PersistentTabController controller = PersistentTabController(initialIndex: 0);

  final List<Widget> screens = [
    HomeView(),
    GamesView(),
    CoursesView(),
    HomeView(),
  ];

  final List<PersistentBottomNavBarItem> navBarItems = [
    PersistentBottomNavBarItem(
      title: 'Home',
      icon: Image.asset(AssetsData.homeBottomBar),
      inactiveIcon: Image.asset(AssetsData.homeBottomBar, color: Color(0xff161C2B)),
    ),
    PersistentBottomNavBarItem(
      title: 'Games',
      icon: Image.asset(AssetsData.gamesBottomBar, color: Color(0xff4D8AF0)),
      inactiveIcon: Image.asset(AssetsData.gamesBottomBar),
    ),
    PersistentBottomNavBarItem(
      title: 'Videos',
      icon: Image.asset(AssetsData.videosBottomBar, color: Color(0xff4D8AF0)),
      inactiveIcon: Image.asset(AssetsData.videosBottomBar),
    ),
    PersistentBottomNavBarItem(
      title: 'Account',
      icon: Image.asset(AssetsData.accountBottomBar, color: Color(0xff4D8AF0)),
      inactiveIcon: Image.asset(AssetsData.accountBottomBar),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, int>(
      builder: (context, state) {
        return PersistentTabView(
          context,
          controller: PersistentTabController(initialIndex: state),
          screens: screens,
          items: navBarItems,
          onItemSelected: (index) {
            context.read<BottomNavBarCubit>().changeIndex(index);
          },
        );
      },
    );
  }
}
