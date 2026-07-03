import 'package:auto_route/auto_route.dart';
import 'package:book_house/di/injection.dart';
import 'package:book_house/features/analytics/presentation/pages/analytics_page.dart';
import 'package:book_house/features/contacts/presentation/pages/contacts_page.dart';
import 'package:book_house/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:book_house/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:book_house/features/home/presentation/cubit/home_cubit.dart';
import 'package:book_house/features/home/presentation/pages/home_page.dart';
import 'package:book_house/features/profile/presentation/pages/profile_page.dart';
import 'package:book_house/features/search/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const pages = [
    HomePage(),
    AnalyticsPage(),
    SearchPage(),
    ContactsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DashboardCubit()),

        BlocProvider(create: (_) => sl<HomeCubit>()..fetchBooks()),
      ],
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(index: state.currentIndex, children: pages),

            bottomNavigationBar: NavigationBar(
              selectedIndex: state.currentIndex,
              height: 75,
              onDestinationSelected: (index) {
                context.read<DashboardCubit>().changeTab(index);
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.bar_chart_outlined),
                  selectedIcon: Icon(Icons.bar_chart),
                  label: 'Analytics',
                ),
                NavigationDestination(
                  icon: Icon(Icons.search_outlined),
                  selectedIcon: Icon(Icons.search),
                  label: 'Search',
                ),
                NavigationDestination(
                  icon: Icon(Icons.people_outline),
                  selectedIcon: Icon(Icons.people),
                  label: 'Contacts',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
