import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  DefaultTextField({
    super.key,
    this.obscureText,
    this.placeholder,
    this.keyboardType,
    this.prefixText,
    this.prefixIcon,
    this.errorText,
    this.inputFormatters,
    required this.controller, // required?
  });

  // controller - um controller pode se inscrever ao
  // um campo de texto, e receberar informação sobre ele.

  // Também pode atualiza-lo, por exemplo, quando alguém
  // colocar a senha, pode atualizar o UI com os requisitos
  // (characteres minimo, simbolos, números etc)
  // provavelmente tem um jeito melhor de fazer isso -_-

  // porém o flutter recomenda assim vide
  // https://docs.flutter.dev/cookbook/forms/text-field-changes
  // mesmo sendo um péssimo design pattern

  final controller;
  final prefixText;
  final prefixIcon;
  final inputFormatters;
  final errorText;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String? placeholder;

  @override
  build(final _) => Padding(
    // distancia do canto da tela
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: TextField(
      // TODO: colocarr com componente
      controller: controller, // controller p/ receber informação do campo
      obscureText: obscureText ?? false, // texto tipo senha, aka, ****
      // layout do teclado
      keyboardType: keyboardType,

      // mascara do campo
      inputFormatters: inputFormatters,

      // estilização
      decoration: InputDecoration(
        // borda
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),

        // borda quando focado
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),

        // coloração
        fillColor: Colors.grey.shade200,
        filled: true,

        // texto de substuição
        hintText: placeholder,
        hintStyle: TextStyle(color: Colors.grey[500]),

        // prefixo utilizado para número de telefone
        prefixText: prefixText,
        prefixIcon: prefixIcon,

        // mensagem de error
        errorText: errorText,
      ),
    ),
  );
}
