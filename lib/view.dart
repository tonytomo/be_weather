import 'package:be_weather/components/layout.dart';
import 'package:be_weather/constant.dart';
import 'package:be_weather/controller.dart';
import 'package:be_weather/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewPage extends StatelessWidget {
  const ViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Data>(
        future:
            fetchData(regionList[int.parse(Get.parameters['region'] ?? '0')]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Layout(
              data: snapshot.data,
              regionName:
                  regionList[int.parse(Get.parameters['region'] ?? '0')],
            );
          } else if (snapshot.hasError) {
            return Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.deepPurple, Colors.blue])),
                child: Center(
                    child: Text(
                  '${snapshot.error}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                )));
          }
          return Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.deepPurple, Colors.blue])),
              child: const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              )));
        },
      ),
    );
  }
}
