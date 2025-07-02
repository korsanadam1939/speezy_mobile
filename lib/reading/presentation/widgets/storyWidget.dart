import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../business/entities/ReadingEntity.dart';
import '../providers/reading_provider.dart';
import '../../../core/errors/failure.dart';

class StoryWidget extends StatelessWidget {
  OverlayEntry? _overlayEntry;



  @override
  Widget build(BuildContext context) {
    ReadingEntity? story = Provider.of<ReadingProvider>(context).story;
    Failure? failure = Provider.of<ReadingProvider>(context).failure;

    int wordCount = story?.story.split(' ').length ?? 0;
    double progress = wordCount / 500;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
        child: Column(
          children: [
            if (story != null) ...[
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            story.title,
                            style: const TextStyle(
                                fontSize: 16,
                                height: 2.3,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: story.story
                                .split(' ')
                                .map((kelime) => TextSpan(
                              text: '$kelime ',
                              style: const TextStyle(color: Colors.black, fontSize: 16, height: 1.5),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {

                                  String wordmean = await getword(story.translations, kelime.toLowerCase().replaceAll(RegExp(r'[.,!?"]'), ''));
                                  print("kelimenin anlamı $wordmean ");
                                  showDialog(
                                    context: context,
                                    builder:
                                        (_) => AlertDialog(
                                      title: Center(child: Text("Kelime çevirisi")),
                                      content: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            kelime.replaceAll(RegExp(r'[.,!?"]'), '' ),style: TextStyle(fontSize: 20,color: Colors.red, fontWeight: FontWeight.bold),
                                          ),
                                          Text('    -    '),
                                          Text(
                                            wordmean,style: TextStyle(fontSize: 20,color: Colors.blueGrey, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        Center(
                                          child: SizedBox(
                                            width: 200,
                                            child: ElevatedButton.icon(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              label: const Text(
                                                'Kapat',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                padding: const EdgeInsets.symmetric(
                                                  vertical: 16,
                                                ),
                                                backgroundColor: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(
                                                    12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );




                                },
                            ))
                                .toList(),
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Bu hikayede $wordCount kelime var',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,
                      backgroundColor: Colors.grey.shade300,
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('500 kelimeli hikayeler!'),
                        Text('$wordCount/500'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Provider.of<ReadingProvider>(context, listen: false).eitherFailureOrStory();




                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.create, color: Colors.white),
                  label: const Text(
                    'Yeni hikaye üret',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ] else if (failure != null) ...[
              Expanded(
                child: Center(
                  child: Text(
                    failure.errorMessage,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ] else ...[
              const Expanded(
                child: Center(
                  child:  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
                    strokeWidth: 8,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  Future<String> getword(Map<String,String> words,String wordinput) async {
    for (var word in words.entries) {
      print("${word.key} : ${word.value}");
      if(word.key ==wordinput ){
        return word.value;

      }

    }
    return "kelime yok";

}
  void _showOverlay(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 100,
        left: 50,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.black87,
            child: const Text(
              'Bu bir overlay!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );


    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

}
