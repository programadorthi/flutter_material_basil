import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_material_basil/menu/backdrop.dart';
import 'package:flutter_material_basil/menu/navigation.dart';
import 'package:flutter_material_basil/recipes.dart';
import 'package:flutter_material_basil/shared/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basil',
      theme: ThemeData(
        accentColor: colorSecondaryDark,
        fontFamily: 'Montserrat',
        primaryColor: colorPrimary,
        primaryColorDark: colorPrimaryDark,
        primaryColorLight: colorPrimaryLight,
      ),
      home: AppPage(),
    );
  }
}

class AppPage extends StatelessWidget {

  Widget _buildBackdrop() {
    return Backdrop(
      backLayer: Navigation(),
      frontLayer: Column(
        children: <Widget>[
          _buildTitle(),
          Expanded(
            child: RecipesWidget(),
          ),
          Image.asset(
            'assets/images/chevron-down.png',
            color: colorPrimary,
            height: 50.0,
            width: 50.0,
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Transform(
      transform: Matrix4.translationValues(0.0, -2.0, 0.0),
      child: Center(
        child: Text(
          'BASiL',
          style: TextStyle(
            color: colorPrimaryDark,
            fontSize: 60.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets systemPadding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: colorSecondaryLight,
      body: Stack(
        children: <Widget>[
          _buildBackdrop(),
          Container(
            color: colorPrimaryLight,
            height: systemPadding.top,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
