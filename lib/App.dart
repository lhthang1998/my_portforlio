import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/about/About.dart';
import 'package:my_portfolio/contact/Contact.dart';
import 'package:my_portfolio/home/Home.dart';
import 'package:my_portfolio/navbar/Navbar.dart';
import 'package:my_portfolio/skill/Skill.dart';
import 'package:scroll_to_id/scroll_to_id.dart';

import 'exp/Experience.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int currentIndex = 0;
  ScrollToId scrollToId;
  final ScrollController controller = ScrollController();

  void _scrollListener() {
    int widgetIndex = int.parse(scrollToId.idPosition());
    if (widgetIndex != currentIndex) {
      setState(() {
        currentIndex = widgetIndex;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// Create ScrollToId instance
    scrollToId = ScrollToId(scrollController: controller);
    controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height *
        MediaQuery.of(context).devicePixelRatio;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: NavigationBar(
            index: currentIndex,
            scrollToId: scrollToId,
          ),
        ),
        extendBodyBehindAppBar: true,
        extendBody: true,
        resizeToAvoidBottomInset: true,
        floatingActionButton: currentIndex != 0
            ? FloatingActionButton(
                child: Icon(
                  Icons.arrow_upward,
                  size: 30,
                ),
                backgroundColor: Colors.blue,
                onPressed: () {
                  scrollToId.animateTo("0",
                      duration: Duration(seconds: 1), curve: Curves.ease);
                })
            : null,
        body: SafeArea(
          child: AnimateIfVisibleWrapper(
            controller: controller,
            child: InteractiveScrollViewer(scrollToId: scrollToId, children: [
              ScrollContent(id: '0', child: Home()),
              ScrollContent(
                id: '1',
                child: About(),
              ),
              ScrollContent(id: '2', child: Experience()),
              ScrollContent(
                id: '3',
                child: Skill(),
              ),
              ScrollContent(
                id: '4',
                child: Contact(),
              ),
            ]),
          ),
        ));
  }
}
