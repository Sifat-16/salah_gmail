import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ImageUpload(),
    );
  }
}

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  @override
  bool isUploading = false;
  File? imageAvatar;
  final _picker = ImagePicker();
  File? _selectedFile;

  _selectSource(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    _selectImage(ImageSource.camera, context);
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('Camera'),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    //print("MYACC AVATAR ${baseUrl + box.read(userAvatar).toString()}");
                    _selectImage(ImageSource.gallery, context);
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('Gallery'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _selectImage(ImageSource imageSource, BuildContext context)async{
    try{
      final pickedFile = await _picker.pickImage(source: imageSource);
      _selectedFile = File(pickedFile!.path);
      print(_selectedFile!.path);
      setState(() {

      });

    }catch(e){

    }
  }


  _uploadImage() async {
    setState(
          () {
        isUploading = true;
      },
    );
    try {


      if (_selectedFile == null) return;
      if (!mounted) return;

      if (_selectedFile != null) {
        //box.write(avatarBytes, _selectedFile!.path);
        var request = http.MultipartRequest('POST', Uri.parse('http://116.68.198.178/neways_employee_mobile_application/v1/api/send'));
        //request.headers.addAll({'Accept': 'application/json', 'Authorization': 'Bearer ${box.read(userToken)}'});

        request.files.add(await http.MultipartFile.fromPath(
          "image",
          _selectedFile!.path,
          filename: _selectedFile!.path.split('/').last,
          // contentType:new http.MediaType()
        ));

        request.fields["filename"] = _selectedFile!.path.split('/').last;
        //request.fields["id"] = box.read(userID).toString();

        request.send().then((value) {
          //rint(value.);
          value.stream.transform(utf8.decoder).listen((event) {
            print(event);
            var res = jsonDecode(event);
            print(res["file_path"]);
          });

          print(value.statusCode);

          setState(
                () {
              isUploading = false;
            },
          );
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }


  Widget build(BuildContext context) {
    return  Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: 50,),

            CircleAvatar(
              radius: 50,
              //backgroundColor: Color(0xFF515151),
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      //color: Colors.white,
                      height: 120,
                      width: 120,

                      decoration: _selectedFile != null
                          ? BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(_selectedFile as File),
                        ),
                      ):BoxDecoration(
                        image: DecorationImage(image: NetworkImage("https://staticg.sportskeeda.com/editor/2022/05/e95df-16540155209606-1920.jpg"))
                      )
                      /*
                      BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(imageAvatar),
                              ),
                            )
                       */
                          
                          
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: isUploading
                          ? CircularProgressIndicator()
                          : InkWell(
                        onTap: () => _selectSource(context),
                        child: CircleAvatar(
                          radius: 18,
                          child: Icon(Icons.camera_alt),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(height: 20,),
            TextButton(onPressed: (){
              _uploadImage();
            }, child: Text("Upload"))


          ],
        ),
      ),

    );
  }
}





// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:gmail/sign_up.dart';
//
// import 'message_screen.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   var userEmailController = TextEditingController();
//   var userPassController = TextEditingController();
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//
//   Future<SignupResponse> getSignupResponse(@required String name, @required String emailOrPhone, @required String password,
//       @required String passowrdConfirmation, @required String registerBy) async {
//     var postBody = jsonEncode({
//       "name": "$name",
//       "email_or_phone": "${emailOrPhone}",
//       "password": "$password",
//       "password_confirmation": "${passowrdConfirmation}",
//       "register_by": "$registerBy"
//     });
//
//     final response = await http.post(Uri.parse(userSignupAPI), headers: {"Content-Type": "application/json"}, body: postBody);
//
//     log(response.body);
//
//     //
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       var dataMap = jsonDecode(response.body);
//
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => SignInPage(
//             isFromCart: widget.isFromCart,
//           ),
//         ),
//       );
//
//       //showToast(dataMap["message"], context: context);
//       //Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryHomeScreen()));
//
//       ///print(box.read('userName'));
//       ///log(userDataModel.user.name);
//
//       setState(() {});
//     }
//     //
//
//     return signupResponseFromJson(response.body.toString());
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//
//         title: Text(widget.title),
//       ),
//       body:  Center(
//
//         child: Column(
//
//           //mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(height: 20,),
//             Text(
//               'First Screen',style: TextStyle(fontSize: 25),
//             ),
//             SizedBox(height: 50,),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 30.0),
//               child: TextFormField(
//                 autofocus: false,
//                 controller: userEmailController,
//                 validator: (String? value) {
//                   if (value!.isEmpty) {
//                     return "Email must not be empty";
//                   }
//                 },
//                 decoration: InputDecoration(
//                   fillColor: Colors.grey[100],
//                   filled: true,
//                   contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                   enabledBorder:
//                   OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
//                   focusedBorder:
//                   OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
//                   hintText: "email or phone",
//                 ),
//               ),
//             ),
//
//             SizedBox(height: 20,),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30.0),
//               child: TextFormField(
//                 autofocus: false,
//                 obscureText: true,
//                 enableSuggestions: false,
//                 autocorrect: false,
//                 controller: userPassController,
//                 validator: (String? value) {
//                   if (value!.isEmpty) {
//                     return "Password must not be empty";
//                   }
//                 },
//                 decoration: InputDecoration(
//                     fillColor: Colors.grey[100],
//                     filled: true,
//                     contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                     enabledBorder:
//                     OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
//                     focusedBorder:
//                     OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
//                     hintText: "password"),
//               ),
//             ),
//
//             SizedBox(height: 20,),
//             SizedBox(
//               width: MediaQuery.of(context).size.width / 1.2,
//               height: 50,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Don't have an account?  ",
//                     style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
//                     },
//                     child: Text(
//                       " Sign Up",
//                       style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: "ceraProMedium"),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//
//             SizedBox(height: 50,),
//
//             Padding(
//               padding: const EdgeInsets.only(top: 30.0),
//               child: Container(
//                 width: 90,
//                 height: 47,
//                 decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black, width: 1), borderRadius: BorderRadius.all(Radius.circular(30.0))),
//                 child: FloatingActionButton(
//                   //minWidth: MediaQuery.of(context).size.width,
//                   //height: 50,
//                   //color: MyTheme.accent_color,
//                   shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(5.0))),
//                   child: Text(
//                     "Go",
//                     style: TextStyle(color: Colors.black, fontSize: 23, fontWeight: FontWeight.w600, fontFamily: "ceraProMedium"),
//                   ),
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => MessageScreen()));
//                     //onPressSignUp();
//                     // getSignupResponse(_nameController.text, _emailController.text, _passwordController.text,
//                     //     _passwordConfirmController.text, _register_by);
//
//                     /*
//                       if (formKey.currentState == null || formKey.currentState!.validate()) {
//                       userSignUp(userNameController.text, userEmailOrPhoneController.text, userPasswordController.text);
//
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
//                     }
//                        */
//                   },
//                 ),
//               ),
//             ),
//
//           ],
//         ),
//       ),
//
//     );
//   }
// }
