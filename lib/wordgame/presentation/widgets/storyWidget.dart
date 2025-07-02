import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../business/entities/wordEntity.dart';

import '../../../core/errors/failure.dart';
import '../providers/word_provider.dart';

class WordWidget extends StatelessWidget {
  OverlayEntry? _overlayEntry;


  @override
  Widget build(BuildContext context) {
    Wordentity? wordEntity = Provider
        .of<WordProvider>(context)
        .words;
    Failure? failure = Provider
        .of<WordProvider>(context)
        .failure;
    List<dynamic>? words = wordEntity?.words;


    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
        child: Column(
          children: [
            if (words != null) ...[
              Text(words[0][0]['text'])


            ] else
              if (failure != null) ...[

              ] else
                ...[



                ],
          ],
        ),
      ),
    );
  }

}