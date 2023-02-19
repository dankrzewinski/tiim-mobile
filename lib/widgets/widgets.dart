
import 'package:flutter/material.dart';
import 'package:app/services/connector.dart';

FloatingActionButton getLogoutButton(BuildContext context) {
  return FloatingActionButton(
    heroTag: "floatLogin",
    onPressed: () {
      storage.delete(key: "token");
      Navigator.pushReplacementNamed(context, 'login');
    },
    child: const Icon(Icons.logout_rounded),
  );
}

FloatingActionButton getAddButton(BuildContext context) {
  return FloatingActionButton(
    heroTag: "floatAdd",
    onPressed: () {
      Navigator.pushNamed(context, 'add_car');
    },
    child: const Icon(Icons.add),
  );
}

TextStyle getTextStyleBold20() {
  return const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
}

TextStyle getTextStyleButton25() {
  return const TextStyle(color: Colors.white, fontSize: 25);
}

TextStyle getTextStyleButton15() {
  return const TextStyle(color: Colors.white, fontSize: 15);
}