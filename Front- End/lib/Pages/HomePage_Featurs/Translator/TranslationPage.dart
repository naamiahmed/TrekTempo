import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:travel_app/Pages/HomePage_Featurs/MainHomePage.dart';

class TranslatorPage extends StatefulWidget {
  const TranslatorPage({super.key});

  @override
  State<TranslatorPage> createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage> {
  final inputController = TextEditingController();
  final outputController = TextEditingController();
  final translator = GoogleTranslator();

  String inputLanguage = 'English';
  String outputLanguage = 'Sinhala';

  final Map<String, String> languageCodes = {
    'Sinhala': 'si',
    'Chinese': 'zh-cn',
    'English': 'en',
    'French': 'fr',
    'Hindi': 'hi',
    'Russian': 'ru',
    'Tamil': 'ta',
  };

  Future<void> translateText() async {
    final fromLangCode = languageCodes[inputLanguage] ?? 'en';
    final toLangCode = languageCodes[outputLanguage] ?? 'en';

  // Check if input text contains only special characters
  if (RegExp(r'^[^a-zA-Z]+$').hasMatch(inputController.text)) {
    setState(() {
      outputController.text = 'Invalid characters';
    });
    return; // Exit the method if input is invalid
  }

    if (fromLangCode == toLangCode) {
    setState(() {
      outputController.text = 'Please select different languages';
    });
    return; // Exit the method if the languages are the same
  }

    try {
      final translated = await translator.translate(
        inputController.text,
        from: fromLangCode,
        to: toLangCode,
      );

      setState(() {
        outputController.text = translated.text;
      });
    } catch (e) {
      setState(() {
        outputController.text = 'Enter text to translate';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const MainHomePage();
            }));
          },
        ),
        title: const Text(
          'Translator',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600,),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.black,
            height: 0.5,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: Colors.white,
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: inputController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter text to translate",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete,
                          color: Color.fromARGB(255, 62, 62, 66)),
                      onPressed: () {
                        inputController.clear();
                        outputController.clear(); // Clear the input text field
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Styled Input Language Dropdown
                Container(
                  width: 90, // Set a width to center the dropdown
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.grey, width: 1),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5.0,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true, // Expand dropdown to fit the container
                    value: inputLanguage,
                    onChanged: (newValue) {
                      setState(() {
                        inputLanguage = newValue!;
                      });
                    },
                    items: languageCodes.keys
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Center(
                            child: Text(value)), // Center the dropdown item
                      );
                    }).toList(),
                    underline: const SizedBox(), // Remove underline
                  ),
                ),

                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      // Swap the input and output languages
                      final temp = inputLanguage;
                      inputLanguage = outputLanguage;
                      outputLanguage = temp;

                      // Swap the text content between input and output fields
                      final tempText = inputController.text;
                      inputController.text = outputController.text;
                      outputController.text = tempText; // Set output to previous input

                    });
                  },
                  mini: true,
                  backgroundColor: Colors.blueAccent,
                  child: const Icon(
                    Icons.swap_horiz,
                    color: Colors.white,
                  ),
                ),

                // Styled Output Language Dropdown
                Container(
                  width: 90, // Set a width to center the dropdown
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.grey, width: 1),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5.0,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true, // Expand dropdown to fit the container
                    value: outputLanguage,
                    onChanged: (newValue) {
                      setState(() {
                        outputLanguage = newValue!;
                      });
                    },
                    items: languageCodes.keys
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Center(
                            child: Text(value)), // Center the dropdown item
                      );
                    }).toList(),
                    underline: const SizedBox(), // Remove underline
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.white,
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: outputController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Result here...",
                      hintStyle: TextStyle(
                        color: Colors.grey, // Change hint text color
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      )),
                  readOnly: true,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: translateText,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                minimumSize: const Size(150, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text(
                "Translate",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
