import 'package:flutter/material.dart';

class IncrementButton extends StatelessWidget {
  const IncrementButton({Key? key, required void Function()? onPressed})
      : _incrementCounter = onPressed,
        super(key: key);

  final void Function()? _incrementCounter;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _incrementCounter,
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}
