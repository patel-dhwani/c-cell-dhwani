import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../services/admission_service.dart';

class StaffScannerPage extends StatefulWidget {
  const StaffScannerPage({super.key});

  @override
  State<StaffScannerPage> createState() => _StaffScannerPageState();
}

class _StaffScannerPageState extends State<StaffScannerPage> {
  final AdmissionService _service = AdmissionService();
  String? scannedToken;
  String message = '';

  Future<void> _handleScan(String token) async {
    setState(() {
      scannedToken = token;
      message = 'Searching candidate...';
    });

    final candidate = await _service.getCandidateByQr(token);
    if (candidate == null) {
      setState(() => message = 'Candidate not found');
      return;
    }

    await _service.markStageComplete(
      candidateId: candidate.id,
      stageId: 'CURRENT_STAGE_ID',
      staffId: 'CURRENT_STAFF_ID',
    );

    setState(() => message = 'Stage marked complete for ${candidate.fullName}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Staff Scanner')),
      body: Column(
        children: [
          Expanded(
            child: MobileScanner(
              onDetect: (capture) {
                final barcodes = capture.barcodes;
                if (barcodes.isNotEmpty) {
                  final raw = barcodes.first.rawValue;
                  if (raw != null && raw != scannedToken) {
                    _handleScan(raw);
                  }
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(message),
          ),
        ],
      ),
    );
  }
}