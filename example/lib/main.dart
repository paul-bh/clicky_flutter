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
                      style: ClickyStyle(),
                      child: ListTile(
                        title: Text('ListTile can have effects too $index'),
                        subtitle: Text('Option $index'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Clicky(
                style: ClickyStyle(
                  color: Colors.transparent,
                  boundaryFromWidgetOutline: 10,
                ),
                child: Container(
                  width: double.infinity,
                  height: 75,
                  child: ElevatedButton(
                    // disable ripple effect
                    style: ButtonStyle(
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      shadowColor: WidgetStateProperty.all(Colors.transparent),
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
