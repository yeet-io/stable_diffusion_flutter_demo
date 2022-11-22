import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) async {
    var scope = FocusScope.of(context);

    await showDialog<void>(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (_) => LoadingDialog(key: key),
    );

    scope.requestFocus(FocusNode());
  }

  static void hide(BuildContext context) => Navigator.pop(context);

  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(12.0),
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
