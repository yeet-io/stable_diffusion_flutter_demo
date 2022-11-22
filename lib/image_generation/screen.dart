import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'image_container.dart';
import 'settings_drawer.dart';
import 'prompt_sheet.dart';
import '../core/loading_dialog.dart';

import 'form_bloc.dart';
import 'image_bloc.dart';

class ImageGenerationScreen extends StatelessWidget {
  const ImageGenerationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => ImageBloc(null)),
      child: BlocProvider(
        create: (context) => ImageGenerationFormBloc(),
        child: FormBlocListener<ImageGenerationFormBloc, Image, Exception>(
          onSubmitting: (context, state) {
            LoadingDialog.show(context);
          },
          onSubmissionFailed: (context, state) {
            LoadingDialog.hide(context);
          },
          onSuccess: (context, state) {
            var imageBloc = context.read<ImageBloc>();
            imageBloc.add(ImageLoadedEvent(state.successResponse!));
            LoadingDialog.hide(context);
          },
          onFailure: (context, state) {
            LoadingDialog.hide(context);

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.failureResponse?.toString() ??
                    "Something went wrong! :(")));
          },
          child: Scaffold(
            appBar: AppBar(title: const Text('Text To Image')),
            endDrawer: const SettingsDrawer(),
            body: Column(
              children: const <Widget>[
                Expanded(
                  child: ImageContainer(),
                ),
                PromptSheet(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
