import 'package:chama/src/core/functions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:chama/src/repository/shortener_repository_impl.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController {
  final _respository = ShortenerRepositoryImpl();

  final _urlShortener = RxString('');
  final _urlOpenWhats = RxString('');
  final _generateLink = RxBool(false);
  final _isLoading = RxBool(false);

  String get urlShortener => _urlShortener.value;
  String get urlOpenWhats => _urlOpenWhats.value;
  bool get generateLink => _generateLink.value;
  bool get isLoading => _isLoading.value;

  Future<String> _getShortener(String url) async {
    _isLoading.value = true;
    return await _respository.generateShortener(url);
  }

  void openWhatsApp({required String number, String message = ''}) async {
    _urlOpenWhats.value = urlOpenWhatsWithMsg(number: number, message: message);

    await launchUrl(Uri.parse(_urlOpenWhats.value),
        mode: LaunchMode.externalApplication);
  }

  void generateLinkBitly({required String number, String message = ''}) async {
    final urlWhats = urlOpenWhatsWithMsg(number: number, message: message);
    _urlShortener.value = await _getShortener(urlWhats);
    _isLoading.value = false;
    Clipboard.setData(ClipboardData(text: _urlShortener.value));
    _generateLink.value = true;
  }
}
