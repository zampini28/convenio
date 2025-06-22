import 'dart:convert';
import 'dart:async';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/components/default_button.dart';
import 'package:app/components/default_layout.dart';
import 'package:app/components/default_textfield.dart';
import 'package:app/components/google_tile.dart';
import 'package:app/components/redirect.dart';

class LoginPage extends StatefulWidget {
  @override
  createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final double _spacing = 40.0;
  final double _logoSize = 100.0;

  String? emailError;
  String? passwordError;
  String? serverError;

  bool isLoading = false;

  Future<void> loginUser() async {
    setState(() {
      emailError = null;
      passwordError = null;
      serverError = null;
    });

    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty) {
      setState(() => emailError = 'Email é obrigatório');
    } else if (!EmailValidator.validate(email)) {
      setState(() => emailError = 'Digite um email válido');
    }

    if (password.isEmpty) {
      setState(() => passwordError = 'Senha é obrigatória');
    }

    if (emailError != null || passwordError != null) return;

    setState(() => isLoading = true);

    try {
      final response = await http
          .post(
            Uri.parse('http://localhost:3000/login'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'username': email, 'password': password}),
          )
          .timeout(
            const Duration(seconds: 10),
          ); // Set your desired timeout here

      final responseData = jsonDecode(response.body);

      if (response.statusCode != 200 || responseData['error'] != null) {
        setState(
          () => serverError = responseData['error'] ?? 'Erro desconhecido',
        );
      } else {
        Navigator.pushNamed(context, '/home');
      }
    } on TimeoutException {
      setState(
        () => serverError = 'Tempo de conexão esgotado. Tente novamente.',
      );
    } catch (e) {
      setState(() => serverError = 'Erro ao conectar-se ao servidor.');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      DefaultLayout(
        children: [
          SizedBox(height: _spacing),
          Icon(Icons.lock, size: _logoSize),
          SizedBox(height: _spacing),
          Text(
            'Bem-vindo de volta!',
            style: TextStyle(color: Colors.grey[700], fontSize: 16),
          ),
          SizedBox(height: _spacing / 2),
          if (serverError != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(serverError!, style: TextStyle(color: Colors.red)),
            ),
          DefaultTextField(
            controller: emailController,
            placeholder: 'Email',
            errorText: emailError,
          ),
          SizedBox(height: _spacing / 2),
          DefaultTextField(
            controller: passwordController,
            placeholder: 'Senha',
            obscureText: true,
            errorText: passwordError,
          ),
          SizedBox(height: _spacing / 2),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _spacing / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Esqueceu a senha?',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          SizedBox(height: _spacing / 2),
          DefaultButton(text: 'Entrar', onTap: loginUser),
          SizedBox(height: _spacing),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _spacing / 2),
            child: Row(
              children: [
                Expanded(
                  child: Divider(thickness: 0.5, color: Colors.grey[400]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Ou continuar com',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
                Expanded(
                  child: Divider(thickness: 0.5, color: Colors.grey[400]),
                ),
              ],
            ),
          ),
          SizedBox(height: _spacing),
          const GoogleTile(),
          SizedBox(height: _spacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ainda não tem cadastro?',
                style: TextStyle(color: Colors.grey[700]),
              ),
              SizedBox(width: 4),
              Redirect(
                route: '/signup',
                context: context,
                child: Text(
                  'Cadastre-se agora!',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      if (isLoading)
        Container(
          color: Colors.black.withOpacity(0.3),
          child: const Center(child: CircularProgressIndicator()),
        ),
    ],
  );
}
