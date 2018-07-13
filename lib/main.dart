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
      home: AppPage(),
    );
  }
}

class AppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EdgeInsets systemPadding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: colorSecondaryLight,
      body: Stack(
        children: <Widget>[
          Backdrop(
            backLayer: Menu(),
            frontLayer: Column(
              children: <Widget>[
                Transform(
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
                ),
                Expanded(
                  child: Image.asset('assets/images/cream_presto_pasta.jpg'),
                ),
              ],
            ),
          ),
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

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: colorPrimaryLight,
                  width: 3.0,
                ),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.bookmark_border,
                color: colorPrimaryDark,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              'SHOPPING LIST',
              style: TextStyle(
                color: colorPrimary,
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: colorPrimaryLight,
                  width: 3.0,
                ),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
