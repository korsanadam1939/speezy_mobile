import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speezy_mobile/roleanswer/business/entities/AnswerEntity.dart';
import 'package:speezy_mobile/widgets/Loading_widget.dart';
import 'package:speezy_mobile/widgets/speezy_button.dart';

import '../providers/answer_provider.dart';
import '../../../core/errors/failure.dart';

class AnswerWidget extends StatefulWidget {
  final String sentence;

  AnswerWidget(this.sentence);

  @override
  State<AnswerWidget> createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  OverlayEntry? _overlayEntry;
  bool istrusentence = true;

  @override
  Widget build(BuildContext context) {
    AnswerEntity? answer = Provider.of<AnswerProvider>(context).answer;
    Failure? failure = Provider.of<AnswerProvider>(context).failure;

    List<String> words = widget.sentence.split(" ");

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
      child: Column(
        children: [
          if (answer != null) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  answer.encouragement,
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                if (answer.has_mistake_boolean == true) ...[
                  istrusentence
                      ? buildColoredText(
                      widget.sentence, answer.mistake.split(" "))
                      : Text(
                    answer.correction,
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  )
                ] else ...[
                  Text(
                    widget.sentence,
                    style: TextStyle(color: Colors.green, fontSize: 19),
                  )
                ],
                answer.has_mistake_boolean
                    ? GestureDetector(
                  onTap: () {
                    setState(() {
                      istrusentence = !istrusentence;
                    });
                  },
                  child: Text(
                    istrusentence
                        ? "doğrusunu gör"
                        : "yanlışlı cümleyi gör",
                    style:
                    TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                )
                    : Text(""),
              ],
            )
          ] else if (failure != null) ...[
            Center(
              child: Text(
                failure.errorMessage,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ] else ...[
            Center(child: LoadingWidget()),
          ],
        ],
      ),
    );
  }

  RichText buildColoredText(String text, List<String> highlightWords) {
    List<String> words = text.split(" ");

    return RichText(
      text: TextSpan(
        children: words.map((word) {
          bool shouldHighlight = highlightWords.any((highlight) => word.contains(highlight));
          return TextSpan(
            text: "$word ",
            style: TextStyle(
              color: shouldHighlight ? Colors.redAccent : Colors.black,
              fontSize: 20,
            ),
          );
        }).toList(),
      ),
    );
  }
}
