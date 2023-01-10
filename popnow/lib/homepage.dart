import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
           decoration:const  BoxDecoration(
            image: DecorationImage(
            image: AssetImage('assets/images/bg4.jpg'),
            fit: BoxFit.cover,
            )
           ),
        ),
      ),
    );
  }
}
