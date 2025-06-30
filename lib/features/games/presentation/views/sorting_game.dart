import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codekids/core/utils/assets.dart';
import 'package:codekids/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';

import '../../../child_auth/data/models/auth_viewmodel.dart';

class SortingGame extends StatefulWidget {
  const SortingGame({super.key});

  @override
  SortingGameState createState() => SortingGameState();
}

class SortingGameState extends State<SortingGame> {
  List<String> scrambledCode = [];
  FlutterTts tts = FlutterTts();
  stt.SpeechToText speech = stt.SpeechToText();
  bool isListening = false;
  int currentLevel = 1;
  List<String> correctOrder = [];
  Map<String, dynamic>? levelData;

  Future<void> loadLevel(int level) async {
    final doc = await FirebaseFirestore.instance
        .collection('games')
        .where('level', isEqualTo: level)
        .limit(1)
        .get();

    if (doc.docs.isNotEmpty) {
      final data = doc.docs.first.data();
      correctOrder = List<String>.from(data['code']);
      scrambledCode = List<String>.from(correctOrder)..shuffle();
      levelData = data;
      setState(() {});
      _speak("يَلَاَ رتبْ الكود في المستوى $level!");
    } else {
      _speak("👏 لقد أنهيت كل المستويات!");
      // عرض رسالة النهاية
    }
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final auth = Provider.of<AuthViewModel>(context, listen: false);
      final currentLevel = auth.levels['sortingGame'] ?? 1;
      loadLevel(currentLevel);
    });

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
              command.contains("sydney") ||
              command.contains("saadney")) {
            _speak("عشان تفوز! حاول تحط أوامر الكود بالترتيب الصح علشان تروح للمستوى اللى بعده بمعنى ضع ستارت كود فى المقدمة وبعدها الاكواد البرمجية ثم يو did it");
          }
        });
      } else {
        print("Speech recognition not available");
      }
    } else {
      print("Microphone permission denied");
    }
  }

  void checkOrder() async {
    bool isCorrect = scrambledCode.join("\n") == correctOrder.join("\n");

    if (isCorrect) {
      _speak("جدعْ!");
      final auth = Provider.of<AuthViewModel>(context, listen: false);
      int currentLevel = auth.levels['sortingGame'] ?? 1;
      int nextLevel = currentLevel + 1;

      await auth.updateGameLevel('sortingGame', nextLevel); // حفظ المستوى الجديد
      loadLevel(nextLevel); // 👈 تحميل ليفيل جديد

      // ممكن تظهر SnackBar أو Animation بدل AlertDialog هنا
    }
    else {
      _speak("حاولْ تانِىِ!");

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Oops! Try Again! ❌", textAlign: TextAlign.center),
            content: const Text("Something is not right, try again!"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
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
