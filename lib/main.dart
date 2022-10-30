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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Observer(builder: (_) {
                print('rebuilt');
                return ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 64, maxHeight: 128),
                  child: ChildWidget(
                    heartsList: controller.heartsList.toList(),
                  ),
                );
              }),
              const SizedBox(height: 24),
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 128, maxHeight: 256),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(onPressed: controller.add, child: const Text('Add')),
                    ElevatedButton(onPressed: controller.remove, child: const Text('Remove')),
                    ElevatedButton(
                      child: const Text('Show dialog'),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                title: Text('Alert'),
                                content: Text('Hello world'),
                              );
                            });
                      },
                    ),
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

class ChildWidget extends StatelessWidget {
  const ChildWidget({super.key, required this.heartsList});
  final List<String> heartsList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: heartsList.length,
        itemBuilder: (context, index) {
          return LimitedBox(
            maxWidth: 112,
            child: DecoratedBox(
              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              child: ListTile(
                title: Text(heartsList[index]),
              ),
            ),
          );
        });
  }
}
