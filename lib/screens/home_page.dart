import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final timeZone = now.timeZoneName;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Fuso Horário Local'),
            SizedBox(height: 16),
            Text('Current Timezone: $timeZone'),
            Text('Current Date and Time: ${now.toString()}'),
          ],
        ),
      ),
    );
  }
}
