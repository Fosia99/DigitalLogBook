import 'package:flutter/material.dart';
import 'pdf_api.dart';
import 'pdf_paragraph_api.dart';

import '/widgets/button_widget.dart';

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(

      centerTitle: true,
    ),
    body: Container(
      padding: EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ButtonWidget(
              text: 'Simple PDF',
              onClicked: () async {
                final pdfFile =
                await PdfApi.generateCenteredText('Sample Text');

                PdfApi.openFile(pdfFile);
              },
            ),
            const SizedBox(height: 24),
            ButtonWidget(
              text: 'Paragraphs PDF',
              onClicked: () async {
                final pdfFile = await PdfParagraphApi.generate();

                PdfApi.openFile(pdfFile);
              },
            ),
          ],
        ),
      ),
    ),
  );
}