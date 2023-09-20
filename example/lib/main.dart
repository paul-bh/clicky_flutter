// example main page
import 'package:clicky_flutter/styles.dart';
import 'package:flutter/material.dart';

import 'package:clicky_flutter/clicky_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clicky Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Clicky Flutter Demo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return Clicky(
                      clickyColor: Colors.black.withOpacity(0.07),
                      clickyShrinkRatio: 0.02,
                      clickyBorderRadius: 10,
                      clickyTouchBoundStyles: TouchBoundStyles.byInitialTouchPoint,
                      child: ListTile(
                        title: Text('ListTile can have effects too $index'),
                        subtitle: Text('Option $index'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                    );
                  },
                ),
              ),
              Clicky(
                clickyColor: Colors.black.withOpacity(0.0),
                clickyShrinkRatio: 0.04,
                clickyBorderRadius: 10,
                clickyTouchBoundStyles: TouchBoundStyles.byContextSize,
                child: Container(
                  width: double.infinity,
                  height: 75,
                  child: ElevatedButton(
                    // disable ripple effect
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                      shadowColor: MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {},
                    child: Text('Go!', style: TextStyle(fontSize: 30)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
