import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/count_provider.dart';




class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
print('build');
    return Scaffold(
      appBar: AppBar(),
        body: SafeArea(
          child: Consumer(
            builder: (context, ref, child) {
              final per = ref.watch(personName);
              final n = ref.watch(countProvider).number;
            final c = ref.watch(count);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$c', style: TextStyle(fontSize: 50),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                         ref.read(count.notifier).state++;

                          }, child: Text('Add')),
                      TextButton(onPressed: () {
                        ref.read(countProvider).decrement();

                      }, child: Text('Minus')),
                    ],
                  )
                ],
              );
            }
          ),
        )
    );
  }
}
