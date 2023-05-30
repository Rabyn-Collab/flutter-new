import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/provider/auth_provider.dart';




class HomePage extends ConsumerWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final authData = FirebaseAuth.instance.currentUser;
    return Scaffold(
      drawer: Drawer(
       child: ListView(
         children: [
           ListTile(
             onTap: (){
               Navigator.of(context).pop();
               ref.read(authProvider.notifier).userLogOut();
             },
             leading: Icon(Icons.exit_to_app),
             title: Text('Log Out'),
           )
         ],
       ),
      ),
      appBar: AppBar(
        title: Text('Social App'),
      ),
        body: const Placeholder()
    );
  }
}
