import 'dart:io';

import 'package:new_resik/src/models/getHistoryModel.dart';
import 'package:new_resik/src/models/getSaldoModel.dart';
import 'package:new_resik/src/models/getSampahModel.dart';
import 'package:new_resik/src/resources/api_provider.dart';

class Repositories {
  final apiProvider = ApiProvider();

  Future<GetSampahModel> getSampah(String id) => apiProvider.getSampah(id);

  Future checkId(String id) => apiProvider.idCheck(id);

  Future checkPin(String id, String pin, String token) =>
      apiProvider.pinCheck(id, pin, token);

  Future ubahPin(String id, String token, String pinLama, String pinBaru) =>
      apiProvider.ubahPin(id, token, pinLama, pinBaru);

  Future getSaldo(String id) => apiProvider.getSaldo(id);

  Future getPenukaran(String idDesa) => apiProvider.getPenukaran(idDesa);

  Future penukaran(String idAnggota, String idPenukaran, String idDesa,
          String tgl, int nominal, String nomer, String token) =>
      apiProvider.penukaran(
          idAnggota, idPenukaran, idDesa, tgl, nominal, nomer, token);

  Future setorSampah(String idDesa, String idAnggota, String tgl,
          List detailSetor, String token) =>
      apiProvider.setorSampah(idDesa, idAnggota, tgl, detailSetor, token);

  Future<GetHistoryModel> getHistory(String id) => apiProvider.getHistory(id);

  Future kotakSaaran(String id, String komentar) =>
      apiProvider.kotakSaran(id, komentar);

  Future getInformasi(String idDesa) => apiProvider.getInformasi(idDesa);
}
