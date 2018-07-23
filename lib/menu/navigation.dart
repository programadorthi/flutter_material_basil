import 'package:flutter/material.dart';
import 'package:flutter_material_basil/shared/colors.dart';

class Navigation extends StatelessWidget {
  Widget _buildMenuItem(String text) {
    return Text(text,
      style: TextStyle(
        color: colorPrimary,
        fontSize: 24.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
        _buildMenuItem('SHOPPING LIST'),
        SizedBox(
          height: 40.0,
        ),
        Container(
          color: Colors.black,
          height: 1.0,
          width: 120.0,
        ),
        SizedBox(
          height: 25.0,
        ),
        _buildMenuItem('APPETIZERS'),
        SizedBox(
          height: 40.0,
        ),
        _buildMenuItem('ENTRÉES'),
        SizedBox(
          height: 40.0,
        ),
        _buildMenuItem('DESSERTS'),
        SizedBox(
          height: 40.0,
        ),
        _buildMenuItem('COCKTAILS'),
      ],
    );
  }
}
