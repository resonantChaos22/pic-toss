import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' show get, Response;
import 'package:pics/src/models/image_model.dart';
import 'package:pics/src/widgets/action_button.dart';
import 'package:pics/src/widgets/image_list.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int counter = 0;
  List<ImageModel> imageModels = [];
  bool isFirstClick = false;

  void fetchImage() async {
    HapticFeedback.heavyImpact();
    setState(() {
      isFirstClick = true;
      counter++;
    });
    print(counter);

    Response response = await get(
        Uri.parse("https://jsonplaceholder.typicode.com/photos/$counter"));
    ImageModel imageModel = ImageModel.fromJson(json.decode(response.body));
    print(imageModel.url);
    setState(() {
      isFirstClick = false;
      imageModels.add(imageModel);
    });
  }

  void clear() {
    setState(() {
      imageModels = [];
    });
  }

  @override
  Widget build(context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.systemOrange,
      ),
      home: CupertinoPageScaffold(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                const CupertinoSliverNavigationBar(
                  largeTitle: Padding(
                    padding: EdgeInsets.only(bottom: 0),
                    child: Text("PicToss"),
                  ),
                  stretch: false,
                ),
                imageModels.isEmpty
                    ? SliverFillRemaining(
                        child: Center(
                            child: isFirstClick
                                ? const CupertinoActivityIndicator(
                                    radius: 20.0, color: CupertinoColors.white)
                                : const Text(
                                    "No Images Yet!",
                                    selectionColor: CupertinoColors.systemRed,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w800),
                                  )),
                      )
                    : ImageList(imageModels: imageModels)
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: ActionButton(
                  onPress: fetchImage,
                  onHold: clear,
                  icon: const Icon(
                    CupertinoIcons.antenna_radiowaves_left_right,
                    color: CupertinoColors.systemOrange,
                    size: 40,
                    weight: 20,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
