
import 'dart:io';

import 'package:b_sampah/src/models/getHistoryModel.dart';
import 'package:b_sampah/src/models/getSaldoModel.dart';
import 'package:b_sampah/src/models/getSampahModel.dart';
import 'package:b_sampah/src/resources/api_provider.dart';

class Repositories{
  final apiProvider = ApiProvider();

  Future<GetSampahModel> getSampah() => apiProvider.getSampah();

  Future checkId(String id, String password) =>
      apiProvider.idCheck(id, password);

  Future<GetSaldoModel> getSaldo(String id) => apiProvider.getSaldo(id);

  Future penukaran(String id, String kategori,String tgl,int nominal,String nomer) =>
      apiProvider.penukaran(id, kategori, tgl, nominal, nomer);

  Future setorSampah(String id, String tgl, String idSampah, String jumlah,
      String harga,File bukti) =>
      apiProvider.setorSampah(id, tgl, idSampah, jumlah, harga, bukti);

  Future<GetHistoryModel> getHistory(String id) => apiProvider.getHistory(id);

  Future kotakSaaran(String id, String komentar) =>
      apiProvider.kotakSaran(id, komentar);

}