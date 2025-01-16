import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:game/app/module/game/pages/cards/cards_model.dart';
import 'package:game/data/storage/storage.dart';
import 'package:game/generated/assets_flame_images.dart';

class CardsView extends StatefulWidget {
  const CardsView({super.key, this.forMixture = false});
  final bool forMixture;
  @override
  State<CardsView> createState() => _CardsViewState();
}

class _CardsViewState extends State<CardsView> {
  var currentCategory = 0;

  String getCategoryLabel() {
    switch (currentCategory) {
      case 0:
        return 'ALL';
      case 1:
        return 'RELAXING';
      case 2:
        return 'ENERGISING';
      case 3:
        return 'DETOX';
      case 4:
        return 'WELLNESS';
      default:
        return 'ALL';
    }
  }

  List<Widget> cardsListWidgets() {
    if (currentCategory == 0) {
      return cardList.map((cardModel) {
        return InkWell(
          child: CardWidget(cardModel: cardModel),
          onTap: () {
            if (widget.forMixture) {
              Navigator.pop(context, cardModel);
              return;
            }
          },
        );
      }).toList();
    } else {
      return cardList
          .where((element) => element.category == currentCategory)
          .map((cardModel) {
        return InkWell(
            onTap: () {
              if (widget.forMixture) {
                Navigator.pop(context, cardModel);
                return;
              }
            },
            child: CardWidget(cardModel: cardModel));
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Text(
            getCategoryLabel().toUpperCase(),
            style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontFamily: 'Cuprum',
                fontWeight: FontWeight.w700),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tab(
                  currentCategory == 0
                      ? AssetsFlameImages.game_a_cup_of_tea_on_a_plate
                      : AssetsFlameImages.game_tea_cup_with_leaf_in_it,
                  0),
              tab(
                  currentCategory == 1
                      ? AssetsFlameImages.game_rose
                      : AssetsFlameImages.game_rose_illustration,
                  1),
              tab(
                  currentCategory == 2
                      ? AssetsFlameImages.game_lemon_slice_on_yellow_background
                      : AssetsFlameImages.game_lemon_slice,
                  2),
              tab(
                  currentCategory == 3
                      ? AssetsFlameImages.game_rainbow_leaf_1
                      : AssetsFlameImages.game_rainbow_leaf,
                  3),
              tab(
                  currentCategory == 4
                      ? AssetsFlameImages.game_pill
                      : AssetsFlameImages
                          .game_a_capsule_icon_with_a_vibrant_colorful_design_likely_used_to_represent_health_or_wellness_in_a_digital_interface,
                  4),
            ],
          ),
          Expanded(
            child: ListView(children: cardsListWidgets()),
          )
        ],
      ),
    ));
  }

  tab(String image, int id) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
          onTap: () {
            if (AppStorage.soundEnabled.val) {
              FlameAudio.play('swap_kategories.wav', volume: 0.7);
            }
            setState(() {
              currentCategory = id;
            });
          },
          child: Image.asset(
            image,
            height: 50,
          )),
    );
  }
}

class CardWidget extends StatefulWidget {
  const CardWidget({super.key, required this.cardModel});
  final CardModel cardModel;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  favoritesRating() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (index) {
          return InkWell(
            onTap: () {
              setState(() {
                if (index + 1 == widget.cardModel.stars) {
                  widget.cardModel.setStars(0);
                  return;
                }
                widget.cardModel.setStars(index + 1);
              });
            },
            child: Image.asset(
              index + 1 > widget.cardModel.stars
                  ? AssetsFlameImages.game_a_shiny_black_heart
                  : AssetsFlameImages.game_heart_icon,
              height: 80,
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            widget.cardModel.imagePath,
          ),
          favoritesRating()
        ],
      ),
    );
  }
}
