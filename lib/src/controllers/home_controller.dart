import 'package:chama/src/core/functions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:chama/src/repository/shortener_repository_impl.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController {
  final _respository = ShortenerRepositoryImpl();

  final urlShortener = RxString('');
  final urlOpenWhats = RxString('');
  final generateLink = RxBool(false);
  final isLoading = RxBool(false);

  Future<String> _getShortener(String url) async {
    isLoading.value = true;
    isLoading.refresh();
    return await _respository.generateShortener(url);
  }

  void openWhatsApp({required String number, String message = ''}) async {
    urlOpenWhats.value = urlOpenWhatsWithMsg(number: number, message: message);

    await launchUrl(Uri.parse(urlOpenWhats.value),
        mode: LaunchMode.externalApplication);
  }

  void generateLinkBitly({required String number, String message = ''}) async {
    final urlWhats = urlOpenWhatsWithMsg(number: number, message: message);
    urlShortener.value = await _getShortener(urlWhats);
    isLoading.value = false;
    Clipboard.setData(ClipboardData(text: urlShortener.value));
    generateLink.value = true;
    generateLink.refresh();
    urlShortener.refresh();
    isLoading.refresh();
  }
}
