import 'package:chama/src/controllers/home_controller.dart';
import 'package:chama/src/ui/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:validatorless/validatorless.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

enum ScreenSize { small, normal, large, extraLarge }

class _HomePageState extends State<HomePage> {
  final _controller = Get.find<HomeController>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _numberEC = TextEditingController();
  final TextEditingController _messageEC = TextEditingController();
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
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 110,
                        ),
                      ),
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
                                onFieldSubmitted: (_) {
                                  final formValid =
                                      _formKey.currentState?.validate() ??
                                          false;
                                  if (formValid) {
                                    _controller.openWhatsApp(
                                        number: _numberEC.text,
                                        message: _messageEC.text);
                                  }
                                },
                                maxLength: 16,
                                controller: _numberEC,
                                inputFormatters: [numberFormatter],
                                decoration: InputDecoration(
                                  hintText: '(__) _____-_____',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        const BorderSide(color: Colors.green),
                                  ),
                                  isDense: true,
                                  label: Text(
                                    'Número',
                                    style: TextStyle(color: Colors.green[800]),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                        color: Colors.green, width: 2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        const BorderSide(color: Colors.green),
                                  ),
                                ),
                                validator: Validatorless.multiple(
                                  [
                                    Validatorless.required(
                                        'O número é Obrigatótio 🤡'),
                                    Validatorless.min(
                                        14, 'Tá faltando números 🙄'),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                onFieldSubmitted: (_) {
                                  final formValid =
                                      _formKey.currentState?.validate() ??
                                          false;
                                  if (formValid) {
                                    _controller.openWhatsApp(
                                        number: _numberEC.text,
                                        message: _messageEC.text);
                                  }
                                },
                                maxLength: 100,
                                maxLines: 3,
                                controller: _messageEC,
                                decoration: InputDecoration(
                                  helperText: 'Opcional',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  isDense: true,
                                  label: Text('Mensagem',
                                      style:
                                          TextStyle(color: Colors.green[800])),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                        color: Colors.green, width: 2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        const BorderSide(color: Colors.green),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButtonDefault(
                        title: 'Abrir Conversa',
                        onPressed: () {
                          final formValid =
                              _formKey.currentState?.validate() ?? false;
                          if (formValid) {
                            _controller.openWhatsApp(
                                number: _numberEC.text,
                                message: _messageEC.text);
                          }
                        },
                        size: size,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text('OU'),
                      Obx(() {
                        if (!_controller.isLoading) {
                          return TextButton(
                              onPressed: () {
                                final formValid =
                                    _formKey.currentState?.validate() ?? false;
                                if (formValid) {
                                  _controller.generateLinkBitly(
                                      number: _numberEC.text,
                                      message: _messageEC.text);
                                }
                              },
                              child: const Text(
                                'Gerar link para compartilhar',
                                style: TextStyle(color: Colors.green),
                              ));
                        }
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: CircularProgressIndicator(
                            color: Colors.green,
                          ),
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Obx(
                          () => Visibility(
                            visible: _controller.generateLink,
                            child: Tooltip(
                              showDuration: const Duration(seconds: 2),
                              message: 'Link Copiado!',
                              textStyle: const TextStyle(color: Colors.green),
                              child: SelectableText(_controller.urlShortener,
                                  style: const TextStyle(color: Colors.green),
                                  onTap: () {
                                Share.share(_controller.urlShortener);
                              }),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Feito com ❤️ por'),
                          TextButton(
                              onPressed: () {
                                launchUrlString('https://holt.dev.br/');
                              },
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact),
                              child: Text('HOLT',
                                  style: TextStyle(color: Colors.green[800])))
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
}
