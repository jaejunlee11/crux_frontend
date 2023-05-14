import 'package:best_flutter_ui_templates/fitness_app/fitness_app_home_screen_inShow.dart';
import 'package:best_flutter_ui_templates/fitness_app/hotel_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/sector_list_data.dart';

class SectorsListView extends StatelessWidget {
  const SectorsListView(
      {Key? key,
      this.sectorData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final SectorListData? sectorData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: callback,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FitnessAppHomeScreenInShow()));
                          },
                          child: Column(
                            children: <Widget>[
                              AspectRatio(
                                aspectRatio: 2,
                                child: Image.asset(
                                  sectorData!.imagePath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: HotelAppTheme.buildLightTheme()
                                    .colorScheme
                                    .background,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, top: 8, bottom: 8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                sectorData!.titleTxt,
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22,
                                                ),
                                              ),
                                              // Row(
                                              //   crossAxisAlignment:
                                              //       CrossAxisAlignment.center,
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment.start,
                                              //   children: <Widget>[
                                              // Text(
                                              //   sectorData!.subTxt,
                                              //   style: TextStyle(
                                              //       fontSize: 14,
                                              //       color: Colors.grey
                                              //           .withOpacity(0.8)),
                                              // ),
                                              // const SizedBox(
                                              //   width: 4,
                                              // ),
                                              // Icon(
                                              //   FontAwesomeIcons
                                              //       .solidCircle,
                                              //   size: 12,
                                              //   color: sectorData!.rating ==
                                              //           1
                                              //       ? Colors.white
                                              //       : sectorData!.rating ==
                                              //               2
                                              //           ? Colors.yellow
                                              //           : sectorData!
                                              //                       .rating ==
                                              //                   3
                                              //               ? Colors.green
                                              //               : sectorData!
                                              //                           .rating ==
                                              //                       4
                                              //                   ? Colors
                                              //                       .blue
                                              //                   : sectorData!.rating ==
                                              //                           5
                                              //                       ? Colors
                                              //                           .red
                                              //                       : sectorData!.rating ==
                                              //                               6
                                              //                           ? Colors.purple
                                              //                           : Colors.grey,
                                              // ),
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 16, top: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: HotelAppTheme.buildLightTheme()
                                      .primaryColor,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
