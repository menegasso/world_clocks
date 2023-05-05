import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:intl/intl.dart';

class CalculadoraPage extends StatefulWidget {
  @override
  _CalculadoraPageState createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  String dropdownValue1 = 'America/Sao_Paulo'; // Valor padrão
  String dropdownValue2 = 'Europe/London'; // Valor padrão
  List<String> timeZones = [];

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones(); // Inicializa o banco de dados de TimeZones
    timeZones = tz.timeZoneDatabase.locations.keys.toList();
  }

  Future<void> _showDifferenceDialog() async {
    final location1 = tz.getLocation(dropdownValue1);
    final location2 = tz.getLocation(dropdownValue2);
    final now1 = tz.TZDateTime.now(location1);
    final now2 = tz.TZDateTime.now(location2);

    final difference = now2.difference(now1);
    final hours = difference.inHours.abs();
    final minutes = (difference.inMinutes.abs() % 60).toString().padLeft(2, '0');
    final seconds = (difference.inSeconds.abs() % 60).toString().padLeft(2, '0');

    final format = DateFormat('hh:mm a, MMM d, y');
    final time1 = format.format(now1);
    final time2 = format.format(now2);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Diferença de Horário'),
          content: Text('Informações entre os fusos horários: $dropdownValue1: $time1 e $dropdownValue2: $time2'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
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
        title: Text('Calculadora de Fuso Horário'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Selecione o fuso horário 1:'),
            DropdownButton<String>(
              value: dropdownValue1,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue1 = newValue!;
                });
              },
              items: timeZones
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
                  .toList(),
            ),
            SizedBox(height: 16),
            Text('Selecione o fuso horário 2:'),
            DropdownButton<String>(
              value: dropdownValue2,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue2 = newValue!;
                });
              },
              items: timeZones
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
                  .toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _showDifferenceDialog,
              child: Text('Calcular diferença'),
            ),
          ],
        ),
      ),
    );
  }
}
