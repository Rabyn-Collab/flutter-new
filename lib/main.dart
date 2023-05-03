import 'package:flutter/material.dart';
import 'package:flutternew/provider/count_provider.dart';
import 'package:flutternew/view/home_page.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main (){


 runApp(ProviderScope(child: Home()));

}

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      // theme: ThemeData(
      //   appBarTheme: AppBarTheme(
      //     backgroundColor: Colors.amber
      //   )
      // ),
   debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}


class Count extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(),
        body: Consumer(
          builder: (context, ref, child) {
            final m = ref.watch(count);
            return ListView(
              children: [
                Center(child: Text('$m', style: TextStyle(fontSize: 50),)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          ref.read(count.notifier).state++;
                        }, child: Text('add')),
                    TextButton(onPressed: () {

                    }, child: Text('decre')),
                  ],
                )
              ],
            );
          }
        )
    );
  }
}
