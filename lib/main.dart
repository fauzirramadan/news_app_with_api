import 'package:flutter/material.dart';
import 'package:flutter_day3/session_manager.dart';
import 'package:flutter_day3/splash_screen.dart';
import 'nested_json.dart';
import 'news_page.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}

class MenuTab extends StatefulWidget {
  const MenuTab({Key? key}) : super(key: key);

  @override
  State<MenuTab> createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> with SingleTickerProviderStateMixin {
  TabController? tabController;
  SessionManager session = SessionManager();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
              tooltip: "Log Out",
              onPressed: () async {
                await session.clearSession(context);
              },
              icon: const Icon(Icons.logout_sharp))
        ],
        title: const Text("Welcome"),
        bottom: TabBar(controller: tabController, tabs: const [
          Tab(
            text: "Nested Json",
          ),
          Tab(
            text: "News",
          ),
        ]),
      ),
      body: TabBarView(controller: tabController, children: [
        NestedJson(),
        NewsPage(),
      ]),
    );
  }
}
