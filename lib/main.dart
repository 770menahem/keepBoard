import 'package:flutter/material.dart';
import 'package:keepboard/AddNoitesDialog.dart';
import 'package:keepboard/Notice.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        SizedBox(width: 20),
        Text(
          'לוח המודעות של חבד',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ]),
      body: SingleChildScrollView(
        child: Center(
          child: Wrap(
            children: [...notices.map((e) => e.asWidget()).toList()],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addForm(context, (Notice notice) {
          setState(() {
            notices.add(notice);
          });
        }),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
