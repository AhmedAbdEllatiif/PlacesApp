import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guide_app/providers/places_provider.dart';
import 'package:guide_app/widgets/choose_image_button.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/add-place";

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
   File _pickedImage;
  final _titleController = TextEditingController();

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      if (_titleController.text.isEmpty) {
        print('AddPlaceScreen: _savePlace ==> PlaceTitle is empty');
      }
      if (_pickedImage == null) {
        print('AddPlaceScreen: _savePlace ==> _pickedImage is null');
      }
      return;
    }
    String pickedTitle = _titleController.text;
    Provider.of<PlacesProvider>(context, listen: false).addPlace(
      pickedTitle,
      _pickedImage,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Place'),
      ),

      ///body
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ///Expanded to make column take as much as required space
          ///User inputs fields
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ///Title text field
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Title'),
                    ),

                    SizedBox(
                      height: 10.0,
                    ),

                    ChooseImageButton(
                      onSelectImage: (pickedImage) {
                        _selectImage(pickedImage);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          ///Add Button
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text("Add Place"),
            elevation: 0.0,

            ///To avoid the margin around the button
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
            onPressed: _savePlace,
          ),
        ],
      ),
    );
  }
}
