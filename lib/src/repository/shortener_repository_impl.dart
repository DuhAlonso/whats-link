import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:whats_link/src/repository/shortener_repository.dart';

class ShortenerRepositoryImpl implements ShortenerRepository {
  @override
  Future<String> generateShortener(String url) async {
    final body = jsonEncode(<String, String>{'url': url});
    try {
      var response = await http.post(
        Uri.parse('https://api.encurtador.dev/encurtamentos'),
        body: body,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final url = data['urlEncurtada'];
        return url;
      }
    } on SocketException {
      throw 'No Internet connection';
    }
    return 'Erro';
  }
}
