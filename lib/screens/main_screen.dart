import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hall/bloc/switch_bloc.dart';
import 'package:hall/screens/discover_screens/discover_screen_grid.dart';
import 'package:hall/screens/discover_screens/discover_screen_list.dart';
import 'package:hall/style/theme.dart' as Style;
import 'package:hall/widgets/home_slider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  PageController _pageController;
  SwitchBloc _switchBloc;
  GlobalKey bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _switchBloc = SwitchBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _showGrid() {
    _switchBloc.showGrid();
  }

  void _showList() {
    _switchBloc.showList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF20232A),
      appBar: PreferredSize(
        child: Container(),
        preferredSize: Size.fromHeight(0.0),
      ),
      body: SizedBox.expand(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: [
            Column(
              children: [
                HomeSlider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Popular game right now".toUpperCase(),
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    StreamBuilder(
                        stream: _switchBloc.itemStream,
                        initialData: _switchBloc.defaultItem,
                        // ignore: missing_return
                        builder: (BuildContext context,
                            AsyncSnapshot<SwitchItem> snapshot) {
                          switch (snapshot.data) {
                            case SwitchItem.LIST:
                              return IconButton(
                                  icon: Icon(
                                    SimpleLineIcons.list,
                                    size: 18.0,
                                    color: Colors.white,
                                  ),
                                  onPressed: _showGrid);
                            case SwitchItem.GRID:
                              return IconButton(
                                  icon: Icon(
                                    SimpleLineIcons.grid,
                                    size: 18.0,
                                    color: Colors.white,
                                  ),
                                  onPressed: _showList);
                          }
                        }),
                  ],
                ),
                Expanded(
                  child: StreamBuilder<SwitchItem>(
                      stream: _switchBloc.itemStream,
                      initialData: _switchBloc.defaultItem,
                      builder: (BuildContext context,
                          AsyncSnapshot<SwitchItem> snapshot) {
                        switch (snapshot.data) {
                          case SwitchItem.LIST:
                            return DiscoverScreenGrid();
                          case SwitchItem.GRID:
                            return DiscoverScreenList();
                        }
                      }),
                )
              ],
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Search Screen",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Console Screen",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Profile Screen",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        child: BottomNavyBar(
          containerHeight: 56.0,
          backgroundColor: Style.Colors.backgroundColor,
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() => _currentIndex = index);
            _pageController.jumpToPage(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              activeColor: Color(0xFF010101),
              title: Text(
                'Discover',
                style: TextStyle(color: Style.Colors.mainColor, fontSize: 13.0),
              ),
              icon: Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Icon(
                  SimpleLineIcons.game_controller,
                  size: 18.0,
                  color: _currentIndex == 0
                      ? Style.Colors.mainColor
                      : Colors.white,
                ),
              ),
            ),
            BottomNavyBarItem(
              activeColor: Color(0xFF010101),
              title: Text(
                'Search',
                style: TextStyle(color: Style.Colors.mainColor, fontSize: 13.0),
              ),
              icon: Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Icon(
                  SimpleLineIcons.magnifier,
                  size: 18.0,
                  color: _currentIndex == 1
                      ? Style.Colors.mainColor
                      : Colors.white,
                ),
              ),
            ),
            BottomNavyBarItem(
              activeColor: Color(0xFF010101),
              title: Text(
                'Consoles',
                style: TextStyle(color: Style.Colors.mainColor, fontSize: 13.0),
              ),
              icon: Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Icon(
                  SimpleLineIcons.layers,
                  size: 18.0,
                  color: _currentIndex == 2
                      ? Style.Colors.mainColor
                      : Colors.white,
                ),
              ),
            ),
            BottomNavyBarItem(
              activeColor: Color(0xFF010101),
              title: Text(
                'Profile',
                style: TextStyle(color: Style.Colors.mainColor, fontSize: 13.0),
              ),
              icon: Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Icon(
                  SimpleLineIcons.user,
                  size: 18.0,
                  color: _currentIndex == 3
                      ? Style.Colors.mainColor
                      : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
