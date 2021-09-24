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
  bool isGallery = true;
  List<File> imageFiles = [];
  @override
  Widget build(BuildContext context) {
    //print('imageFiles.length = ${imageFiles.length}');
    return Column(
      children: [
        Row(
          children: [
            TextButton(onPressed: onClickedButton, child: Text('Выбрать')),
          ],
        ),
        ImageListWidget(imageFiles: imageFiles),
      ],
    );
  }

  Future onClickedButton() async {
    showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Выбирите источник изображения'),
        //content: Text('Do you really want to exit'),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          cropImage(context, isGallery),
          cropImage(context, !isGallery),
        ],
      ),
    );
    // final file = await Utils.pickMedia(
    //   isGallery: isGallery,
    //   cropImage: cropPredefinedImage,
    // );

    // if (file == null) return;
    // setState(() => imageFiles.add(file));
  }

  OutlinedButton cropImage(BuildContext context, bool isGalery) {
    return OutlinedButton(
      child: Text(isGalery ? 'Галерея' : 'Камера'),
      onPressed: () async {
        Navigator.pop(context, true);
        final file = await Utils.pickMedia(
          isGallery: isGalery,
          cropImage: cropPredefinedImage,
        );

        if (file == null) return;
        setState(() => imageFiles.add(file));
      },
    );
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
