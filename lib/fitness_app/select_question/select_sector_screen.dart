import 'package:best_flutter_ui_templates/fitness_app/fitness_app_theme.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/sector_list_data.dart';
import 'package:best_flutter_ui_templates/fitness_app/select_question/sectors_list_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:best_flutter_ui_templates/fitness_app/hotel_app_theme.dart';

// 재준 : 섹터를 선택 하는 화면 구현-> 해당 화면에 필요현 list_view, model도 구현
class SelectSectorScreen extends StatefulWidget {
  const SelectSectorScreen({Key? key, this.animationController})
      : super(key: key);

  final AnimationController? animationController;
  @override
  _SelectSectorScreenState createState() => _SelectSectorScreenState();
}

class _SelectSectorScreenState extends State<SelectSectorScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;
  List<SectorListData> sectorList = SectorListData.sectorList;
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 115, left: 5, right: 5, bottom: 115),
              child: Container(
                color: FitnessAppTheme.white.withOpacity(topBarOpacity),
                child: ListView.builder(
                  itemCount: sectorList.length,
                  padding: const EdgeInsets.only(top: 8),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    final int count =
                        sectorList.length > 10 ? 10 : sectorList.length;
                    final Animation<double> animation =
                        Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                                parent: widget.animationController!,
                                curve: Interval((1 / count) * index, 1.0,
                                    curve: Curves.fastOutSlowIn)));
                    widget.animationController?.forward();
                    return SectorsListView(
                      callback: () {},
                      sectorData: sectorList[index],
                      animation: animation,
                      animationController: widget.animationController!,
                    );
                  },
                ),
              ),
            ),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FitnessAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'CRUX',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: FitnessAppTheme.darkerText,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}

Widget getSearchBarUI() {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            child: Container(
              decoration: BoxDecoration(
                color: HotelAppTheme.buildLightTheme().colorScheme.background,
                borderRadius: const BorderRadius.all(
                  Radius.circular(38.0),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(0, 2),
                      blurRadius: 8.0),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 4, bottom: 4),
                child: TextField(
                  onChanged: (String txt) {},
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  cursorColor: HotelAppTheme.buildLightTheme().primaryColor,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '클라이밍장 이름을 입력하세요',
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: HotelAppTheme.buildLightTheme().primaryColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(38.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  offset: const Offset(0, 2),
                  blurRadius: 8.0),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(32.0),
              ),
              // onTap: () {
              //   FocusScope.of(context).requestFocus(FocusNode());
              // },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(FontAwesomeIcons.magnifyingGlass,
                    size: 20,
                    color:
                        HotelAppTheme.buildLightTheme().colorScheme.background),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
