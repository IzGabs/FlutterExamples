import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:form_daniel/provider_teste.dart';
import 'package:form_daniel/socket_example.dart';
import 'package:form_daniel/streams_form.dart';

import 'futures_example.dart';

void main() {
  runApp(StartApp());
}

class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      routes: {
        '/Home': (context) => Home(),
        '/StreamsAndForms': (context) => StreamsAndForms(),
        '/Provider': (context) => ProviderStart(),
        '/Socket': (context) => TesteSocket(),
        '/FutureExample': (context) => FutureExample(),
      },
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home'), centerTitle: true),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildBtns('/StreamsAndForms', context, 'Streams E Forms'),
              _buildBtns('/Provider', context, 'Provider Exemple'),
              _buildBtns('/Socket', context, 'Socket Exemple'),
              _buildBtns('/FutureExample', context, 'Exemplo de Uso de Futures')
            ],
          ),
        ));
  }

  _buildBtns(route, context, desc) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: RaisedButton(
            onPressed: () => Navigator.pushNamed(context, route),
            child: Text(desc)));
  }
}
