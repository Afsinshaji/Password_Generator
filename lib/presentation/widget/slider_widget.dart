import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/password_generator.dart';

class SliderWidget extends ConsumerStatefulWidget {
  const SliderWidget({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends ConsumerState<SliderWidget> {
  int sliderValue = 8;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:15.0,right:15.0,bottom:10.0),
      child: Row(
        children: [
          Expanded(
            child: Slider(
              thumbColor: Colors.red,
              activeColor: Colors.red,
              value: widget.ref.watch(passwordLengthProvider).toDouble(),
              onChanged: (value) {
                widget.ref.read(passwordLengthProvider.notifier).state =
                    value.toInt();
              },
              onChangeEnd: (value) {
                PasswordGeneratorRiverpod().createPassword(
                    widget.ref.watch(checkListProvider),
                    value.toInt(),
                    widget.ref);
              },
              min: 1,
              max: 50,
            ),
          ),
          Text(
            widget.ref.watch(passwordLengthProvider).toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black),
          ),
        ],
      ),
    );
  }
}