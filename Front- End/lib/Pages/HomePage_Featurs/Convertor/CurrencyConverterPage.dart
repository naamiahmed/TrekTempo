import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:travel_app/Pages/Sign-In-Up/Components/Button.dart';

class CurrencyConverterPage extends StatefulWidget {
  @override
  _CurrencyConverterPageState createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  final TextEditingController _amountController = TextEditingController();
  String _fromCurrency = 'USD'; // Default base currency
  String _toCurrency = 'LKR'; // Default target currency
  String _convertedAmount = '';
  bool _isLoading = false;

  final String _apiKey = 'YOUR_API_KEY'; // Your ExchangeRate API Key

  Future<void> convertCurrency(String amount, String from, String to) async {
    final url = Uri.parse(
        'https://v6.exchangerate-api.com/v6/$_apiKey/pair/$from/$to/$amount');

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          _convertedAmount =
              (double.parse(amount) * responseData['conversion_rate'])
                  .toStringAsFixed(2);
        });
      } else {
        print('Currency conversion failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Enter amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _fromCurrency,
                  onChanged: (String? newValue) {
                    setState(() {
                      _fromCurrency = newValue!;
                    });
                  },
                  items: <String>['USD', 'LKR', 'EUR', 'GBP', 'INR']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Icon(Icons.arrow_forward),
                DropdownButton<String>(
                  value: _toCurrency,
                  onChanged: (String? newValue) {
                    setState(() {
                      _toCurrency = newValue!;
                    });
                  },
                  items: <String>['USD', 'LKR', 'EUR', 'GBP', 'INR']
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
              onPressed: () {
                if (_amountController.text.isNotEmpty) {
                  convertCurrency(
                      _amountController.text, _fromCurrency, _toCurrency);
                }
              },
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Text(
                    _convertedAmount.isNotEmpty
                        ? 'Converted Amount: $_convertedAmount $_toCurrency'
                        : '',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
          ],
        ),
      ),
    );
  }
}
