import 'dart:io';

import'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mandate_storeapp/components/text_field_container.dart';
import 'package:mandate_storeapp/constants.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _image;
  final picker = ImagePicker();
  final controllerPhone = TextEditingController();
  final controllerAddress = TextEditingController();

  Future choiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Upload Profile"),
        ),
        body:Column(
          children: [
            TextFieldContainer(
              child: TextField(
                obscureText: false,
                keyboardType: TextInputType.number,
                cursorColor: kPrimaryColor,
                controller:controllerPhone ,
                decoration: InputDecoration(
                  hintText: "Phone Number",
                  icon: Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                  // suffixIcon: Icon(
                  //   Icons.visibility,
                  //   color: kPrimaryColor,
                  // ),
                  border: InputBorder.none,
                ),
              ),
            ),

            TextFieldContainer(
              child: TextField(
                obscureText: false,
                cursorColor: kPrimaryColor,
                controller:controllerAddress ,
                decoration: InputDecoration(
                  hintText: "Address",
                  icon: Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                  // suffixIcon: Icon(
                  //   Icons.visibility,
                  //   color: kPrimaryColor,
                  // ),
                  border: InputBorder.none,
                ),
              ),
            ),


            SizedBox(height: 10.0),
            Text("Means of Identification"),
            SizedBox(height: 5.0),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () {
                choiceImage();
              },
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 15.0, bottom: 15.0, right: 40.0, left: 40.0),
              child: _image == null
                  ? Center(child: Text('No Image Selected'))
                  : Image.file(_image),
            ),

            SizedBox(height: 10.0),
            Text("Passport "),
            SizedBox(height: 5.0),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () {
                choiceImage();
              },
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 15.0, bottom: 15.0, right: 40.0, left: 40.0),
              child: _image == null
                  ? Center(child: Text('No Image Selected'))
                  : Image.file(_image),
            ),

          ],
        ),
      ),
    );
  }
}
