
import 'dart:io';

import 'package:b_sampah/src/models/getResponseSetorModel.dart';
import 'package:b_sampah/src/models/getResponseTukarModel.dart';
import 'package:b_sampah/src/models/getSaldoModel.dart';
import 'package:b_sampah/src/models/getSampahModel.dart';
import 'package:b_sampah/src/models/getUserLoginModel.dart';
import 'package:b_sampah/src/resources/repositories.dart';
import 'package:rxdart/rxdart.dart';

class MemberBloc{
  final _repository = Repositories();
  final _loginFetcher = PublishSubject<GetUserLoginModel>();
  final _saldoFetcher = PublishSubject<GetSaldoModel>();
  final _penukaranFetcher = PublishSubject<GetResponseTukarModel>();
  final _setorFetcher = PublishSubject<GetResponseSetorModel>();

  PublishSubject<GetUserLoginModel> get getUser => _loginFetcher.stream;
  PublishSubject<GetSaldoModel> get resGetSaldo => _saldoFetcher.stream;
  PublishSubject<GetResponseTukarModel> get resGetPenukaran => _penukaranFetcher.stream;
  PublishSubject<GetResponseSetorModel> get resGetSetor => _setorFetcher.stream;

  checkId(String id, String password) async {
    try {
      GetUserLoginModel getUserLoginModel = await _repository.checkId(id, password);
      _loginFetcher.sink.add(getUserLoginModel);
    } catch (error) {
      _loginFetcher.sink.addError(error);
    }
  }

  penukaran(String id, String kategori,String tgl,int nominal,String nomer) async {
    try {
      GetResponseTukarModel getResponseTukarModel = await _repository.penukaran(id, kategori, tgl, nominal,nomer);
      _penukaranFetcher.sink.add(getResponseTukarModel);
    } catch (error) {
      _penukaranFetcher.sink.addError(error);
    }
  }

  setorSampah(String id, String tgl, String idSampah, String jumlah,
      String harga,File bukti) async {
    try {
      GetResponseSetorModel getResponseSetorModel = await _repository.setorSampah(id, tgl, idSampah, jumlah, harga, bukti);
      _setorFetcher.sink.add(getResponseSetorModel);
    } catch (error) {
      _setorFetcher.sink.addError(error);
    }
  }

  getSaldo(String id) async {
    try {
      GetSaldoModel getSaldoModel = await _repository.getSaldo(id);
      _saldoFetcher.sink.add(getSaldoModel);
    } catch (error) {
      _saldoFetcher.sink.addError(error);
    }
  }

  kotakSaran(String id, String komentar) async {
      await _repository.kotakSaaran(id, komentar);
  }

  dispose(){
    _loginFetcher.close();
    _saldoFetcher.close();
    _penukaranFetcher.close();
    _setorFetcher.close();
  }
}
final blocMember = MemberBloc();