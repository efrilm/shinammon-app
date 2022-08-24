import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shinnamon/models/lead_model.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/button_custom.dart';
import 'package:shinnamon/widgets/input_field.dart';
import 'package:http/http.dart' as http;
import 'package:shinnamon/widgets/loading_button.dart';

class EditLeadPage extends StatefulWidget {
  final Lead model;
  EditLeadPage(this.model);
  @override
  _EditLeadPageState createState() => _EditLeadPageState();
}

class _EditLeadPageState extends State<EditLeadPage> {
  var sourceSelection;
  var isLoading = false;

  List listSource = [
    'Facebook',
    'Instagram',
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController noWhatsappController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  setup() {
    nameController = TextEditingController(text: widget.model.fullName);
    addressController = TextEditingController(text: widget.model.address);
    noWhatsappController = TextEditingController(text: widget.model.noWhatsapp);
    noteController = TextEditingController(text: widget.model.note);
    sourceSelection = widget.model.source;
  }

  handleEdit() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.put(Uri.parse(AppUrl.editLead), body: {
      'full_name': nameController.text,
      'no_whatsapp': noWhatsappController.text,
      'address': addressController.text,
      'note': noteController.text,
      'source': sourceSelection,
      'id': widget.model.leadId,
    });
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      print(data);
      Navigator.pushNamedAndRemoveUntil(
          context, '/markom-main', (route) => false);
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
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Gagal!',
            style: whiteTextStyle,
          ),
          backgroundColor: Colors.red[600],
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
    }
  }

  @override
  void initState() {
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        backgroundColor: kWhiteColor,
        elevation: 1,
        title: Text(
          "Ubah Lead",
          style: primaryTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left, color: kPrimaryColor),
        ),
      );
    }

    Widget sourceDropdown() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: kGreyLightColor,
          borderRadius: BorderRadius.circular(dRadius),
        ),
        child: DropdownButtonFormField(
          hint: Text(
            "Ganti Sumber",
            style: greyTextStyle.copyWith(
              fontSize: 16,
            ),
          ),
          onSaved: (e) => sourceSelection,
          value: sourceSelection,
          style: blackTextStyle,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          items: listSource.map((value) {
            return DropdownMenuItem(
              child: Text(
                value,
                style: blackTextStyle,
              ),
              value: value,
            );
          }).toList(),
          onChanged: (newvalue) {
            setState(() {
              sourceSelection = newvalue;
            });
          },
        ),
      );
    }

    Widget button() {
      return isLoading
          ? LoadingButton()
          : CustomButton(
              text: "Ubah",
              onPressed: () {
                handleEdit();
              },
            );
    }

    return Scaffold(
      appBar: header(),
      body: ListView(
        padding: EdgeInsets.only(
          top: 30,
          left: hMargin,
          right: hMargin,
        ),
        children: [
          InputField(
            controller: nameController,
            hintText: "Nama Lengkap ",
          ),
          SizedBox(
            height: 15,
          ),
          InputField(
            controller: addressController,
            hintText: "Alamat",
          ),
          SizedBox(
            height: 15,
          ),
          InputField(
            controller: noWhatsappController,
            hintText: "No. Whatsapp",
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 15,
          ),
          sourceDropdown(),
          SizedBox(
            height: 15,
          ),
          InputField(
            controller: noteController,
            hintText: "Keterangan",
            lines: 3,
          ),
          SizedBox(
            height: 30,
          ),
          button(),
        ],
      ),
    );
  }
}
