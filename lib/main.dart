import 'package:flutter/material.dart';
void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TemperatureConverterHomePage(),
    );
  }
}

class TemperatureConverterHomePage extends StatefulWidget {
  @override
  _TemperatureConverterHomePageState createState() =>
      _TemperatureConverterHomePageState();
}

class _TemperatureConverterHomePageState
    extends State<TemperatureConverterHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _fromUnit = 'Celsius';
  String _toUnit = 'Fahrenheit';
  String _result = '';

  void _convert() {
    double inputValue = double.tryParse(_controller.text) ?? 0;

    double resultValue;
    if (_fromUnit == 'Celsius' && _toUnit == 'Fahrenheit') {
      resultValue = inputValue * 9 / 5 + 32;
    } else if (_fromUnit == 'Celsius' && _toUnit == 'Kelvin') {
      resultValue = inputValue + 273.15;
    } else if (_fromUnit == 'Fahrenheit' && _toUnit == 'Celsius') {
      resultValue = (inputValue - 32) * 5 / 9;
    } else if (_fromUnit == 'Fahrenheit' && _toUnit == 'Kelvin') {
      resultValue = (inputValue - 32) * 5 / 9 + 273.15;
    } else if (_fromUnit == 'Kelvin' && _toUnit == 'Celsius') {
      resultValue = inputValue - 273.15;
    } else if (_fromUnit == 'Kelvin' && _toUnit == 'Fahrenheit') {
      resultValue = (inputValue - 273.15) * 9 / 5 + 32;
    } else {
      resultValue = inputValue; // Same unit
    }

    setState(() {
      _result = resultValue.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Temperature',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<String>(
                  value: _fromUnit,
                  onChanged: (String? newValue) {
                    setState(() {
                      _fromUnit = newValue!;
                    });
                  },
                  items: <String>['Celsius', 'Fahrenheit', 'Kelvin']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Text('to'),
                DropdownButton<String>(
                  value: _toUnit,
                  onChanged: (String? newValue) {
                    setState(() {
                      _toUnit = newValue!;
                    });
                  },
                  items: <String>['Celsius', 'Fahrenheit', 'Kelvin']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              _result.isNotEmpty ? 'Result: $_result $_toUnit' : '',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
