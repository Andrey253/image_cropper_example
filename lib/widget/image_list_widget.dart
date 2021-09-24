import 'dart:io';

import 'package:flutter/material.dart';

class ImageListWidget extends StatelessWidget {
  final List<File> imageFiles;

  const ImageListWidget({
    Key key,
    @required this.imageFiles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: imageFiles.isNotEmpty
                ? Image.file(imageFiles.last)
                : CircularProgressIndicator())
      ]);
}
