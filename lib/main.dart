import 'package:flutter/material.dart';
import 'package:world_clocks/screens/home_page.dart';
import 'package:world_clocks/screens/configuracoes_page.dart';
import 'package:world_clocks/screens/calculadora_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Relógio Mundial',
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Relógio Mundial'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home), text: 'Home'),
                Tab(icon: Icon(Icons.settings), text: 'Configurações'),
                Tab(icon: Icon(Icons.access_time), text: 'Calculadora Fuso Horário'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              HomePage(),
              ConfiguracoesPage(),
              CalculadoraPage(),
            ],
          ),
        ),
      ),
    );
  }
}
