import 'dart:convert';
import 'dart:io';
import 'package:whats_link/src/core/token_api.dart';

import 'package:http/http.dart' as http;

import 'package:whats_link/src/repository/shortener_repository.dart';

class ShortenerRepositoryImpl implements ShortenerRepository {
  @override
  Future<String> generateShortener(String url) async {
    final body = jsonEncode(<String, String>{'long_url': url});
    try {
      var response = await http.post(
        Uri.parse('https://api-ssl.bitly.com/v4/shorten'),
        body: body,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $API_TOKEN'
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final url = data['link'];
        return url;
      }
    } on SocketException {
      throw 'No Internet connection';
    }
    return 'Erro';
  }
}
