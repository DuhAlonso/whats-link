String urlOpenWhatsWithMsg({required String number, String message = ''}) {
  String numberFormated = number;
  numberFormated = numberFormated
      .replaceAll(' ', '')
      .replaceAll('-', '')
      .replaceAll('(', '')
      .replaceAll(')', '');
  final url = 'https://wa.me/55$numberFormated?text=$message';

  return url;
}
