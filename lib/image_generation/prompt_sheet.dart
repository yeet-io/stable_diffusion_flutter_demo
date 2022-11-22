import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'form_bloc.dart';

class PromptSheet extends StatelessWidget {
  const PromptSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var formBloc = context.read<ImageGenerationFormBloc>();
    var bottomHeight = MediaQuery.of(context).padding.bottom;

    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: TextFieldBlocBuilder(
            textFieldBloc: formBloc.prompt,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 3,
            suffixButton: SuffixButton.clearText,
            decoration: const InputDecoration(
              hintText: 'Describe image here...',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          margin: EdgeInsets.only(bottom: bottomHeight),
          height: 50,
          child: ElevatedButton.icon(
            onPressed: formBloc.submit,
            label: const Text(
              'Generate Image',
              style: TextStyle(fontSize: 20),
            ),
            icon: const Icon(Icons.draw),
          ),
        ),
      ],
    );
  }
}
