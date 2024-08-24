import 'package:be_weather/components/dropdown.dart';
import 'package:be_weather/constant.dart';
import 'package:be_weather/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Layout extends StatelessWidget {
  const Layout({
    super.key,
    this.data,
    required this.regionName,
  });

  final Data? data;
  final String regionName;

  @override
  Widget build(BuildContext context) {
    final firstAreaData = data?.forecast?.areas?[1] ?? Area();
    final parameters = firstAreaData.parameters ?? [];
    final temperatureTimeranges =
        getTemperatureParameter(parameters).timeranges ?? [];
    final latestTemperatureData =
        temperatureTimeranges[temperatureTimeranges.length - 1];
    final weatherTimeranges = getWeatherParameter(parameters).timeranges ?? [];
    final latestWeatherData = weatherTimeranges[weatherTimeranges.length - 1];
    final timeConditions =
        getTimeConditions(temperatureTimeranges, weatherTimeranges);

    return Container(
      clipBehavior: Clip.none,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 30),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.deepPurple, Colors.blue])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RegionOptions(regionName: regionName),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  firstAreaData.names?[1].value ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 100),
                child: Text(
                  '${latestTemperatureData.value?[0].value}°',
                  style: const TextStyle(
                    fontSize: 110,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
              Text(formatDateTo(
                  'EEEE, dd MMMM HH.mm', latestTemperatureData.datetime ?? '')),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  weatherMap[latestWeatherData.value?[0].value]!,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'Hari ini',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  width: double.infinity,
                  height: 180,
                  margin: const EdgeInsets.only(bottom: 30),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                    itemCount: timeConditions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.white,
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                timeConditions[index].time ?? '',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                timeConditions[index].weather ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              Text(
                                '${timeConditions[index].value} °C',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<TimeCondition> getTimeConditions(
    List<TimeRange> temperatureTimeranges, List<TimeRange> weatherTimeranges) {
  var conditionList = [TimeCondition()];
  conditionList.removeLast();
  for (var i = temperatureTimeranges.length - 1;
      i > temperatureTimeranges.length - 5;
      i--) {
    conditionList.insert(
        0,
        TimeCondition(
          time: formatDateTo('HH.mm', temperatureTimeranges[i].datetime!),
          weather: weatherMap[weatherTimeranges[i].value?[0].value],
          value: temperatureTimeranges[i].value?[0].value,
          unit: temperatureTimeranges[i].value?[0].unit,
        ));
  }
  return conditionList;
}

Parameter getTemperatureParameter(List<Parameter> parameters) {
  for (Parameter parameter in parameters) {
    if (parameter.id == 't') return parameter;
  }
  return Parameter();
}

Parameter getWeatherParameter(List<Parameter> parameters) {
  for (Parameter parameter in parameters) {
    if (parameter.id == 'weather') return parameter;
  }
  return Parameter();
}

String formatDateTo(String format, String inputDate) {
  final year = inputDate.substring(0, 4);
  final month = inputDate.substring(4, 6);
  final day = inputDate.substring(6, 8);
  final hour = inputDate.substring(8, 10);
  final minute = inputDate.substring(10, 12);
  final newDateTime = '$year-$month-$day $hour:$minute:00';
  final dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(newDateTime);
  final formattedDate = DateFormat(format).format(dateTime);
  return formattedDate;
}
