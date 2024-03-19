import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routefly/routefly.dart';
import 'package:sermoes_wmb_flutter/app/pdf/pdf_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PdfProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
            title: Text(
              value.currentData.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 15.0),
            ),
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
        body: SfPdfViewer.network(value.currentData.pdf),
      ),
    );
  }
}
