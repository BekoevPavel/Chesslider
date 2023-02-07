import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chesslider_beta0/resources/sockets_connecter.dart';

class ConnectedScreen extends StatefulWidget {
  const ConnectedScreen({Key? key}) : super(key: key);

  @override
  State<ConnectedScreen> createState() => _ConnectedScreenState();
}

class _ConnectedScreenState extends State<ConnectedScreen> {
  TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TCP'),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                  height: 40,
                  width: 100,
                  child: TextField(
                    controller: _inputController,
                  )),
              ElevatedButton(onPressed: () {
                SocketsConnector.connectToServer();
              }, child: const Text('connect')),
              const Divider(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    SocketsConnector.startServer();
                  },
                  child: const Text('Start server')),
              SelectableText('Comy here'),
            ],
          ),
        ),
      ),
    );
  }
}
