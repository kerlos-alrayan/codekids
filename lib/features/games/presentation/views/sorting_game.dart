import 'package:codekids/core/utils/assets.dart';
import 'package:codekids/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';

class SortingGame extends StatefulWidget {
  const SortingGame({super.key});

  @override
  SortingGameState createState() => SortingGameState();
}

class SortingGameState extends State<SortingGame> {
  final List<String> correctOrder = [
    'Start coding!',
    'var message = "Hello, World!";',
    'print(message);',
    'You did it! 🎉'
  ];

  List<String> scrambledCode = [];
  FlutterTts tts = FlutterTts();
  stt.SpeechToText speech = stt.SpeechToText();
  bool isListening = false;

  @override
  void initState() {
    super.initState();
    scrambledCode = List.from(correctOrder)..shuffle();
    _speak("يَلَاَ ساعدْ صُحابكْ في الترتيبْ!");
  }

  String removeTashkeel(String text) {
    return text.replaceAll(RegExp(r'[\u064B-\u065F]'), '');
  }

  void _speak(String text) async {
    await tts.setLanguage("ar-EG");
    await tts.setPitch(1.0);
    await tts.speak(text);
  }

  Future<void> startListening() async {
    var status = await Permission.microphone.request();

    if (status.isGranted) {
      bool available = await speech.initialize(
        onStatus: (status) => print('Speech status: $status'),
        onError: (error) => print('Speech error: $error'),
      );

      if (available) {
        setState(() => isListening = true);
        speech.listen(onResult: (result) {
          String command = result.recognizedWords.toLowerCase();
          print("Recognized: $command");
          if (command.contains("help") ||
              command.contains("ساعدني") ||
              command.contains("sydney")) {
            _speak(".");
          }
        });
      } else {
        print("Speech recognition not available");
      }
    } else {
      print("Microphone permission denied");
    }
  }

  void checkOrder() {
    bool isCorrect = scrambledCode.join("\n") == correctOrder.join("\n");
    _speak(isCorrect ? "جدعْ!" : " حاولْ تانِىِ!");

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            isCorrect ? "Great Job! 🎉" : "Oops! Try Again! ❌",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isCorrect ? Colors.green : Colors.red,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isCorrect
                    ? "You wrote your first code correctly! 🚀"
                    : "Something is not right, try again!",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Icon(
                isCorrect ? Icons.check_circle : Icons.error,
                size: 50,
                color: isCorrect ? Colors.green : Colors.red,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "OK",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsData.gamesSortingBG),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .5,
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        'Arrange the code correctly?',
                        style: Styles.textStyle20.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: DragAndDropLists(
                        children: [
                          DragAndDropList(
                            children: scrambledCode
                                .map((line) => DragAndDropItem(
                                      child: Card(
                                        color: Colors.lightBlueAccent,
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            line,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                        onItemReorder: (oldItemIndex, oldListIndex,
                            newItemIndex, newListIndex) {
                          setState(() {
                            final item = scrambledCode.removeAt(oldItemIndex);
                            scrambledCode.insert(newItemIndex, item);
                          });
                        },
                        onListReorder: (int oldListIndex, int newListIndex) {},
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purpleAccent,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                          ),
                          onPressed: checkOrder,
                          icon: Icon(Icons.play_arrow, color: Colors.white),
                          label: Text(
                            "Run Code! 🚀",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 10),
                        FloatingActionButton(
                          backgroundColor: Colors.blue,
                          onPressed: startListening,
                          child: Icon(isListening ? Icons.mic_off : Icons.mic),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
