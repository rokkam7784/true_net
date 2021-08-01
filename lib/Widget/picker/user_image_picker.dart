import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:true_net/Constants/Colors.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);

  final void Function(File pickedImage) imagePickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
  //TODO Try to put ? before _pickedImage instead of late this makes that particular variable nullable and then run the code u might get the result

  void _pickImage() async {
    final pickedImageFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _pickedImage = File(pickedImageFile!.path);
    });
    widget.imagePickFn(File(pickedImageFile!.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // GestureDetector(
        //   onTap: _pickImage,
        //   child: CircleAvatar(
        //     radius: 43,
        //     backgroundColor: Kclr22,
        //     backgroundImage: _pickedImage != null
        //         ? FileImage(_pickedImage)
        //         : AssetImage(
        //             'images/DefaultUserLogo.png',
        //           ) as ImageProvider,
        //     // child: ,
        //   ),
        // ),
        CircleAvatar(
          radius: 43,
          backgroundColor: Kclr22,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
          // : AssetImage(
          //     'images/imageLogo.png',
          //   ) as ImageProvider,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_pickedImage == null)
                IconButton(
                  icon: Icon(
                    Icons.image_rounded,
                    size: 50,
                    color: Kclr21,
                  ),
                  onPressed: _pickImage,
                  padding: EdgeInsets.all(0),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
