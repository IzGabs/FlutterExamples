import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(StartApp());
}

class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: MyApp(),
    );
  }
}

class User {
  String email;
  String senha;
  User({this.email, this.senha});
}

class MyApp extends StatelessWidget {
  ///O [StreamController] controla a stream e envia os dados para ela através do stream.add ou stream.sink.add
  final StreamController _stream = new StreamController(
      onListen: () => print('Alguem esta escutando a essa stream'));

  ///[GlobalKeys] sao tipo variaveis globais, basicamente,
  ///voce pode acessas propriedades do Widget a partir da Key dele
  final GlobalKey<FormState> _formGlobalKey = new GlobalKey<FormState>();

  ///Vou fazer usando Objeto, mas voce pode criar uma [TextEditingController] pra pegar o valor
  /// de cada um dos TextFormFields
  final User user = new User();

  @override
  Widget build(BuildContext context) {
    int count = 1;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Hello JavaBoy'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _stream.add(count);
            count++;
          },
          child: Icon(Icons.plus_one)),
      body: Form(
        key: _formGlobalKey,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    scrollPadding: EdgeInsets.all(8.0),
                    validator: (value) =>
                        value.isEmpty ? 'Digita o User vacilao' : null,
                    onSaved: (value) => user.email = value,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 0.5))),
                  )),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    scrollPadding: EdgeInsets.all(8.0),
                    //Acionado no .Validade()
                    validator: (value) =>
                        value.isEmpty ? 'Digita a senha mane' : null,
                    //Acionado no save()
                    onSaved: (value) => user.senha = value,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 0.5))),
                  )),
              FloatingActionButton.extended(
                  onPressed: () {
                    ///O `validate()` retorna verdadeiro caso todos os formFilds passem pela validação do
                    /// `validator`
                    if (_formGlobalKey.currentState.validate()) {
                      /// Aqui ele salva os campos do TFF e executa aquele `OnSaved`
                      _formGlobalKey.currentState.save();
                      print(user.email);
                      print(user.senha);
                    }
                  },
                  label: Text('Save')),

              ///StreamBuilder
              StreamBuilder(
                stream: _stream.stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData)
                    return Text('Vindo da Stream : ${snapshot.data}');
                  else
                    return Text('Aguardando seu click');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// voce tambem pode usar streams assim:
/// /// ```dart
/// final steamSubs = _stream.stream.listen((event) {
///   //Faça alguma coisa quando receber algum valor
/// });
/// ```
/// Mas eu recomendo usar o StreamBuilder
