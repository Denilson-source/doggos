import 'package:flutter/material.dart';

class CustomError extends StatelessWidget {
  final String error;
  final void Function()? action;
  final String? actionLabel;

  CustomError({required this.error})
      : this.action = null,
        this.actionLabel = null;

  CustomError.withAction({
    required this.error,
    required this.actionLabel,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error),
            if (action != null) ...[
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: action,
                child: Text(actionLabel!),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
