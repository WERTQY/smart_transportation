import 'package:http/http.dart' as http;

Future<http.Response> getLocationData(String searchText) async {
  const String apiKey = "AIzaSyDBAcLioy662ttpidi6m1b5h04_m1IaGLw"; // Replace with your key
  final String url =
      "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchText&key=$apiKey&components=country:my&types=establishment";
    final response = await http.get(Uri.parse(url));
    return response;
}