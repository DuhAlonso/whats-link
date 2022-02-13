import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:validatorless/validatorless.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _numberEC = TextEditingController();
  final String msg = 'Insira';
  final numberFormatter = MaskTextInputFormatter(
    mask: '## #### #####',
    filter: {'#': RegExp(r'[0-9]')},
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/whatsapp-logo.png',
                        height: 200,
                      ),
                      const Text(
                        'Insira o número que deseja iniciar uma conversa do WhatsApp e clique em abrir conversa',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            onFieldSubmitted: (_) {
                              onPressed();
                            },
                            maxLength: 14,
                            controller: _numberEC,
                            inputFormatters: [numberFormatter],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              isDense: true,
                              label: const Text('Número'),
                            ),
                            validator: Validatorless.multiple([
                              Validatorless.required(
                                  'O número é Obrigatótio 🤡'),
                              Validatorless.min(10, 'Tá faltando números 🙄'),
                            ]),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: onPressed,
                          child: const Text(
                            'Abrir Conversa',
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40))),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Feito com ❤️ por'),
                          TextButton(
                              onPressed: () {
                                launch('https://github.com/DuhAlonso');
                              },
                              child: const Text('DuhAlonso'))
                        ],
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
      String number = _numberEC.text.replaceAll(' ', '');
      await launch(
        'https://wa.me/55$number',
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'target': '_self'},
      );
    }
  }
}
