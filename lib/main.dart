import 'package:flutter/material.dart';
import 'package:flutter_material_basil/menu/backdrop.dart';
import 'colors.dart';

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
      //home: AppPage(title: 'BASiL'),
      home: Backdrop(
        backLayer: Container(
          color: colorSecondaryLight,
        ),
        frontLayer: AppPage(),
      ),
    );
  }
}

class AppPage extends StatelessWidget {
  final String title = 'BASiL';

  Widget _buildTopLogo(EdgeInsets systemPadding) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(0.0, -5.0, 0.0),
          child: Text(
            this.title,
            style: TextStyle(
              color: colorPrimaryDark,
              fontSize: 60.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          color: colorPrimaryLight,
          height: systemPadding.top,
          width: double.infinity,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets systemPadding = MediaQuery.of(context).padding;
    return Scaffold(
      body: Column(
        children: <Widget>[
          _buildTopLogo(systemPadding),
          Expanded(
            child: Image.asset('assets/images/cream_presto_pasta.jpg'),
          ),
        ],
      )
    );
  }
}