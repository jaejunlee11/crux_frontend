import 'package:flutter/material.dart';

class questionsListData {
  questionsListData({
    this.imagePath = '',
    this.name = '',
    this.startColor = '',
    this.endColor = '',
    this.kacl = 0,
  });

  String imagePath;
  String startColor;
  String endColor;
  String name;
  int kacl;

  static List<questionsListData> tabIconsList = <questionsListData>[
    questionsListData(
      imagePath: 'assets/fitness_app/test0224.jpeg',
      kacl: 1,
      name: 'W',
      startColor: '#ffffff',
      endColor: '#006600',
    ),
    questionsListData(
      imagePath: 'assets/fitness_app/test0226.jpeg',
      kacl: 2,
      name: 'B',
      startColor: '#000000',
      endColor: '#006600',
    ),
    questionsListData(
      imagePath: 'assets/fitness_app/test0226.jpeg',
      kacl: 3,
      name: 'G',
      startColor: '#bcbcbc',
      endColor: '#006600',
    ),
    questionsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      kacl: 4,
      name: 'R',
      startColor: '#f44336',
      endColor: '#006600',
    ),
    questionsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      kacl: 5,
      name: 'P',
      startColor: '#f4cccc',
      endColor: '#006600',
    ),
    questionsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      kacl: 6,
      name: 'O',
      startColor: '#f9cb9c',
      endColor: '#006600',
    ),
    questionsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      kacl: 7,
      name: 'Y',
      startColor: '#ffe599',
      endColor: '#006600',
    ),
    questionsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      kacl: 8,
      name: 'G',
      startColor: '#38761d',
      endColor: '#006600',
    ),
    questionsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      kacl: 9,
      name: 'LG',
      startColor: '#33CC33',
      endColor: '#006600',
    ),
    questionsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      kacl: 10,
      name: 'SB',
      startColor: '#9fc5e8',
      endColor: '#006600',
    ),
    questionsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      kacl: 11,
      name: 'B',
      startColor: '#3d85c6',
      endColor: '#006600',
    ),
    questionsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      kacl: 12,
      name: 'BB',
      startColor: '#0b5394',
      endColor: '#006600',
    ),
    questionsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      kacl: 13,
      name: 'P',
      startColor: '#a64d79',
      endColor: '#006600',
    ),
  ];
}
