import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speezy_mobile/reading/presentation/providers/reading_provider.dart';
import 'package:speezy_mobile/reading/presentation/widgets/storyWidget.dart';

import '../../../core/errors/failure.dart';
import '../../business/entities/ReadingEntity.dart';

class ReadingPage extends StatelessWidget {
  const ReadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReadingEntity? readingEntity = Provider.of<ReadingProvider>(context).story;
    Failure? failure = Provider.of<ReadingProvider>(context).failure;
    String? text =readingEntity?.story;
    return  Scaffold(
      body: Center(
        child:Column(
          children: [
            StoryWidget()
          ],
        ),
      ),
    );
  }
}
