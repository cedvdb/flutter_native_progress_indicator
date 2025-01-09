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
  double progress = 0.5;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.orange, brightness: Brightness.dark),
      ),
      themeMode: ThemeMode.dark,
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
              title: Text(
            'Native progress indicators',
            style: TextStyle(color: Theme.of(context).primaryColor),
          )),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 400,
                child: Column(
                  spacing: 8,
                  children: [
                    Row(
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
                                value: progress,
                              ),
                              LinearProgressIndicator(),
                              LinearProgressIndicator(
                                value: progress,
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
                                value: progress,
                              ),
                              NativeLinearProgressIndicator(),
                              NativeLinearProgressIndicator(
                                value: progress,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: progress,
                      onChanged: (newValue) =>
                          setState(() => progress = newValue),
                      min: 0,
                      max: 1,
                    ),
                    Text(progress.toString())
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
