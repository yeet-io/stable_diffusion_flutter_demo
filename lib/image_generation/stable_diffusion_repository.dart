import 'package:stability_ai/stability_ai.dart';
import 'package:uuid/uuid.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StableDiffusionRepository {
  final StabilityAIClient _client;

  StableDiffusionRepository()
      : _client = StabilityAIClient(dotenv.env['STABILITY_API_KEY']!);

  ResponseStream<Answer> generateImageFromText(String prompt,
      {int? width, int? height, int? samples, int? steps}) {
    return _client.generation.generate(Request(
      engineId: 'stable-diffusion-v1-5',
      requestId: const Uuid().v4(),
      requestedType: ArtifactType.ARTIFACT_IMAGE,
      prompt: [Prompt(text: prompt)],
      image: ImageParameters(
        width: (width != null ? Int64(width) : null),
        height: (height != null ? Int64(height) : null),
        samples: (samples != null ? Int64(samples) : null),
        steps: (steps != null ? Int64(steps) : null),
      ),
    ));
  }
}
