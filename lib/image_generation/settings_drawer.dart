import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:intl/intl.dart';

import 'form_bloc.dart';

String formatNumber(BuildContext ctx, double value) {
  return NumberFormat('###,###').format(value);
}

class SliderValueText extends StatelessWidget {
  const SliderValueText(
      {super.key, required InputFieldBloc<double, dynamic> bloc, String? unit})
      : _bloc = bloc,
        _unit = unit;

  final InputFieldBloc<double, dynamic> _bloc;
  final String? _unit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InputFieldBloc<double, dynamic>,
        InputFieldBlocState<double, dynamic>>(
      bloc: _bloc,
      builder: (context, state) {
        var formatter = NumberFormat('###,###');
        String text = formatter.format(state.value);

        if (_unit != null) text += ' $_unit';

        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 0, 8),
          child: Text(
            text,
            textAlign: TextAlign.end,
          ),
        );
      },
    );
  }
}

class SettingsSlider extends StatelessWidget {
  const SettingsSlider({
    super.key,
    required this.bloc,
    required this.min,
    required this.max,
    required this.label,
    this.description,
    this.unit,
    this.divisions,
  });

  @override
  Widget build(BuildContext context) {
    return SliderFieldBlocBuilder(
      inputFieldBloc: bloc,
      min: min,
      max: max,
      divisions: divisions ?? (max - min).toInt(),
      labelBuilder: _formatValue,
      decoration: InputDecoration(
        labelText: label,
        helperText: description,
        helperMaxLines: 3,
        counter: SliderValueText(bloc: bloc, unit: unit),
      ),
    );
  }

  String _formatValue(BuildContext _, double value) {
    return NumberFormat('###,###').format(value);
  }

  final InputFieldBloc<double, dynamic> bloc;
  final double min;
  final double max;
  final int? divisions;
  final String label;
  final String? description;
  final String? unit;
}

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<ImageGenerationFormBloc>();
    return Drawer(
      width: double.infinity,
      child: Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            SettingsSlider(
              bloc: formBloc.width,
              min: 512,
              max: 1024,
              divisions: 8,
              label: 'Width',
              description: 'The width of the generated image.',
              unit: 'px',
            ),
            SettingsSlider(
              bloc: formBloc.height,
              min: 512,
              max: 1024,
              divisions: 8,
              label: 'Height',
              description: 'The height of the generated image.',
              unit: 'px',
            ),
            SettingsSlider(
              bloc: formBloc.samples,
              min: 0,
              max: 20,
              label: 'Cfg Scale',
              description:
                  'Cfg scale adjusts how much the image will be like your prompt. Higher values keep your image closer to your prompt.',
            ),
            SettingsSlider(
              bloc: formBloc.steps,
              min: 35,
              max: 150,
              label: 'Steps',
              description:
                  'How many steps to spend generating (diffusing) your image.',
            ),
          ]),
        ),
      ),
    );
  }
}
