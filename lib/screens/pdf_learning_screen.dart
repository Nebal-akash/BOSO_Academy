import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:nebal/services/api_service.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class PDFLearningScreen extends StatefulWidget {
  @override
  _PDFLearningScreenState createState() => _PDFLearningScreenState();
}

class _PDFLearningScreenState extends State<PDFLearningScreen> {
  File? _selectedFile;
  String? _summary;
  bool _isLoading = false;
  String? _errorMessage;

  /// Picks a PDF file from the device.z
  Future<void> _pickPDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
          _summary = null;
          _errorMessage = null;
        });
        print("Selected file path: ${_selectedFile!.path}");
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to pick PDF: ${e.toString()}";
      });
    }
  }

  /// Load a sample PDF from assets for testing
  Future<void> _loadSamplePDF() async {
    ByteData data = await rootBundle.load('assets/sample.pdf');
    List<int> bytes = data.buffer.asUint8List();
    String tempPath = '${(await getTemporaryDirectory()).path}/sample.pdf';
    File tempFile = File(tempPath);
    await tempFile.writeAsBytes(bytes);

    setState(() {
      _selectedFile = tempFile;
    });
  }

  /// Sends the selected PDF to the backend for summarization.
  Future<void> _summarizePDF() async {
    if (_selectedFile == null) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      if (!await _selectedFile!.exists()) {
        throw Exception("File does not exist.");
      }
      String summary = await APIService.summarizePDF(_selectedFile!.path);
      setState(() {
        _summary = summary;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to summarize PDF: ${e.toString()}";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: Row(
              children: [
                _buildPDFViewer(),
                _buildContentPanel(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Sidebar with navigation options
  Widget _buildSidebar() {
    return Container(
      width: 250,
      color: Colors.grey[900],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          _buildSidebarHeader(),
          Divider(color: Colors.white24),
          _buildSidebarItem(Icons.upload_file, "Upload PDF", _pickPDF),
          _buildSidebarItem(Icons.list, "Summarize", _summarizePDF),
          _buildSidebarItem(Icons.question_answer, "Ask AI", () {}),
          _buildSidebarItem(Icons.school, "Flashcards", () {}),
          Spacer(),
          _buildSidebarItem(Icons.home, "Back to Home", () {}),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSidebarHeader() {
    return ListTile(
      title: Text("PDF Learning", style: TextStyle(color: Colors.white, fontSize: 18)),
      subtitle: Text("Upload & analyze PDFs", style: TextStyle(color: Colors.grey, fontSize: 12)),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }

  /// PDF Viewer Section
  Widget _buildPDFViewer() {
    return Expanded(
      flex: 2,
      child: Container(
        padding: EdgeInsets.all(8),
        color: Colors.black,
        child: _selectedFile == null
            ? Center(
          child: Text(
            "No PDF selected",
            style: TextStyle(color: Colors.white70),
          ),
        )
            : SfPdfViewer.file(_selectedFile!), // No 'child' parameter here
      ),
    );
  }

  /// Main Content Panel
  Widget _buildContentPanel() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            SizedBox(height: 10),
            _buildSelectedFileSection(),
            SizedBox(height: 20),
            if (_errorMessage != null) _buildErrorMessage(),
            _buildSummarySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      "AI-Powered PDF Learning",
      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSelectedFileSection() {
    return _selectedFile != null
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            "Selected: ${_selectedFile!.path.split('/').last}",
            style: TextStyle(color: Colors.white70)),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _isLoading ? null : _summarizePDF,
          child: _isLoading
              ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2),
          )
              : Text("Summarize"),
        ),
      ],
    )
        : ElevatedButton(
      onPressed: _pickPDF,
      child: Text("Select PDF"),
    );
  }

  Widget _buildErrorMessage() {
    return Text(
      _errorMessage!,
      style: TextStyle(color: Colors.red, fontSize: 14),
    );
  }

  Widget _buildSummarySection() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(10),
        ),
        child: _summary == null
            ? Center(
          child: Text(
            "Summary will appear here.",
            style: TextStyle(color: Colors.white70),
          ),
        )
            : SingleChildScrollView(
          child: Text(
            _summary!,
            style: TextStyle(color: Colors.white70),
          ),
        ),
      ),
    );
  }
}