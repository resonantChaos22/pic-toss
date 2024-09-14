import 'package:flutter/cupertino.dart';
import 'package:pics/src/models/image_model.dart';

class ImageList extends StatelessWidget {
  final List<ImageModel> imageModels;

  ImageList({required this.imageModels});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: imageModels.length,
      itemBuilder: (context, index) {
        final imageModel = imageModels[index];
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageModel.url,
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                imageModel.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: CupertinoColors.white,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 1,
                color: CupertinoColors.systemGrey.withOpacity(0.5),
              ),
            ],
          ),
        );
      },
    );
  }
}