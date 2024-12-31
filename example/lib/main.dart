import 'package:flutter/material.dart';
import 'package:native_progress_indicator/native_progress_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(
          child: SizedBox(
            width: 400,
            child: Row(
              spacing: 8,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    spacing: 8,
                    children: [
                      Text('Flutter'),
                      CircularProgressIndicator(),
                      CircularProgressIndicator(
                        value: 0.5,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                      ),
                      LinearProgressIndicator(),
                      LinearProgressIndicator(
                        value: 0.7,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    spacing: 8,
                    children: [
                      Text('Native'),
                      NativeCircularProgressIndicator(),
                      NativeCircularProgressIndicator(
                        value: 0.5,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                      ),
                      NativeLinearProgressIndicator(),
                      NativeLinearProgressIndicator(
                        value: 0.7,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
