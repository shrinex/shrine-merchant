/*
 * Created by Archer on 2023/5/14.
 * Copyright © 2023 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:flutter/material.dart';

class Reminder extends StatelessWidget {
  final String message;

  const Reminder(
    this.message, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFEF0F0),
        border: Border.all(
          color: const Color(0xFFF56C6C),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Text(
        message,
        style: const TextStyle(
          color: Color(0xFFF56C6C),
        ),
      ),
    );
  }
}
