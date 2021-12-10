import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';

class CoursePDFViewer extends StatefulWidget {
  const CoursePDFViewer({Key? key}) : super(key: key);

  @override
  _CoursePDFViewerState createState() => _CoursePDFViewerState();
}

class _CoursePDFViewerState extends State<CoursePDFViewer> {
  bool _isLoading = true;
  late PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromURL(
        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf');

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : PDFViewer(document: document, zoomSteps: 1),
    );
  }
}
