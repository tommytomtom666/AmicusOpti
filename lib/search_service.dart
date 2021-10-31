import 'package:http/http.dart' as http;

class SearchService {
  static Future<String> searchDjangoApi(String query) async {
    String url =
        'http://127.0.0.1:8000/amicusOptiApp/searchActivity?search=$query';
    http.Response response = await http.get(Uri.parse(url));

    print("search_service.dart: searchDjangoApi: ${response.body}");

    return response.body;
  }
}
