import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:validatorless/validatorless.dart';
import 'package:whats_link/src/pages/chama_no_whats/chama_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

enum ScreenSize { small, normal, large, extraLarge }

class _HomePageState extends State<HomePage> {
  final _controller = ChamaController();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _numberEC = TextEditingController();
  final TextEditingController _messageEC = TextEditingController();
  final String msg = 'Insira';
  final numberFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  ScreenSize getSize(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.shortestSide;
    if (deviceWidth > 600) return ScreenSize.large;
    if (deviceWidth > 300) return ScreenSize.normal;
    return ScreenSize.small;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal:
                    getSize(context) == ScreenSize.large ? size.width / 3 : 15,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                    //maxHeight: MediaQuery.of(context).size.height,
                    ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        'assets/images/logo.png',
                        height: 110,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Insira o número que deseja iniciar uma conversa do WhatsApp e clique em abrir conversa.',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                onEditingComplete: () {},
                                onFieldSubmitted: (_) {
                                  onPressed();
                                },
                                maxLength: 16,
                                controller: _numberEC,
                                inputFormatters: [numberFormatter],
                                decoration: InputDecoration(
                                  hintText: '(__) _____-_____',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  isDense: true,
                                  label: const Text('Número'),
                                ),
                                validator: Validatorless.multiple(
                                  [
                                    Validatorless.required(
                                        'O número é Obrigatótio 🤡'),
                                    Validatorless.min(
                                        12, 'Tá faltando números 🙄'),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                onFieldSubmitted: (_) {
                                  onPressed();
                                },
                                maxLength: 100,
                                maxLines: 3,
                                controller: _messageEC,
                                decoration: InputDecoration(
                                  helperText: 'Opcional',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  isDense: true,
                                  label: const Text('Mensagem'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: onPressed,
                        child: const Text(
                          'Abrir Conversa',
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 45),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40))),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text('OU'),
                      TextButton(
                          onPressed: () {
                            _controller.generateLink = true;
                            onPressed();
                          },
                          child: const Text('Gerar link para compartilhar')),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Observer(
                          builder: (_) {
                            return Visibility(
                              visible: _controller.generateLink,
                              child: Tooltip(
                                message: 'Link Copiado!',
                                child: SelectableText(
                                  _controller.urlShortener,
                                  style: const TextStyle(color: Colors.green),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Feito com ❤️ por'),
                          TextButton(
                              onPressed: () {
                                launch('https://holt.dev.br/');
                              },
                              child: const Text('HOLT'))
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void onPressed() async {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      String formatNumber({required String number}) {
        String n = number;
        n = n.replaceAll(' ', '');
        n = n.replaceAll('-', '');
        n = n.replaceAll('(', '');
        n = n.replaceAll(')', '');
        return n;
      }

      final number = formatNumber(number: _numberEC.text);
      final url =
          'https://api.whatsapp.com/send?phone=55$number&text=${_messageEC.text}';

      if (!_controller.generateLink) {
        await launch(
          Uri.parse(url).toString(),
          forceSafariVC: true,
          forceWebView: true,
          headers: <String, String>{'target': '_self'},
        );
      }

      final urlShortener = await _controller.getShortener(url);
      Clipboard.setData(ClipboardData(text: urlShortener));
    }
  }
}
