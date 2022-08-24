import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinnamon/const.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/button_custom.dart';
import 'package:shinnamon/widgets/input_field.dart';
import 'package:shinnamon/widgets/loading_button.dart';
import 'package:shinnamon/widgets/pick_image_card.dart';
import 'package:async/async.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math' as Math;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

class AddPamitPage extends StatefulWidget {
  const AddPamitPage({Key? key}) : super(key: key);

  @override
  _AddPamitPageState createState() => _AddPamitPageState();
}

class _AddPamitPageState extends State<AddPamitPage> {
  bool isLoading = false;

  File? _image;

  final ImagePicker _picker = ImagePicker();

  cameraPicker() async {
    final imagePick = await _picker.pickImage(source: ImageSource.camera);

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
  String statusAbsen = "2";

  handlePamit() async {
    setState(() {
      isLoading = true;
    });
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var stream = http.ByteStream(DelegatingStream.typed(_image!.openRead()));
      var length = await _image!.length();
      var url = Uri.parse(AppUrl.absen);
      var request = http.MultipartRequest("POST", url);
      var multipartFile = http.MultipartFile("image", stream, length,
          filename: path.basename(_image!.path));
      request.fields['user_id'] = pref.getString("userId")!;
      request.fields['note'] = noteController.text;
      request.fields['status'] = statusAbsen;
      request.fields['project_code'] = AppCode.project;
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

  getNotif() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse(
      AppUrl.notifPamit +
          '?id=' +
          pref.getString('userId')! +
          '&notif_id=' +
          AppCode.notificationId +
          '&rest_api_key=' +
          AppCode.restApiKey,
    ));
  }

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        title: Text(
          'Pamit',
          style: primaryTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
        backgroundColor: kWhiteColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left,
            color: kPrimaryColor,
          ),
        ),
      );
    }

    Widget inputText() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
          left: hMargin,
          right: hMargin,
        ),
        child: InputField(
          lines: 3,
          controller: noteController,
          hintText: "Keterangan",
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
                text: 'Kirim',
                onPressed: () {
                  handlePamit();
                  getNotif();
                },
              ),
      );
    }

    return Scaffold(
      appBar: header(),
      body: ListView(
        children: [
          cardPickImage(),
          inputText(),
          button(),
        ],
      ),
    );
  }
}
