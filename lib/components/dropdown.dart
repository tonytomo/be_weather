import 'package:be_weather/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegionOptions extends StatelessWidget {
  const RegionOptions({
    super.key,
    required this.regionName,
  });

  final String regionName;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      icon: const Padding(
        padding: EdgeInsets.only(top: 20),
        child: Icon(Icons.arrow_drop_down_rounded),
      ),
      iconEnabledColor: Colors.white,
      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
      dropdownColor: Colors.black54,
      isExpanded: true,
      underline: Container(),
      value: regionName,
      items: regionList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(value),
          )),
        );
      }).toList(),
      onChanged: (String? value) {
        // Get.toNamed('/1');
        Get.toNamed('/${regionList.indexOf(value ?? '0')}');
      },
    );
  }
}
