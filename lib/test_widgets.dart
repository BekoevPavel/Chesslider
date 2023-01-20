import 'package:flutter/material.dart';

class TestWidgetsPage extends StatefulWidget {
  const TestWidgetsPage({super.key});

  @override
  State<TestWidgetsPage> createState() => _TestWidgetsPageState();
}

class _TestWidgetsPageState extends State<TestWidgetsPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  count++;
                  setState(() {});
                },
                child: const Text('click1')),

            FirstWidget(),
            //SecondWidget1()
            //SecondWidget()
          ],
        ),
      ),
    );
  }
}

class SecondWidget extends StatelessWidget {
  SecondWidget({super.key});

  final int a = 0;
  final SecondWidget1 cecond = const SecondWidget1();

  //final FirstWidget firstW = FirstWidget();

  @override
  Widget build(BuildContext context) {
    print('build SecondWidget');
    return Container();
  }
}

class FirstWidget extends StatefulWidget {
  FirstWidget({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  State<FirstWidget> createState() {
    return _FirstWidgetState();
  }
}

class _FirstWidgetState extends State<FirstWidget> {
  int param = 0;

  @override
  void initState() {
    print('init');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Build stateFull');
    return Row(
      children: [
        Text('Result: ${param}'),
        ElevatedButton(
            onPressed: () {
              param++;
              // setState(() {});
            },
            child: const Text('click'))
      ],
    );
  }
}

class SecondWidget1 extends StatelessWidget {
  const SecondWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: () {}, child: const Text('cc')),
        const Text('res: ')
      ],
    );
  }
}

// у всех виджетов по умолчанию при перестроении вызывается только build
//SteteFull(child:
// StateFul(key: key) — если вызвать у верхнего setState у нижнего вызовется только build.
//созданные внутри _state переменные не изменятся
//чтобы полностью перестроить stateful widget нужно дать ему valueKey с разнымии значениями каждый раз когда перерисовываем
//если перед виджетом в дереве стоит const он не будет перерисовываться вообще прям
//)
