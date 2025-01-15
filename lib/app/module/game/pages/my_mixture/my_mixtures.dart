import 'package:flutter/material.dart';

import '../../../../../data/storage/storage.dart';
import '../../../../../generated/assets_flame_images.dart';
import '../../widgets/back_button/back_button.dart';
import 'create_new.dart';
import 'my_mixtures_model.dart';

class MyMixturesView extends StatefulWidget {
  const MyMixturesView({super.key});

  @override
  State<MyMixturesView> createState() => _MyMixturesViewState();
}

class _MyMixturesViewState extends State<MyMixturesView> {
  var myMixtures = <MyMixturesModel>[];

  @override
  void initState() {
    var list = AppStorage.myMixtures.val;
    myMixtures = (list).map((e) => MyMixturesModel.fromStorage(e)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(fit: StackFit.expand, children: [
      Image.asset(
        AssetsFlameImages.bg_my_mixtures_books_and_teapot,
        fit: BoxFit.cover,
      ),
      const BaseBackButton(),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 180),
            Visibility(
              visible: myMixtures.isNotEmpty,
              child: Flexible(
                child: ListView.builder(
                    itemCount: myMixtures.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Image.asset(AssetsFlameImages.game_water_pitcher_on_book),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  myMixtures[index].name,
                                  maxLines: 3,
                                  style:
                                      const TextStyle(fontSize: 20, fontFamily: 'Cuprum', fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                  onTap: () async {
                    var result = await Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const MyMixturesCreateNew()));
                    if (result != null) {
                      setState(() {
                        myMixtures.add(result);
                      });
                    }
                  },
                  child: Image.asset(
                    AssetsFlameImages.game_pill_new_button,
                  )),
            ),
          ],
        ),
      )
    ])));
  }
}
