import 'package:flutter/material.dart';
import 'package:flutternew/models/book.dart';


class DetailPage extends StatelessWidget {
  final Book book;
  DetailPage(this.book);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
           Image.network(book.imageUrl, height: 320,width: double.infinity, fit: BoxFit.fitWidth,),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(book.title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Text(book.rating),
                            TextButton(onPressed: (){}, child: Text(book.genre))
                          ],
                        ),
                      )
                    ],
                  ),

                  Text(book.detail, style: TextStyle(fontSize: 16, color: Colors.blueGrey),),
                  SizedBox(height: 70,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF007084),
                          minimumSize: Size(170, 54),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                          onPressed: (){

                          }, child: Text('Read Book')
                      ),
                      SizedBox(width: 20,),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              minimumSize: Size(170, 54),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                          onPressed: (){

                          }, child: Text('Read Book')
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        )
    );
  }
}
