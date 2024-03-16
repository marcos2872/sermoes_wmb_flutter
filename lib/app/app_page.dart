import 'package:flutter/material.dart';
import 'package:sermoes_wmb_flutter/app/favorite/favorite_page.dart';
import 'package:sermoes_wmb_flutter/app/home/home_page.dart';
import 'package:sermoes_wmb_flutter/app/search/search_page.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int initialPage = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();

    pc = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
          data: ThemeData(
            colorScheme: ColorScheme.dark(background: Theme.of(context).colorScheme.background),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            selectedIconTheme: IconThemeData(
                color: Theme.of(context).colorScheme.surface,  size: 25),
            unselectedIconTheme: IconThemeData(
                color: Theme.of(context).colorScheme.onSurface, size: 20),
            currentIndex: initialPage,
            enableFeedback: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search_rounded), label: 'search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border_rounded), label: 'message'),
            ],
            onTap: (value) {
              pc.animateToPage(value,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease);
            },
          )),
      body: PageView(
        controller: pc,
        children: const [HomePage(), SearchPage(), FavoritePage()],
        onPageChanged: (value) {
          setState(() {
            initialPage = value;
          });
        },
      ),
    );
  }
}
