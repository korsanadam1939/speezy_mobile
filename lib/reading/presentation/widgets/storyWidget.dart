import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speezy_mobile/reading/business/entities/ReadingEntity.dart';
import 'package:speezy_mobile/reading/presentation/providers/reading_provider.dart';
import '../../../../../core/errors/failure.dart';


class StoryWidget extends StatelessWidget {
  const StoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReadingEntity? story = Provider.of<ReadingProvider>(context).story;
    Failure? failure = Provider.of<ReadingProvider>(context).failure;
    String? text =story?.story;
    late Widget widget;
    if (story != null) {
      widget = Expanded(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(story.title),
                Text(
                  story.story,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      );
    }
    else if (failure != null) {
      widget = Expanded(
        child: Center(
          child: Text(
            failure.errorMessage,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      );
    } else {
      widget = const Expanded(
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            color: Colors.orangeAccent,
          ),
        ),
      );
    }
    return widget;
  }
}
