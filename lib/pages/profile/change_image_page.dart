import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/button_custom.dart';
import 'package:shinnamon/widgets/loading_button.dart';
import 'package:shinnamon/widgets/pick_image_card.dart';
import 'package:async/async.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math' as Math;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

class ChangeImagePage extends StatefulWidget {
  const ChangeImagePage({Key? key}) : super(key: key);

  @override
  _ChangeImagePageState createState() => _ChangeImagePageState();
}

class _ChangeImagePageState extends State<ChangeImagePage> {
  bool isLoading = false;

  File? _image;

  final ImagePicker _picker = ImagePicker();

  cameraPicker() async {
    final imagePick = await _picker.pickImage(source: ImageSource.gallery);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    int rand = new Math.Random().nextInt(10000000);

    img.Image image = img.decodeImage(File(imagePick!.path).readAsBytesSync())!;
    img.Image smalleImg = img.copyResize(image, width: 720);

    var compressImg = new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(img.encodeJpg(smalleImg, quality: 85));

    setState(() {
      _image = compressImg;
    });
  }

  TextEditingController noteController = TextEditingController();
  String statusAbsen = "1";

  handleChangeImage() async {
    setState(() {
      isLoading = true;
    });
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var stream = http.ByteStream(DelegatingStream.typed(_image!.openRead()));
      var length = await _image!.length();
      var url = Uri.parse(AppUrl.editPhoto);
      var request = http.MultipartRequest("POST", url);
      var multipartFile = http.MultipartFile("image", stream, length,
          filename: path.basename(_image!.path));
      request.fields['id'] = pref.getString("userId")!;
      request.files.add(multipartFile);
      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {
        final data = jsonDecode(value);
        int getValue = data['value'];
        String message = data['message'];
        if (getValue == 1) {
          print(message);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Berhasil!',
                style: whiteTextStyle,
              ),
              backgroundColor: Colors.green[600],
              duration: const Duration(milliseconds: 1500),
              width: 200.0, // Width of the SnackBar.
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0, // Inner padding for SnackBar content.
              ),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          );
        } else {
          print(message);
        }
      });
      setState(() {
        isLoading = false;
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        title: Text(
          'Ganti Image',
          style: primaryTextStyle.copyWith(fontSize: 16),
        ),
        backgroundColor: kWhiteColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: kPrimaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      );
    }

    Widget cardPickImage() {
      return GestureDetector(
        onTap: () {
          cameraPicker();
        },
        child: _image == null
            ? PickImageCard(
                onTap: () {
                  cameraPicker();
                },
              )
            : Container(
                child: Image.file(
                  File(_image!.path),
                  width: 300,
                ),
              ),
      );
    }

    Widget button() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
          left: hMargin,
          right: hMargin,
        ),
        child: isLoading
            ? LoadingButton()
            : CustomButton(
                onPressed: () {
                  handleChangeImage();
                },
                text: "Ganti",
              ),
      );
    }

    return Scaffold(
      appBar: header(),
      body: ListView(
        children: [
          cardPickImage(),
          button(),
        ],
      ),
    );
  }
}
