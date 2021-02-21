import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:eva_icons_flutter/icon_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hall/model/game.dart';
import 'package:hall/model/item.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:hall/style/theme.dart' as Style;

class GameDetailScreen extends StatefulWidget {
  final GameModel game;
  GameDetailScreen({Key key, @required this.game}) : super(key: key);
  @override
  _GameDetailScreenState createState() => _GameDetailScreenState(game);
}

class _GameDetailScreenState extends State<GameDetailScreen>
    with SingleTickerProviderStateMixin {
  final GameModel game;
  _GameDetailScreenState(this.game);

  YoutubePlayerController _controller;
  PageController pageController =
      PageController(viewportFraction: 1, keepPage: true);
  TabController _tabController;
  final tabs = <Item>[
    Item(id: 0, name: "OVERVIEW"),
    Item(id: 1, name: "SCREENSHOTS"),
  ];
  final customColors = CustomSliderColors(
    dotColor: Colors.white.withOpacity(0.8),
    trackColor: Style.Colors.backgroundColor,
    progressBarColor: Style.Colors.mainColor,
    hideShadow: true,
  );

  @override
  void initState() {
    _tabController = TabController(
      vsync: this,
      length: tabs.length,
    );
    _controller = YoutubePlayerController(
      initialVideoId: game.videos[0].videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.backgroundSecondaryColor,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 220,
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: false,
                ),
              ),
              Positioned(
                top: 20.0,
                left: 0.0,
                child: IconButton(
                  icon: Icon(
                    EvaIcons.arrowBack,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                bottom: 10.0,
                left: 10.0,
                child: Container(
                  height: 55.0,
                  width: 55.0,
                  child: SleekCircularSlider(
                    appearance: CircularSliderAppearance(
                      angleRange: 360,
                      customColors: customColors,
                      customWidths: CustomSliderWidths(
                        progressBarWidth: 4.0,
                        trackWidth: 2.0,
                      ),
                    ),
                    min: 0,
                    max: 100,
                    initialValue: game.rating,
                    innerWidget: (double value) {
                      return Column(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Hero(
                                tag: game.id,
                                child: ClipOval(
                                  child: Image.network(
                                    "https://images.igdb.com/igdb/image/upload/t_cover_big/${game.cover.imageId}.jpg",
                                    fit: BoxFit.cover,
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 26.0,
                left: 75.0,
                child: Text(
                  game.name,
                  style: TextStyle(
                    height: 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              )
            ],
          ),
          TabBar(
            controller: _tabController,
            indicatorColor: Style.Colors.mainColor,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 2.0,
            unselectedLabelColor: Colors.white,
            labelColor: Style.Colors.mainColor,
            isScrollable: false,
            tabs: tabs.map((Item tab) {
              return Container(
                padding: EdgeInsets.only(
                  bottom: 15.0,
                  top: 15.0,
                ),
                child: Text(
                  tab.name,
                  style: TextStyle(
                    fontSize: 13.0,
                  ),
                ),
              );
            }).toList(),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "SUMMARY",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        game.summary,
                        style: TextStyle(
                          height: 1.5,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10.0,
                        bottom: 10.0,
                        top: 15.0,
                      ),
                      child: Text(
                        "PERSPECTIVES",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      height: 30.0,
                      padding: EdgeInsets.only(left: 10.0, top: 5.0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: game.perspectives.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                border: Border.all(
                                  width: 1.0,
                                  color: Colors.white,
                                ),
                              ),
                              child: Text(
                                game.perspectives[index].name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10.0,
                        bottom: 10.0,
                        top: 10.0,
                      ),
                      child: Text(
                        "GENRES",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      height: 30.0,
                      padding: EdgeInsets.only(left: 10.0, top: 5.0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: game.genres.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                border: Border.all(
                                  width: 1.0,
                                  color: Colors.white,
                                ),
                              ),
                              child: Text(
                                game.genres[index].name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10.0,
                        bottom: 10.0,
                        top: 15.0,
                      ),
                      child: Text(
                        "MODES",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      height: 30.0,
                      padding: EdgeInsets.only(left: 10.0, top: 5.0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: game.modes.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                border: Border.all(
                                  width: 1.0,
                                  color: Colors.white,
                                ),
                              ),
                              child: Text(
                                game.modes[index].name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Expanded(
                      child: AnimationLimiter(
                        child: AnimationLimiter(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 10.0,
                              left: 10.0,
                              right: 10.0,
                            ),
                            child: GridView.count(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 1.33,
                              children: List.generate(game.screenshots.length,
                                  (int index) {
                                return AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  columnCount: 3,
                                  duration: Duration(
                                    milliseconds: 375,
                                  ),
                                  child: ScaleAnimation(
                                    child: AspectRatio(
                                      aspectRatio: 4 / 3,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              "https://images.igdb.com/igdb/image/upload/t_screenshot_big/${game.screenshots[index].imageId}.jpg",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
