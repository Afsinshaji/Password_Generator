import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_generator/application/password_generator.dart';
import 'package:password_generator/presentation/widget/radio_box_widget.dart';
import 'package:password_generator/presentation/widget/slider_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum CheckList { easy, medium, hard }

class PasswordGeneratorScreen extends ConsumerWidget {
  PasswordGeneratorScreen({super.key});
  final textEditingController = TextEditingController(
      text:
          PasswordGeneratorRiverpod().createPassword(CheckList.easy, 8, null));

  final ValueNotifier selectedCheckBox = ValueNotifier(0);
  final checkList = [CheckList.easy, CheckList.medium, CheckList.hard];
  final checkNameList = ['Easy', 'Medium', 'Hard'];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('Building');
    ref.listen(
      passwordProvider,
      (previous, next) {
        textEditingController.text = next;
      },
    );
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        titleSpacing: 110,
        backgroundColor: Colors.red,
        title: const Text(
          'your Pass...🤫',
          style: TextStyle(
              fontFamily: 'Times',
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: Text(
              'Customize your Password',
              style: TextStyle(
                  fontFamily: 'Times',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [BoxShadow()]),
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                suffix: IconButton(
                    onPressed: () {
                      PasswordGeneratorRiverpod().createPassword(
                          ref.watch(checkListProvider),
                          ref.watch(passwordLengthProvider),
                          ref);
                    },
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.red,
                      size: 30,
                    )),
              ),
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black, fontSize: 22),
              controller: textEditingController,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: Text(
              'Password Length',
              style: TextStyle(
                  fontFamily: 'Times',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black),
            ),
          ),
          SliderWidget(ref: ref),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  checkList.length,
                  (index) => RadioBoxWidget(
                        checkName: checkNameList[index],
                        textController: textEditingController,
                        ref: ref,
                        checkValue: checkList[index],
                      )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(Colors.red),
                  elevation: const MaterialStatePropertyAll(5),
                  shadowColor: const MaterialStatePropertyAll(Colors.black),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)))),
              onPressed: () async {
                await Clipboard.setData(
                        ClipboardData(text: textEditingController.text))
                    .then((value) {
                  Fluttertoast.showToast(msg: 'password has copied to clipboard');
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Copy Password',
                  style: TextStyle(
                      fontFamily: 'Times',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
