import 'package:flutter/material.dart';
import 'package:flutter_material_basil/shared/colors.dart';
import 'package:flutter_material_basil/shared/page_transformer.dart';

final recipes = <RecipeItem>[
  RecipeItem(
    imageAsset: 'assets/images/herb_roasted_chicken.jpeg',
    title: 'Herb Roasted Chicken',
  ),
  RecipeItem(
    imageAsset: 'assets/images/cream_presto_pasta.jpg',
    title: 'Cream Presto Pasta',
  ),
  RecipeItem(
    imageAsset: 'assets/images/beef_pot_pie.jpg',
    title: 'Pot Pie',
  ),
];

class RecipeItem {
  final String imageAsset;
  final String title;

  RecipeItem({
    this.imageAsset,
    this.title,
  });
}

class RecipesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageTransformer(
      pageViewBuilder: (context, visibilityResolver) {
        return PageView.builder(
          controller: PageController(),
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            final recipe = recipes[index];
            final pageVisibility =
                visibilityResolver.resolvePageVisibility(index);
            return RecipeView(
              item: recipe,
              pageVisibility: pageVisibility,
            );
          },
        );
      },
    );
  }
}

class RecipeView extends StatelessWidget {
  final RecipeItem item;
  final PageVisibility pageVisibility;

  const RecipeView({this.item, this.pageVisibility});

  Widget _applyTextEffects({
    @required double translationFactor,
    @required Widget child,
  }) {
    final double xTranslation = pageVisibility.pagePosition * translationFactor;

    return Opacity(
      opacity: pageVisibility.visibleFraction,
      child: Transform(
        alignment: FractionalOffset.topLeft,
        transform: Matrix4.translationValues(
          xTranslation,
          0.0,
          0.0,
        ),
        child: child,
      ),
    );
  }

  Widget _buildContainer(BuildContext context, BoxConstraints constraints) {
    var titleText = _applyTextEffects(
      translationFactor: 200.0,
      child: Text(
        item.title,
        style: TextStyle(
          color: colorSecondaryDark,
          fontSize: 100.0,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );

    var image = Image.asset(
      item.imageAsset,
      fit: BoxFit.cover,
    );

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 60.0,
          ),
          child: image,
        ),
        Positioned(
          bottom: 56.0,
          left: 0.0,
          right: 0.0,
          child: titleText,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: _buildContainer);
  }
}
