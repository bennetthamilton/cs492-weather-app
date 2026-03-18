import 'package:flutter/material.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({
    super.key,
    required this.description,
    required this.callbackFunction,
  });

  final String description;
  final void Function() callbackFunction;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 44),
      child: ElevatedButton(
        onPressed: callbackFunction,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(description),
        ),
      ),
    );
  }
}
