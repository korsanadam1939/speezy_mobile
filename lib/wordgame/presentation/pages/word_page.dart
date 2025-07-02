import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speezy_mobile/reading/presentation/widgets/storyWidget.dart';
import 'package:speezy_mobile/wordgame/presentation/widgets/storyWidget.dart';

import '../providers/word_provider.dart';

class WordPage extends StatefulWidget {
  const WordPage({super.key});

  @override
  State<WordPage> createState() => _WordPageState();
}

class _WordPageState extends State<WordPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      Provider.of<WordProvider>(context, listen: false).eitherFailureOrWord();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          WordWidget(),
        ],
      ),
    );
  }
}
