import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:intl/intl.dart';

class ConfiguracoesPage extends StatefulWidget {
  @override
  _ConfiguracoesPageState createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  String dropdownValue = 'America/Sao_Paulo'; // Valor padrão
  List<String> timeZones = [];

  @override
  void initState() {
    super.initState();
    // Inicializa o banco de dados de TimeZones
    tz.initializeTimeZones();
    // Obtém a lista de timezones disponíveis
    timeZones = tz.timeZoneDatabase.locations.keys.toList();
  }

  // Função para mostrar os dados do fuso horário selecionado pelo usuário
  void showSelectedTimeZoneData() {
    // Obtém a data e hora atual para o fuso horário selecionado
    tz.TZDateTime now = tz.TZDateTime.now(tz.getLocation(dropdownValue));
    // Formata a hora atual como uma string
    String formattedTime = DateFormat('HH:mm:ss').format(now);
    // Formata a data atual como uma string
    String formattedDate = DateFormat('EEE, MMM d, y').format(now);

    // Mostra um AlertDialog com o fuso horário selecionado, a hora atual e a data atual
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Current Time and Date'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Selected timezone: ${dropdownValue}'),
              SizedBox(height: 16.0),
              Text('Current time: $formattedTime'),
              SizedBox(height: 8.0),
              Text('Current date: $formattedDate'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Selecione um fuso horário:'),
            // DropdownButton para selecionar o fuso horário
            DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String? newValue) {
                // Atualiza o valor do fuso horário selecionado e mostra os dados do fuso horário
                setState(() {
                  dropdownValue = newValue!;
                  showSelectedTimeZoneData();
                });
              },
              // Cria a lista de opções de fuso horário a partir da lista timeZones
              items: timeZones
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
