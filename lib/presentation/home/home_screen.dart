import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(toolbarHeight: 40, title: const Text('Chesslider'),
            //leading: IconButton(onPressed: () {}, icon: const Icon(Icons.chat)),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.logout))
            ]),
        body: Column(
          children: [const Text('Helo')],
        ));
  }
}
