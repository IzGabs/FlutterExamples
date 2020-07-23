import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///Resumidamente, essa model grava os valores e notifica os listeners que o valor mudou
///Assim, os listeners pegam através do Consumer e rebuildam o Widget com o novo valor
///
///
/// [Links uteis]
/// https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple
/// https://pub.dev/packages/provider/example
/// https://youtu.be/5KIRXuRR9bk
///
class CounterModel with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void aumentar() {
    _count++;
    notifyListeners();
  }
}

///O Change Notifier sempre tem que ficar no topo da árvore que voce quer que notifique os filhos
///Os seja, eu quero que tanto o [Providerson] quanto o [Provider GrandSon] alterem (ou leiam) os valores do provider
///Por isso, chamo o [ChangeNotifierProvider] antes de instanciar os dois.
///
///
///Exite um segundo método de ChangeNotifierProvider ele é o [MultiProvider], que é utilizado quando há mais de uma model a ser
///administrada pelo provider. Exemplo dela:
/// ```dart
/// MultiProvider(
///      providers: [
///     ChangeNotifierProvider(create: (context) => CartModel()),
///   Provider(create: (context) => SomeOtherClass()),
/// ],
/// child: MyApp(),
///),
/// ```

class ProviderStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ChangeNotifierProvider(
        create: (context) => CounterModel(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProviderSon(),
            ProviderGrandson(),
            ClasseDados(),
          ],
        ),
      ),
    );
  }
}

///The [builder] is called with three arguments. The first one is context, which you also get in every build method.

///The second argument of the builder function is the instance of the [ChangeNotifier].
/// It’s what we were asking for in the first place. You can use the data in the model to define what the UI should look like at any given point.

///The third argument is [child], which is there for optimization.
///If you have a large widget subtree under your Consumer that doesn’t change when the model changes, you can construct it once and get it through the builder.
class ProviderSon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      color: Colors.blue,
      child: Center(
        child: Consumer<CounterModel>(
            builder: (context, contadorObject, child) =>
                Text('Son WidgetCount ${contadorObject.count}')),
      ),
    );
  }
}

class ProviderGrandson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Calls `context.read` instead of `context.watch` so that it does not rebuild
    /// when [Counter] changes.
    return FloatingActionButton.extended(
      onPressed: () => context.read<CounterModel>().aumentar(),
      icon: Icon(Icons.plus_one),
      label: Text('GrandSonBtn'),
    );
  }
}

//Segundo Provider

class Dados extends ChangeNotifier {
  int _valor = 0;
  int get valor => _valor;

  void alterValue() {
    _valor++;
    notifyListeners();
  }
}

class ClasseDados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Dados(),
      child: Center(
        child: ClasseDados2(),
      ),
    );
  }
}

class ClasseDados2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Dados>(
        builder: (context, value, child) => Column(children: [
              Text(value.valor.toString()),
              ClasseDados3(),
            ]));
  }
}

class ClasseDados3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final providerServices = Provider.of<Dados>(context);
    return FloatingActionButton.extended(
      onPressed: () => providerServices.alterValue(),
      icon: Icon(Icons.plus_one),
      label: Text('ClasseDaoos3Btn'),
    );
  }
}
