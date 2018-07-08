import 'package:flutter/material.dart';
import 'CustomAlert.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'AlertDialog app',
      theme: ThemeData(
        primarySwatch: Colors.green,

      ),
      home: new MyHomePage(title: 'AlertDialog app'),
    );
  }
} //

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScaffoldState> _scaffold = GlobalKey();
  TextEditingController _inputTextController;

  _onSubmit(message) {
    if (message.isNotEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            title: Center(child: Text('Alert')),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children : <Widget>[
                Expanded(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,

                    ),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    _inputTextController.clear();
                    Navigator.of(context).pop();
                  })
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    _inputTextController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: _inputTextController,
            textAlign: TextAlign.center,
            onSubmitted: (String message) => _onSubmit(message),
            decoration: InputDecoration(hintText: 'Please enter dialog mesage'),
          ),
        ],
      ),
    );
  }
}
