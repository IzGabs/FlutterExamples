import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FutureExample extends StatelessWidget {
  final FutureExampleDAO classFutures = new FutureExampleDAO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text('Exemplo de Futures')),
        body: FutureBuilder(
            future: classFutures.getSomeValue(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              ///Precisamos saber se o Future já terminou de executar (se já retornou algo)
              ///o connectionState faz exatamente isso

              if (snapshot.connectionState == ConnectionState.done) {
                ///Precisamos saber se tem dados para ser exibido

                if (snapshot.hasData) {
                  ///Como eu sei que o retorno vai ser em lista,
                  ///uso um ListView.builder para construir cada item em uma lista

                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      ///            Aqui eu coloquei ele dentro de um objeto do tipo correspondente
                      ///```dart  ||  Voce pode so chamar
                      /// [snapshot.data[index].**algumacoisa** ]
                      ///  ```

                      UserFutureE currentUser = snapshot.data[index];

                      ///O obj tem muito mais dados, porem vou mostrar na tela so aqueles ali
                      print(currentUser);
                      return Padding(
                          padding: EdgeInsets.all(15),
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nome: ${currentUser.name}'),
                                    Text('UserName:  ${currentUser.username}'),
                                    Text('Rua: ${currentUser.address.street}'),
                                    Text('Lat: ${currentUser.address.geo.lat}'),
                                    Text('Phone: ${currentUser.phone}'),
                                    Text(
                                        'Company: ${currentUser.company.name}'),
                                  ],
                                ),
                              )));
                    },
                  ); //Se o retorno fosse apenas um obj, voce nao precisa usar ListView.Builder
                } else {
                  ///Se ele nao tiver dados mostra uma mensagem generica
                  return Text('Não teve retorno');
                }
              } else {
                ///Se ele ainda nao obteve retorno do Future, mostra um simbolo de carregando
                return CircularProgressIndicator();
              }
            }));
  }
}

///Criei uma dao so de exemplo
class FutureExampleDAO {
  final url = 'https://jsonplaceholder.typicode.com/users';

  Future<List<UserFutureE>> getSomeValue() async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      //Se retornar sucesso, a gente converte o json e coloca cada item dele em uma lista
      List listaUsers = [];
      final decoded = json.decode(response.body);
      listaUsers = decoded.map((e) => UserFutureE.fromJson(e)).toList();

      ///Esse jeito acima é um pouquinho menos usado, se voce achar melhor, pode fazer igual o Gui
      /// ``` dart
      /// json.decode(response.body).forEach((element) {
      ///   listaUsers.add(UserFutureE.fromJson(element));
      /// });
      /// ```

      return listaUsers.cast();
    } else {
      // se a responsta não for OK, lançamos um erro
      throw Exception('Failed to load post');
    }
  }
}

///
///
///
///
///
///
///

///
///
///
///
///
///

///
//////
//////
////////////
//////
///
///
///
/// OBJETOS DE EXEMPLO
///
///
///
///
///
///
///
///
///Objetos gerados pelo https://javiercbk.github.io/json_to_dart/
class UserFutureE {
  int id;
  String name;
  String username;
  String email;
  Address address;
  String phone;
  String website;
  Company company;

  UserFutureE(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.address,
      this.phone,
      this.website,
      this.company});

  UserFutureE.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    phone = json['phone'];
    website = json['website'];
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['phone'] = this.phone;
    data['website'] = this.website;
    if (this.company != null) {
      data['company'] = this.company.toJson();
    }
    return data;
  }
}

class Address {
  String street;
  String suite;
  String city;
  String zipcode;
  Geo geo;

  Address({this.street, this.suite, this.city, this.zipcode, this.geo});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    suite = json['suite'];
    city = json['city'];
    zipcode = json['zipcode'];
    geo = json['geo'] != null ? new Geo.fromJson(json['geo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['suite'] = this.suite;
    data['city'] = this.city;
    data['zipcode'] = this.zipcode;
    if (this.geo != null) {
      data['geo'] = this.geo.toJson();
    }
    return data;
  }
}

class Geo {
  String lat;
  String lng;

  Geo({this.lat, this.lng});

  Geo.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Company {
  String name;
  String catchPhrase;
  String bs;

  Company({this.name, this.catchPhrase, this.bs});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    catchPhrase = json['catchPhrase'];
    bs = json['bs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['catchPhrase'] = this.catchPhrase;
    data['bs'] = this.bs;
    return data;
  }
}
