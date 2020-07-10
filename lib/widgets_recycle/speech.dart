import 'package:flutter/material.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';
import 'package:thingtranslator/widgets_recycle/button.dart';

class SpeechContainer extends StatefulWidget {
  final String textForSpeech;

  const SpeechContainer({Key key, this.textForSpeech}) : super(key: key);

  @override
  _SpeechContainerState createState() => _SpeechContainerState();
}

class _SpeechContainerState extends State<SpeechContainer> {
  VoiceController _voiceController;

  @override
  void initState() {
    _voiceController = FlutterTextToSpeech.instance.voiceController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _voiceController.stop();
  }

  void _playVoice() {
    _voiceController.init().then((value) {
      _voiceController.speak(
        widget.textForSpeech,
        VoiceControllerOptions(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: "Speak",
      onPressed: _playVoice,
    );
  }
}
