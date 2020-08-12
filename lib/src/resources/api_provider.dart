import 'dart:async';
import 'package:async/async.dart';
import 'package:b_sampah/src/models/getHistoryModel.dart';
import 'package:b_sampah/src/models/getResponseSetorModel.dart';
import 'dart:io';
import 'package:b_sampah/src/models/getResponseTukarModel.dart';
import 'package:b_sampah/src/models/getSaldoModel.dart';
import 'package:b_sampah/src/models/getSampahModel.dart';
import 'package:b_sampah/src/models/getUserLoginModel.dart';
import 'package:http/http.dart' as client;
import 'package:path/path.dart' as path;
import 'dart:convert';
import 'dart:io';

class ApiProvider{
  String url = "http://jongjava.tech/banksampah_ws/restapi";
  Future<GetSampahModel> getSampah() async{
    final sampah =
    await client.get("$url/c_sampah/get_sampah");
    if (sampah.statusCode == 200) {
      return GetSampahModel.fromJson(json.decode(sampah.body));
    } else {
      throw Exception('Failed to load sampah');
    }
  }
  Future idCheck(String id, String password) async {
    var body = jsonEncode({'id_anggota': id, 'password': password});
    try {
      final checkId = await client
          .post("$url/c_login/form_login",
          headers: {"Content-Type": "application/json"}, body: body)
          .timeout(const Duration(seconds: 11));
      if (checkId.statusCode == 200) {
        return GetUserLoginModel.fromJson(json.decode(checkId.body));
      } else if (checkId.statusCode == 404) {
        return GetUserLoginModel.fromJson(json.decode(checkId.body));
      } else {
        throw Exception('Failure response');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }
  Future<GetSaldoModel> getSaldo(String id) async{
    final saldo =
    await client.get("$url/C_setor/get_saldo?id_anggota=$id");
    if (saldo.statusCode == 200) {
      return GetSaldoModel.fromJson(json.decode(saldo.body));
    } else {
      throw Exception('Failed to load saldo');
    }
  }
  Future penukaran(String id, String kategori,String tgl,int nominal,String nomer) async {
    var body = jsonEncode({'id_anggota': id, 'id_kategori': kategori,'tanggal':tgl,'nominal':nominal,'nomer':nomer});
    try {
      final checkId = await client
          .post("$url/C_setor/penukaran",
          headers: {"Content-Type": "application/json"}, body: body)
          .timeout(const Duration(seconds: 11));
      if (checkId.statusCode == 200) {
        return GetResponseTukarModel.fromJson(json.decode(checkId.body));
      } else if (checkId.statusCode == 404) {
        return GetResponseTukarModel.fromJson(json.decode(checkId.body));
      } else {
        throw Exception('Failure response');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }
  Future setorSampah(String id, String tgl, String idSampah, String jumlah,
      String harga,File bukti) async {
    var uri = Uri.parse("$url/C_setor/setor_sampah");
    var request = client.MultipartRequest("POST", uri);
    request.fields['id_anggota'] = id;
    request.fields['tanggal'] = tgl;
    request.fields['id_sampah'] = idSampah;
    request.fields['jumlah'] = jumlah;
    request.fields['harga'] = harga;
    request.files.add(client.MultipartFile(
        "bukti",
        client.ByteStream(DelegatingStream.typed(bukti.openRead())),
        await bukti.length(),
        filename: path.basename(bukti.path)));

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    if (response.statusCode == 200) {
      return GetResponseSetorModel.fromJson(json.decode(responseString));
    }
  }

  Future<GetHistoryModel> getHistory(String id) async{
    final history =
    await client.get("$url/C_setor/get_history?id_anggota=$id");
    if (history.statusCode == 200) {
      return GetHistoryModel.fromJson(json.decode(history.body));
    } else {
      throw Exception('Failed to load History');
    }
  }
  Future kotakSaran(String id, String komentar) async {
    var body = jsonEncode({'id_anggota': id, 'komentar': komentar});
    try {
      final checkId = await client
          .post("$url/C_komentar/form_komentar",
          headers: {"Content-Type": "application/json"}, body: body)
          .timeout(const Duration(seconds: 11));
      if (checkId.statusCode == 200) {
        return print("Sukses");
      } else if (checkId.statusCode == 404) {
        return print("Gagal");
      } else {
        throw Exception('Failure response');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }
}