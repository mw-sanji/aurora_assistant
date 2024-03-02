import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_assistant/services/openaiservices.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tts = FlutterTts();
  final openAIServices = OpenAIServices();
  SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  String lastWords = '';
  String? generatedSpeech;
  String? generratedImage;
  Future<void> initSpeech() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> SystemSpeak(String content) async {
    await tts.speak(content);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    speechToText.stop();
  }

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Aurora",
          style: TextStyle(
              fontSize: 25, fontFamily: 'Cera Pro', color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/assistant.jpg"))),
              ),
            ),
            if (generratedImage != null)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(generratedImage!)),
              ),
            Visibility(
              visible: generratedImage == null,
              child: Center(
                child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15)
                        .copyWith(topLeft: Radius.zero),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Center(
                      child: SelectableText(
                        generatedSpeech == null
                            ? "Good Morning, what task can I do for you?"
                            : generatedSpeech!,
                        style: TextStyle(
                            fontFamily: 'Cera-Pro',
                            fontSize: generatedSpeech == null ? 22 : 18),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: generatedSpeech == null && generratedImage == null,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: const Text(
                  "Here are a few Commands",
                  style: TextStyle(
                      fontFamily: 'Cera Pro',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Visibility(
              visible: generatedSpeech == null && generratedImage == null,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xff407b7c)),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text("ChatGPT",
                                style: TextStyle(
                                    fontFamily: 'Cera Pro',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                                "A smarter way to stay organized and informed with ChatGPT",
                                style: TextStyle(
                                    fontFamily: 'Cera Pro', fontSize: 15)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xff9acdcf)),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text("Dall-E",
                                style: TextStyle(
                                    fontFamily: 'Cera Pro',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                                "Get inspired and stay creative with your personal assistant powered by Dall-E",
                                style: TextStyle(
                                    fontFamily: 'Cera Pro', fontSize: 15)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xffe1ebee)),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text("Smart Voice Assistant",
                                style: TextStyle(
                                    fontFamily: 'Cera Pro',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                                "Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT",
                                style: TextStyle(
                                    fontFamily: 'Cera Pro', fontSize: 15)),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff9acdcf),
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            startListening();
          } else if (speechToText.isListening) {
            stopListening();
            print(lastWords);
            final speech = await openAIServices.isArtPrompt(lastWords);
            if (speech.contains('https')) {
              generratedImage = speech;
              generatedSpeech = null;
              setState(() {});
            } else {
              generatedSpeech = speech;
              generratedImage = null;
              setState(() {});
            }
            await SystemSpeak(speech);
            print(lastWords);
          } else {
            initSpeech();
          }
        },
        child: Icon(Icons.mic),
      ),
    );
  }
}
