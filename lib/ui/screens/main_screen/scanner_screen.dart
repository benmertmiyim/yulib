import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:yulib/core/model/book_model.dart';
import 'package:yulib/core/view/book_view.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  BookView? bookView;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    bookView = Provider.of<BookView>(context);

    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: scanArea),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ),
        Center(
          child: Consumer<BookView>(
            builder: (x, view, y) {
              if (view.bookProcess == BookProcess.busy) {
                controller?.pauseCamera();
                return Wrap(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: const [
                            CircularProgressIndicator(),
                            Text("İşleminiz Devam Ediyor...")
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                controller?.resumeCamera();
                return Container();
              }
            },
          ),
        ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {

      BookModel bookModel = await bookView!.getBook(scanData.code!) as BookModel;
      bool result = await bookView!.orderBook(bookModel);
      if(result){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Başarılı.')),
        );
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bu kitap kullanılamaz.')),
        );
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    debugPrint('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
