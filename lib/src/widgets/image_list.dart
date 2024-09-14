import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pics/src/models/image_model.dart';

class ImageList extends StatelessWidget {
  final List<ImageModel> imageModels;

  ImageList({required this.imageModels});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final imageModel = imageModels[index];
          return Padding(
            padding: EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.transparent,
              elevation: 4,
              shadowColor: CupertinoColors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          height: 300,
                          width: double.infinity,
                          color: CupertinoColors.systemGrey,
                          child: const Center(
                            child: CupertinoActivityIndicator(
                                radius: 20.0, color: CupertinoColors.white),
                          ),
                        ),
                        Image.network(
                          imageModel.url,
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // Fallback image when network image fails
                            return Image.asset(
                              'assets/images/dummy_image.jpg', // Add your local placeholder image here
                              height: 300,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Container(
                                height: 300,
                                width: double.infinity,
                                color: CupertinoColors.systemGrey,
                                child: const Center(
                                  child: CupertinoActivityIndicator(
                                      radius: 20.0, color: CupertinoColors.white),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    )
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    child: Container(
                      color: CupertinoColors.secondaryLabel,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          imageModel.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        childCount: imageModels.length, // Number of items in the list
      ),
    );
  }
}
