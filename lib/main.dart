import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_observablelist_bug_demo/controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(            
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MobX ObservableList Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Observer(builder: (_) {
              print('rebuilt');
              return SizedBox(
                width: 1024,
                height: 512,
                child: ChildWidget(
                  heartsList: controller.heartsList.value,
                ),
              );
            }),
            Row(
              children: [
                ElevatedButton(onPressed: controller.add, child: const Text('Add')),
                ElevatedButton(onPressed: controller.remove, child: const Text('Remove')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChildWidget extends StatelessWidget {
  const ChildWidget({super.key, required this.heartsList});
  final List<String> heartsList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: heartsList.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 112,
            height: 48,
            child: ListTile(
              title: Text(heartsList[index]),
            ),
          );
        });
  }
}
