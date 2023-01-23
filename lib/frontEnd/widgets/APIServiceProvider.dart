import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ApiServiceProvider {
  // ignore: constant_identifier_names
  static final BASE_URL = Uri(
      scheme: 'https',
      host: 'raw.githubusercontent.com',
      path:
          'PedroViniciusVeiga/ProjetoColdigo/master/ProjetoFaClube/WebContent/img/loja/almofada.jpg');

  static Future<String> loadPDF() async {
    print(BASE_URL);
    var response = await http.get(BASE_URL);

    var dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/data.pdf");
    file.writeAsBytesSync(response.bodyBytes, flush: true);
    return file.path;
  }
}
