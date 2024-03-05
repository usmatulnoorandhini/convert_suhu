import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(SuhuConverterApp());
}

class SuhuConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Suhu Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SuhuConverter(),
    );
  }
}

class SuhuConverter extends StatefulWidget {
  @override
  _SuhuConverterState createState() => _SuhuConverterState();
}

class _SuhuConverterState extends State<SuhuConverter> {
  TextEditingController _inputController = TextEditingController();
  double _inputValue = 0;
  double _resultValue = 0;
  String _selectedFromUnit = 'Celsius';
  String _selectedToUnit = 'Kelvin';

  Map<String, double Function(double)> _conversionFunctions = {
    'Celsius': (value) => value,
    'Fahrenheit': (value) => (value * 9 / 5) + 32,
'Kelvin': (value) => value + 273.15,
'Reamur': (value) => value * 4 / 5,

  };

  void _convertSuhu() {
    double convertedValue = _conversionFunctions[_selectedToUnit]!(_inputValue);
    setState(() {
      _resultValue = convertedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suhu Converter'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Masukkan Nilai Suhu'),
              onChanged: (value) {
                setState(() {
                  _inputValue = double.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
       DropdownButton<String>(
  value: _selectedFromUnit,
  onChanged: (String? newValue) {
    if(newValue != null){
      setState(() {
        _selectedFromUnit = newValue;
      });
    }
  },
  items: _conversionFunctions.keys.map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList(),
),

                IconButton(
                  icon: Icon(Icons.swap_vert),
                  onPressed: () {
                    setState(() {
                      var temp = _selectedFromUnit;
                      _selectedFromUnit = _selectedToUnit;
                      _selectedToUnit = temp;
                      _inputValue = _resultValue;
                    });
                  },
                ),
             DropdownButton<String>(
  value: _selectedToUnit,
  onChanged: (String? newValue) {
    if(newValue != null){
      setState(() {
        _selectedToUnit = newValue;
      });
    }
  },
  items: _conversionFunctions.keys.map<DropdownMenuItem<String>>((String value) {
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
  onPressed: _convertSuhu,
  child: Text('Konversi'),
  style: ElevatedButton.styleFrom(
    primary: Colors.blue, // memberikan warna latar belakang
    onPrimary: Colors.white, // memberikan warna teks
  ),
),


            SizedBox(height: 20),
            Text(
              'Hasil Konversi: $_resultValue ${_selectedToUnit.substring(0, 1)}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
