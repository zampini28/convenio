import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:email_validator/email_validator.dart';
import 'package:app/components/default_layout.dart';
import 'package:app/components/default_text.dart';
import 'package:app/components/default_button.dart';
import 'package:app/components/default_textfield.dart';
import 'package:app/components/google_tile.dart';
import 'package:app/components/redirect.dart';
import 'package:app/pages/login_page.dart';

class SignupPage extends StatefulWidget {
  @override
  createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _spacing = 40.0; // espaçamento vertical dos componentes

  // controllers
  final name_controller = TextEditingController();
  final phone_controller = TextEditingController();
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  final password2_controller = TextEditingController();

  String? name_error;
  String? phone_error;
  String? email_error;
  String? password_error;
  String? password2_error;
  String? termOfUse_error;

  bool termOfUseAccepted = false;

  // TODO: implementar função de cadastro

  Future<void> signupUser() async {
    setState(() {
      name_error = null;
      phone_error = null;
      email_error = null;
      password_error = null;
      password2_error = null;
      termOfUse_error = null;
    });

    final name = name_controller.text.trim();
    final phone = phone_controller.text.trim();
    final email = email_controller.text.trim();
    final password = password_controller.text;
    final password2 = password2_controller.text;

    bool hasError = false;

    final upperCase = RegExp(r'[A-Z]');
    final lowerCase = RegExp(r'[a-z]');
    final number = RegExp(r'\d');
    final specialChar = RegExp(r'[!@#\$&*~]');
    final minLength = 8;

    if (name.isEmpty) {
      name_error = 'Nome completo é obrigatório';
      hasError = true;
    }

    if (phone.isEmpty) {
      phone_error = 'Telefone é obrigatório';
      hasError = true;
    }

    if (email.isEmpty) {
      email_error = 'Email é obrigatório';
      hasError = true;
    } else if (!EmailValidator.validate(email)) {
      email_error = 'Digite um email válido';
      hasError = true;
    }

    if (password.isEmpty) {
      password_error = 'Senha é obrigatória';
      hasError = true;
    } else {
      if (!upperCase.hasMatch(password)) {
        password_error = 'Senha precisa de pelo menos UMA letra maiúscula';
        hasError = true;
      } else if (!lowerCase.hasMatch(password)) {
        password_error = 'Senha precisa de pelo menos UMA letra minúscula';
        hasError = true;
      } else if (!number.hasMatch(password)) {
        password_error = 'Senha precisa de pelo menos UM número';
        hasError = true;
      } else if (!specialChar.hasMatch(password)) {
        password_error = 'Senha precisa de pelo menos UM caractere especial';
        hasError = true;
      } else if (password.length < minLength) {
        password_error = 'Senha precisa ter pelo menos 8 caracteres';
        hasError = true;
      }
    }

    if (password != password2) {
      password2_error = 'As senhas não correspondem';
      hasError = true;
    }

    if (!termOfUseAccepted) {
      termOfUse_error = 'Aceite nossos termos de uso';
      hasError = true;
    }

    setState(() {});

    if (!hasError) {
      Navigator.pushNamed(context, '/login');
    }
  }

  final Uri urlTermOfUse = Uri.parse(
    'https://pt.wikipedia.org/wiki/Termos_de_uso',
  );

  @override
  build(final context) => DefaultLayout(
    children: [
      SizedBox(height: _spacing),

      //  icon de cadastro
      const Icon(Icons.person_add_alt_rounded, size: 100),

      SizedBox(height: _spacing),

      DefaultText('Bem-vindo!'),
      DefaultText('Informe suas informações para cadastro.'),

      SizedBox(height: _spacing),

      //  swap de usuário
      // TODO: componente de usuário
      //       com estado para tirar campo crefito

      //  digitar nome
      DefaultTextField(
        controller: name_controller,
        placeholder: 'Nome Completo',
        errorText: name_error,
      ),

      SizedBox(height: _spacing / 2),

      //  digitar telefone
      DefaultTextField(
        controller: phone_controller,
        placeholder: '(XX) XXXXX-XXXX',
        prefixIcon: Padding(
          padding: EdgeInsets.all(15),
          child: DefaultText('+55 '),
        ),
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
          MaskedInputFormatter('(##) #####-####'),
        ],
        errorText: phone_error,
      ),

      SizedBox(height: _spacing / 2),

      //  digitar email
      DefaultTextField(
        controller: email_controller,
        placeholder: 'Email',
        errorText: email_error,
      ),

      SizedBox(height: _spacing / 2),

      //  digitar senha
      DefaultTextField(
        controller: password_controller,
        placeholder: 'Senha',
        obscureText: true,
        errorText: password_error,
      ),

      SizedBox(height: _spacing / 2),

      //  digitar confirmar senha
      DefaultTextField(
        controller: password2_controller,
        placeholder: 'Confirmar Senha',
        obscureText: true,
        errorText: password2_error,
      ),

      SizedBox(height: _spacing / 2),

      //  termos de uso
      Padding(
        padding: EdgeInsets.symmetric(horizontal: _spacing / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Aceite nosso', style: TextStyle(color: Colors.grey[700])),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: () => launchUrl(urlTermOfUse),
              child: Text(
                'Termo de Uso.',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Checkbox(
              value: termOfUseAccepted,
              onChanged:
                  (val) => setState(() => termOfUseAccepted = val ?? false),
            ),
          ],
        ),
      ),

      // mensagem de error
      if (termOfUse_error != null)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _spacing / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Aceite nossos termos de uso',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 4),
            ],
          ),
        ),

      SizedBox(height: _spacing / 2),

      //  botão p/ cadastrar
      DefaultButton(text: 'Cadastrar', onTap: signupUser),

      SizedBox(height: _spacing / 2),

      //  texto para cadastro MFA
      Padding(
        padding: EdgeInsets.symmetric(horizontal: _spacing / 2),
        child: Row(
          children: [
            Expanded(child: Divider(thickness: 0.5, color: Colors.grey[400])),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Ou continuar com',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
            Expanded(child: Divider(thickness: 0.5, color: Colors.grey[400])),
          ],
        ),
      ),

      SizedBox(height: _spacing / 2),

      //  cadastro c/ google
      const GoogleTile(),

      SizedBox(height: _spacing / 2),

      //  já é cadastrado?
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Já tem cadastro?', style: TextStyle(color: Colors.grey[700])),
          const SizedBox(width: 4),
          Redirect(
            route: '/login',
            context: context,
            child: Text(
              'Entre agora!',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ],
  );
}
