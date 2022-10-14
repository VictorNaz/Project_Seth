import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:core';

String dataCrypt(String data) {
  var data64 = base64.encode(utf8.encode(data));
  var dataMd5 = utf8.encode(data64);
  var hmacSha256 = Hmac(md5, dataMd5);
  var dataHmac = hmacSha256.convert(dataMd5);
  var sHmac = dataHmac.toString();
  return sHmac;
}
