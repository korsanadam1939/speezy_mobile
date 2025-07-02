
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/errors/failure.dart';
import '../../business/entities/ReadingEntity.dart';
import '../providers/reading_provider.dart';
import '../widgets/storyWidget.dart';
class ReadingPage extends StatefulWidget {
  const ReadingPage({Key? key}) : super(key: key);

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReadingProvider>().eitherFailureOrStory();
    });;
  }

  @override
  Widget build(BuildContext context) {
    ReadingEntity? readingEntity = Provider.of<ReadingProvider>(context).story;
    Failure? failure = Provider.of<ReadingProvider>(context).failure;
    String? text = readingEntity?.story;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            StoryWidget(),

          ],
        ),
      ),
    );
  }
}
