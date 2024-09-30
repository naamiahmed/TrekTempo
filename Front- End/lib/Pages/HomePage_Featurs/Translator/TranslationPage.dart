import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:travel_app/Pages/HomePage_Featurs/Components/Button.dart';

class TranslatorPage extends StatefulWidget {
  @override
  _TranslatorPageState createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage> {
  TextEditingController _textController = TextEditingController();
  String _translatedText = '';
  String _targetLanguage = 'es'; // Default target language is Spanish
  bool _isLoading = false;

  final String _apiKey = 'AIzaSyCcp-n3pWlsKuIaYtzodL0AA-ZC4h9rqNw'; // Your API Key

  Future<void> translateText(String text, String targetLanguage) async {
    final url = Uri.parse(
        'https://translation.googleapis.com/language/translate/v2?key=$_apiKey');
    
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(url, body: {
        'q': text,
        'target': targetLanguage,
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          _translatedText = responseData['data']['translations'][0]['translatedText'];
        });
      } else {
        print('Translation failed with status: ${response.statusCode}');
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
        title: Text('Translator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Enter text to translate',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _targetLanguage,
              onChanged: (String? newValue) {
                setState(() {
                  _targetLanguage = newValue!;
                });
              },
              items: <String>['es', 'fr', 'de', 'ja', 'zh']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(getLanguageName(value)),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Button(
              text: 'Translate',
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  translateText(_textController.text, _targetLanguage);
                }
              },
            ),
            SizedBox(height: 20),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Text(
                    _translatedText,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
          ],
        ),
      ),
    );
  }

  String getLanguageName(String code) {
    switch (code) {
      case 'es':
        return 'Spanish';
      case 'fr':
        return 'French';
      case 'de':
        return 'German';
      case 'ja':
        return 'Japanese';
      case 'zh':
        return 'Chinese';
      default:
        return 'Unknown';
    }
  }
}