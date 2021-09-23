import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_cropper_example/utils.dart';
import 'package:image_cropper_example/widget/image_list_widget.dart';

class TestPicker extends StatefulWidget {
  const TestPicker({Key key}) : super(key: key);

  @override
  State<TestPicker> createState() => _TestPickerState();
}

class _TestPickerState extends State<TestPicker> {
  List<File> imageFiles = [];
  @override
  Widget build(BuildContext context) {
    print('imageFiles.length = ${imageFiles.length}');
    return Column(
      children: [
        TextButton(onPressed: onClickedButton, child: Text('data')),
        Expanded(child: ImageListWidget(imageFiles: imageFiles)),
      ],
    );
  }

  Future onClickedButton() async {
    final file = await Utils.pickMedia(
      isGallery: true,
      cropImage: cropPredefinedImage,
    );

    if (file == null) return;
    setState(() => imageFiles.add(file));
  }

  Future<File> cropPredefinedImage(File imageFile) async =>
      await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          // CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          // CropAspectRatioPreset.ratio3x2,
          // CropAspectRatioPreset.ratio4x3,
        ],
        androidUiSettings: androidUiSettingsLocked(),
        iosUiSettings: iosUiSettingsLocked(),
      );

  IOSUiSettings iosUiSettingsLocked() => IOSUiSettings(
        aspectRatioLockEnabled: false,
        resetAspectRatioEnabled: false,
      );

  AndroidUiSettings androidUiSettingsLocked() => AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.red,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      );
}
