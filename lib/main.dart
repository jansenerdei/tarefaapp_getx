import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tarefas_getx_app/main_app.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}
