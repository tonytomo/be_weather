import 'package:xml/xml.dart';

class Data {
  String? source;
  String? productionCenter;

  // String? forecast;
  Forecast? forecast;

  Data({this.source, this.productionCenter, this.forecast});

  factory Data.fromXml(XmlElement element) {
    return Data(
      source: element.getAttribute('source'),
      productionCenter: element.getAttribute('productionCenter'),
      // forecast: element.findElements('forecast').first.toString(),
      forecast: Forecast.fromXml(element.findElements('forecast').first),
    );
  }
}

class Forecast {
  Issue? issue;
  List<Area>? areas;

  Forecast({this.issue, this.areas});

  factory Forecast.fromXml(XmlElement element) {
    return Forecast(
      issue: Issue.fromXml(element.findElements('issue').first),
      areas: element
          .findElements('area')
          .map((child) => Area.fromXml(child))
          .toList(),
    );
  }
}

class Issue {
  String? timestamp;
  int? year;
  int? month;
  int? day;
  int? hour;
  int? minute;
  int? second;

  Issue({
    this.timestamp,
    this.year,
    this.month,
    this.day,
    this.hour,
    this.minute,
    this.second,
  });

  factory Issue.fromXml(XmlElement element) {
    return Issue(
      timestamp: element.findElements('timestamp').first.innerText,
      year: int.parse(element.findElements('year').first.innerText),
      month: int.parse(element.findElements('month').first.innerText),
      day: int.parse(element.findElements('day').first.innerText),
      hour: int.parse(element.findElements('hour').first.innerText),
      minute: int.parse(element.findElements('minute').first.innerText),
      second: int.parse(element.findElements('second').first.innerText),
    );
  }
}

class Area {
  String? id;
  double? latitude;
  double? longitude;
  String? coordinate;
  String? type;
  String? region;
  int? level;
  String? description;
  String? domain;
  String? tags;
  List<Name>? names;
  List<Parameter>? parameters;

  Area({
    this.id,
    this.latitude,
    this.longitude,
    this.coordinate,
    this.type,
    this.region,
    this.level,
    this.description,
    this.domain,
    this.tags,
    this.names,
    this.parameters,
  });

  factory Area.fromXml(XmlElement element) {
    return Area(
      id: element.getAttribute('id'),
      latitude: double.parse(element.getAttribute('latitude')!),
      longitude: double.parse(element.getAttribute('longitude')!),
      coordinate: element.getAttribute('coordinate'),
      type: element.getAttribute('type'),
      region: element.getAttribute('region'),
      level: int.parse(element.getAttribute('level')!),
      description: element.getAttribute('description'),
      domain: element.getAttribute('domain'),
      tags: element.getAttribute('tags'),
      names: element
          .findElements('name')
          .map((child) => Name.fromXml(child))
          .toList(),
      parameters: element
          .findElements('parameter')
          .map((parameterElement) => Parameter.fromXml(parameterElement))
          .toList(),
    );
  }
}

class Name {
  String? xmlLang;
  String? value;

  Name({this.xmlLang, this.value});

  factory Name.fromXml(XmlElement element) {
    return Name(
      xmlLang: element.getAttribute('xml:lang'),
      value: element.innerText,
    );
  }
}

class Parameter {
  String? id;
  String? description;
  String? type;

  // TimeRange? timeranges;

  List<TimeRange>? timeranges;

  Parameter({this.id, this.description, this.type, this.timeranges});

  factory Parameter.fromXml(XmlElement element) {
    return Parameter(
      id: element.getAttribute('id'),
      description: element.getAttribute('description'),
      type: element.getAttribute('type'),
      // timeranges: TimeRange.fromXml(element.findElements('timerange').first),
      timeranges: element
          .findElements('timerange')
          .map((timeRangeElement) => TimeRange.fromXml(timeRangeElement))
          .toList(),
    );
  }
}

class TimeRange {
  String? type;
  int? h;
  String? day;
  String? datetime;
  List<Value>? value;

  TimeRange({this.type, this.h, this.day, this.datetime, this.value});

  factory TimeRange.fromXml(XmlElement element) {
    return TimeRange(
      type: element.getAttribute('type'),
      h: int.parse(element.getAttribute('h') ?? "0"),
      day: element.getAttribute('day') ?? "",
      datetime: element.getAttribute('datetime'),
      value: element
          .findElements('value')
          .map((child) => Value.fromXml(child))
          .toList(),
    );
  }
}

class Value {
  String? unit;
  String? value;

  Value({this.unit, this.value});

  factory Value.fromXml(XmlElement element) {
    return Value(
      unit: element.getAttribute('unit'),
      value: element.innerText,
    );
  }
}

class TimeCondition {
  String? time;
  String? weather;
  String? value;
  String? unit;

  TimeCondition({this.time, this.weather, this.value, this.unit});
}