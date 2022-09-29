import 'package:flutter/material.dart';

class infoP extends StatelessWidget {
  const infoP({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stateless page"),
      ),
      body: Center(child: Text("INFORMACIÓN")),
    );
  }
}