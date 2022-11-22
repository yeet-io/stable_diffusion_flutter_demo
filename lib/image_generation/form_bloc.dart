import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:stability_ai/stability_ai.dart';
import 'package:collection/collection.dart';

import 'stable_diffusion_repository.dart';

class ImageGenerationFormBloc extends FormBloc<Image, Exception> {
  static final repo = StableDiffusionRepository();

  final prompt = TextFieldBloc(validators: [FieldBlocValidators.required]);
  final width = InputFieldBloc<double, dynamic>(initialValue: 512);
  final height = InputFieldBloc<double, dynamic>(initialValue: 512);
  final samples = InputFieldBloc<double, dynamic>(initialValue: 7);
  final steps = InputFieldBloc<double, dynamic>(initialValue: 50);

  ImageGenerationFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        prompt,
        width,
        height,
        samples,
        steps,
      ],
    );
  }

  @override
  void onSubmitting() async {
    var response = repo.generateImageFromText(
      prompt.value,
      width: width.value.toInt(),
      height: height.value.toInt(),
      samples: samples.value.toInt(),
      steps: steps.value.toInt(),
    );

    try {
      var err = await response.forEach((answer) {
        // do we have an image?
        var artifact = answer.artifacts.firstWhereOrNull(
          (artifact) => artifact.type == ArtifactType.ARTIFACT_IMAGE,
        );

        // print(answer);

        if (artifact != null) {
          var imageData = Uint8List.fromList(artifact.binary);
          var image = Image.memory(imageData);

          emitSuccess(
            successResponse: image,
            canSubmitAgain: true,
            isEditing: false,
          );
        }
      });

      if (err is Exception) {
        emitFailure(failureResponse: err);
      }
    } on GrpcError catch (e) {
      emitFailure(failureResponse: e);
    }
  }
}
