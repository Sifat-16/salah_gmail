import 'package:flutter/material.dart';

import 'message_details_Screen.dart';


class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Message Screen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MessageScreenPage(title: 'Sign Up Page'),
    );
  }
}

class MessageScreenPage extends StatefulWidget {
  const MessageScreenPage({super.key, required this.title});

  final String title;

  @override
  State<MessageScreenPage> createState() => _MyMessageScreenPageState();
}

class _MyMessageScreenPageState extends State<MessageScreenPage> {
  int _counter = 0;
  var userEmailController = TextEditingController();
  var userPassController = TextEditingController();
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body:  Center(

        child: Column(

          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20,),
            Text(
              'Message Screen',style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 50,),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Sender",style: TextStyle(fontSize: 25),),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MessageDetailsScreen()));
                      },
                      child: Container(child: Text("Gmail Subject",style: TextStyle(fontSize: 25),))),
                ],

              ),
            )

          ],
        ),
      ),

    );
  }
}
