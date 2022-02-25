import 'dart:async';
import 'package:async/async.dart';
import 'package:new_resik/src/models/getHistoryModel.dart';
import 'package:new_resik/src/models/getIdCheckModel.dart';
import 'package:new_resik/src/models/getInformasiModel.dart';
import 'package:new_resik/src/models/getPenukaranModel.dart';
import 'package:new_resik/src/models/getResponseSetorModel.dart';
import 'dart:io';
import 'package:new_resik/src/models/getResponseTukarModel.dart';
import 'package:new_resik/src/models/getSaldoModel.dart';
import 'package:new_resik/src/models/getSampahModel.dart';
import 'package:new_resik/src/models/getUbahPinModel.dart';
import 'package:new_resik/src/models/getUserLoginModel.dart';
import 'package:http/http.dart' as client;
import 'package:path/path.dart' as path;
import 'dart:convert';
import 'dart:io';

class ApiProvider {
  // String url = "http://jongjava.tech/banksampah_ws/restapi";
  String url = "https://resik.co.id/banksampah_ws/restapi";

  Future<GetSampahModel> getSampah(String id) async {
    var body = jsonEncode({'id_desa': id});
    try {
      final checkId = await client
          .post(Uri.parse("$url/C_sampah/get_sampah"),
              headers: {"Content-Type": "application/json"}, body: body)
          .timeout(const Duration(seconds: 11));
      if (checkId.statusCode == 200) {
        return GetSampahModel.fromJson(json.decode(checkId.body));
      } else if (checkId.statusCode == 404) {
        return GetSampahModel.fromJson(json.decode(checkId.body));
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

  Future idCheck(String id) async {
    var body = jsonEncode({'id_anggota': id});
    try {
      final checkId = await client
          .post(Uri.parse("$url/C_user/get_anggota"),
              headers: {"Content-Type": "application/json"}, body: body)
          .timeout(const Duration(seconds: 11));
      if (checkId.statusCode == 200) {
        return GetIdCheckModel.fromJson(json.decode(checkId.body));
      } else if (checkId.statusCode == 404) {
        return GetIdCheckModel.fromJson(json.decode(checkId.body));
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

  Future pinCheck(String id, String pin, String token) async {
    var body = jsonEncode({'id_anggota': id, 'pin': pin, 'token': token});
    try {
      final checkId = await client
          .post(Uri.parse("$url/C_user/get_pin"),
              headers: {"Content-Type": "application/json"}, body: body)
          .timeout(const Duration(seconds: 11));
      print(checkId.body);
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

  Future getSaldo(String id) async {
    var body = jsonEncode({'id_anggota': id});
    try {
      final checkId = await client
          .post(Uri.parse("$url/C_user/saldo"),
              headers: {"Content-Type": "application/json"}, body: body)
          .timeout(const Duration(seconds: 11));
      if (checkId.statusCode == 200) {
        return GetSaldoModel.fromJson(json.decode(checkId.body));
      } else if (checkId.statusCode == 404) {
        return GetSaldoModel.fromJson(json.decode(checkId.body));
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

  Future getPenukaran(String idDesa) async {
    var body = jsonEncode({'id_desa': idDesa});
    try {
      final checkId = await client
          .post(Uri.parse("$url/C_sampah/jenis_penukaran"),
              headers: {"Content-Type": "application/json"}, body: body)
          .timeout(const Duration(seconds: 11));
      if (checkId.statusCode == 200) {
        return GetPenukaranModel.fromJson(json.decode(checkId.body));
      } else if (checkId.statusCode == 404) {
        return GetPenukaranModel.fromJson(json.decode(checkId.body));
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

  Future penukaran(String idAnggota, String idPenukaran, String idDesa,
      String tgl, int nominal, String nomer, String token) async {
    var body = jsonEncode({
      'id_anggota': idAnggota,
      'id_penukaran': idPenukaran,
      'id_desa': idDesa,
      'tanggal': tgl,
      'nominal': nominal,
      'nomer': nomer
    });
    try {
      final checkId = await client
          .post(Uri.parse("$url/C_user/penukaran"),
              headers: {
                "Content-Type": "application/json",
                "Authorization": token
              },
              body: body)
          .timeout(const Duration(seconds: 11));
      print(checkId.body);
      print(body);
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

  Future setorSampah(String idDesa, String idAnggota, String tgl,
      List detailSetor, String token) async {
    var body = jsonEncode({
      'id_desa': idDesa,
      'id_anggota': idAnggota,
      'tanggal': tgl,
      'detail_setor': detailSetor,
    });
    try {
      final checkId = await client
          .post(Uri.parse("$url/C_user/setor"),
              headers: {
                "Content-Type": "application/json",
                "Authorization": token
              },
              body: body)
          .timeout(const Duration(seconds: 11));
      print(checkId.body);
      if (checkId.statusCode == 200) {
        return GetResponseSetorModel.fromJson(json.decode(checkId.body));
      } else if (checkId.statusCode == 404) {
        return GetResponseSetorModel.fromJson(json.decode(checkId.body));
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

  Future<GetHistoryModel> getHistory(String id) async {
    var body = jsonEncode({'id_anggota': id});
    final history = await client.post(Uri.parse("$url/C_user/history_setor"),
        headers: {"Content-Type": "application/json"}, body: body);
    print(history.body);
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
          .post(Uri.parse("$url/C_komentar/form_komentar"),
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

  Future ubahPin(
      String id, String token, String pinLama, String pinBaru) async {
    var body = jsonEncode(
        {'id_anggota': id, 'pin_lama': pinLama, 'pin_baru': pinBaru});
    print(body);
    print(token);
    try {
      final checkId = await client
          .post(Uri.parse("$url/C_user/ubah_pin"),
              headers: {
                "Content-Type": "application/json",
                "Authorization": token
              },
              body: body)
          .timeout(const Duration(seconds: 11));
      print(checkId.body);
      if (checkId.statusCode == 200) {
        return GetUbahPinModel.fromJson(json.decode(checkId.body));
      } else if (checkId.statusCode == 404) {
        return GetUbahPinModel.fromJson(json.decode(checkId.body));
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

  Future getInformasi(String idDesa) async {
    var body = jsonEncode({'id_desa': idDesa});
    final history = await client.post(Uri.parse("$url/C_user/informasi"),
        headers: {"Content-Type": "application/json"}, body: body);
    print(history.body);
    if (history.statusCode == 200) {
      return GetInformasiModel.fromJson(json.decode(history.body));
    } else {
      throw Exception('Failed to load History');
    }
  }
}
