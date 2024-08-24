import 'package:be_weather/models.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

Future<Data> fetchData(String region) async {
  final url = constructForecastUrl(region);
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final xmlString = response.body;
    final xmlDocument = XmlDocument.parse(xmlString);
    final rootElement = xmlDocument.rootElement;
    return Data.fromXml(rootElement);
  } else {
    // Handle error
    throw Exception('Failed to fetch data for region: $region');
  }
}

String constructForecastUrl(String region) {
  const baseUrl =
      'https://data.bmkg.go.id/DataMKG/MEWS/DigitalForecast/DigitalForecast-';

  region = clearSpacesFromString(region);

  return '$baseUrl$region.xml';
}

String clearSpacesFromString(String stringText) {
  return stringText.replaceAll(' ', '');
}
