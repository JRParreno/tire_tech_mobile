import 'package:flutter/material.dart';

Future<void> commonBottomSheetDialog({
  required BuildContext context,
  required String title,
  required Widget container,
  VoidCallback? onClose,
}) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(10),
        height: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            container,
          ],
        ),
      );
    },
  );
}
