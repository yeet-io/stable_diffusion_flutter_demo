import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'image_bloc.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageBloc, Image?>(
      builder: (context, image) => Container(
        color: Colors.grey,
        width: double.infinity,
        height: double.infinity,
        child: image ??
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(
                  Icons.image,
                  size: 100,
                )
              ],
            ),
      ),
    );
  }
}
