import 'package:flutter/material.dart';

import 'package:flutter_native_spinner/flutter_native_spinner.dart';

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
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text('Flutter'),
                    CircularProgressIndicator(),
                    CircularProgressIndicator(
                      value: 0.5,
                      backgroundColor: Colors.amber,
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text('Native'),
                    SizedBox(
                      height: 100,
                      child: NativeCircularProgressIndicator(),
                    ),
                    SizedBox(
                      height: 100,
                      child: NativeCircularProgressIndicator(
                        value: 0.5,
                        backgroundColor: Colors.amber,
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: NativeLinearProgressIndicator(
                        backgroundColor: Colors.amber,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
