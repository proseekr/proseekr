import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:proseekr/src/controllers/language_preferences_controller.dart';

class Tts extends StatefulWidget {
  String text;
  Tts(this.text);

  @override
  _TtsState createState() => _TtsState();
}

class _TtsState extends State<Tts> {
  FlutterTts flutterTts = FlutterTts();
  bool _isSpeaking = false;
  String language = "en-in";

  @override
  void initState() {
    var array = LanguagePreferencesController.getAvailableLanguages();
    var selectedLanguage = LanguagePreferencesController.getPrefLang();
    if (selectedLanguage == array[1]) {
      language = "hi-IN";
    }
    flutterTts.setCompletionHandler(() {
      setState(() {
        _isSpeaking = false;
      });
    });
  }

  speak() async {
    setState(() {
      _isSpeaking = true;
    });
    print(flutterTts.getLanguages);
    await flutterTts.setLanguage(language);
    await flutterTts.setPitch(1.0);
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(0.7);
    await flutterTts.speak(widget.text);
  }

  stop() async {
    setState(() {
      _isSpeaking = false;
    });
    await flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _isSpeaking == false ? speak() : stop();
      },
      child:
          _isSpeaking == false ? Icon(Icons.volume_up) : Icon(Icons.volume_off),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
