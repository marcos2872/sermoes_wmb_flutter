import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: TextButton(
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Color.fromRGBO(255, 255, 255, 100),
            ),
            onPressed: () {
              Routefly.pop(context);
            },
          )),
      body: const SafeArea(
          child: Column(
        children: [],
      )),
    );
  }
}