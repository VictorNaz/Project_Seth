import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_project_seth/backEnd/controladora/CtrlAluno.dart';
import 'package:flutter_project_seth/backEnd/security/sessionService.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeRead extends StatefulWidget {
  const QRCodeRead({super.key});

  @override
  State<QRCodeRead> createState() => _QRCodeReadState();
}

class _QRCodeReadState extends State<QRCodeRead> {
  String ticket = '';

  readQRCode() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
      "#FFFFFF",
      "Cancelar",
      false,
      ScanMode.QR,
    );
    print(code + "wwwwwwwwwwwwwwwwwwww");
    if (code == "S3th") {
      setState(() => ticket = code != '-1' ? code : 'Não validado');
      if (ticket != 'Não validado') {
        validaPresAluno();
      }
      ticket = "Presença validada com sucesso!";
    } else {
      ticket = "Presença não validada!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Barra superior já com o icone de voltar
        backgroundColor: const Color.fromARGB(255, 252, 72, 27),
        title: Text("            Validar Presença"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (ticket != '')
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  'Ticket: $ticket',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ElevatedButton.icon(
                onPressed: readQRCode,
                icon: const Icon(Icons.qr_code),
                label: const Text('Ler QRCode'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  backgroundColor: Color.fromARGB(255, 252, 72, 27),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                      
                )),  
          ],
        ),
      ),
    );
  }
}

class QRCodeMake extends StatefulWidget {
  const QRCodeMake({super.key});

  @override
  State<QRCodeMake> createState() => _QRCodeMakeState();
}

class _QRCodeMakeState extends State<QRCodeMake> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //Barra superior já com o icone de voltar
          backgroundColor: const Color.fromARGB(255, 252, 72, 27),
          title: Text("         QR-Code de Presença"),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              QrImage(
                data: "S3th", //Dado que o QRCode Transfere
                errorCorrectionLevel: QrErrorCorrectLevel.H,
                gapless: true,
                size: 350.0,
              ),
            ],
          ),
        ));
  }
}
