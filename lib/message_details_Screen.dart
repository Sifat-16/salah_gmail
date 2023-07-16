import 'package:flutter/material.dart';


class MessageDetailsScreen extends StatelessWidget {
  const MessageDetailsScreen();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Message Screen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DetailsScreen(title: 'Sign Up Page'),
    );
  }
}

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.title});

  final String title;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
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
              'Message Deatils Screen',style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 50,),

            Container(
              child: Text("Learn how to boost your writing skills with proper "
                  "paragraphing. Check out our blog today! There's more to paragraphing"
                  " than meets the eye! Become a better writer with this guide. Friendly,"
                  " Quick, Easy. Online Paraphrasing Tool. Quill"
                  " Paraphrasing Tool.",style: TextStyle(fontSize: 25),),
            )

          ],
        ),
      ),

    );
  }
}
