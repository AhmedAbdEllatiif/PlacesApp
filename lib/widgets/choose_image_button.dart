import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import 'package:path_provider/path_provider.dart' as providerPath;

class ChooseImageButton extends StatefulWidget {

  final Function(File) onSelectImage;



  ChooseImageButton({this.onSelectImage});

  @override
  _ChooseImageButtonState createState() => _ChooseImageButtonState();
}

class _ChooseImageButtonState extends State<ChooseImageButton> {
  File _storedImageFile;

  Future<void> _takePicture(ImageSource imageSource) async {
    // 1. Create an ImagePicker instance.
    final imagePicker = ImagePicker();

    // 2. Use the new method.
    //
    // getImage now returns a PickedFile instead of a File (form dart:io)
    final pickedImage = await imagePicker.getImage(
      source: imageSource,
      maxWidth: 600,
    );

    // 3. Check if an image has been picked or take with the camera.
    if (pickedImage == null) {
      print('ChooseImageButton: ==> _takePicture ==> _storedImageFile is null');
      return;
    }

    // 4. Create a File from PickedFile so you can save the file locally
    // This is a new/additional step.
    File tmpFile  = File(pickedImage.path);

    // 5. Get the path to the apps directory so we can save the file to it.
    final appDir = await providerPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(pickedImage.path);
    //final String fileExtension = extension(pickedFile.path); // e.g. '.jpg'

    // 6. Save the file by copying it to the new location on the device.
    tmpFile = await tmpFile.copy('${appDir.path}/$fileName');
    widget.onSelectImage(tmpFile);
    // 7. Optionally, if you want to display the taken picture we need to update the state
    // Note: Copying and awaiting the file needs to be done outside the setState function.
    setState(() {
      _storedImageFile = tmpFile;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        ///ImageContainer
        Container(
          alignment: Alignment.center,
          width: 150.0,
          height: 100.0,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImageFile != null
              ? Image.file(
            _storedImageFile,
            fit: BoxFit.cover,
            width: double.infinity,
          )
              : Text(
            'No Image Chosen',
            textAlign: TextAlign.center,
          ),
        ),

        SizedBox(width: 10.0),

        ///Choose image button
        Center(
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                ///Capture image
                FlatButton.icon(
                  icon: Icon(Icons.camera),
                  textColor: Theme
                      .of(context)
                      .primaryColor,
                  label: Text('Take Picture'),
                  onPressed: () {
                    _takePicture(ImageSource.camera);
                  },
                ),

                ///Choose form gallery
                FlatButton.icon(
                  icon: Icon(Icons.image),
                  textColor: Theme
                      .of(context)
                      .primaryColor,
                  label: Text('Choose from gallery'),
                  onPressed: () {
                    _takePicture(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
