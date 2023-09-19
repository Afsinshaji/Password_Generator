
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/password_generator.dart';
import '../screen_password_generator.dart';

class RadioBoxWidget extends ConsumerStatefulWidget {
  const RadioBoxWidget({
    super.key,
    required this.checkName,
    required this.textController,
    required this.ref,
    required this.checkValue,
  });
  final String checkName;
  final TextEditingController textController;
  final WidgetRef ref;
  final CheckList checkValue;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RadioBoxWidgetState();
}

class _RadioBoxWidgetState extends ConsumerState<RadioBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.checkName,
            style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 19,
                color: Colors.black),
          ),
          Radio(
              activeColor: Colors.red,
              groupValue: widget.ref.watch(checkListProvider),
              value: widget.checkValue,
              onChanged: (value) {
          
                widget.ref.read(checkListProvider.notifier).state = value!;
           
                PasswordGeneratorRiverpod().createPassword(value,
                    widget.ref.watch(passwordLengthProvider), widget.ref);
              })
        ],
      ),
    );
  }
}