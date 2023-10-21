import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfPage extends StatelessWidget {
   PdfPage({Key? key,required this.pdfUrl ,required this.title}) : super(key: key);
   String pdfUrl;
   String title;


  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    print(pdfUrl);
    return  Scaffold(
       appBar: AppBar(
         title: Text(
           title
         ),
       ),
      body: Container(
        height:deviceSize.height ,
        child:
        SfPdfViewer.network(
          pdfUrl.trim()
           ),
      ),
    );
  }
}
