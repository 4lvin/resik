import 'dart:io';

import 'package:new_resik/src/models/getIdCheckModel.dart';
import 'package:new_resik/src/models/getInformasiModel.dart';
import 'package:new_resik/src/models/getResponseSetorModel.dart';
import 'package:new_resik/src/models/getResponseTukarModel.dart';
import 'package:new_resik/src/models/getSaldoModel.dart';
import 'package:new_resik/src/models/getUbahPinModel.dart';
import 'package:new_resik/src/models/getUserLoginModel.dart';
import 'package:new_resik/src/resources/repositories.dart';
import 'package:rxdart/rxdart.dart';

class MemberBloc {
  final _repository = Repositories();
  final _loginFetcher = PublishSubject<GetIdCheckModel>();
  final _pinFetcher = PublishSubject<GetUserLoginModel>();
  final _saldoFetcher = PublishSubject<GetSaldoModel>();
  final _penukaranFetcher = PublishSubject<GetResponseTukarModel>();
  final _setorFetcher = PublishSubject<GetResponseSetorModel>();
  final _ubahPinFetcher = PublishSubject<GetUbahPinModel>();
  final _informasiFetcher = PublishSubject<GetInformasiModel>();

  PublishSubject<GetIdCheckModel> get getUser => _loginFetcher;

  PublishSubject<GetUserLoginModel> get getPin => _pinFetcher;

  PublishSubject<GetSaldoModel> get resGetSaldo => _saldoFetcher;

  PublishSubject<GetResponseTukarModel> get resGetPenukaran =>
      _penukaranFetcher;

  PublishSubject<GetResponseSetorModel> get resGetSetor => _setorFetcher;

  PublishSubject<GetUbahPinModel> get resUbahPin => _ubahPinFetcher;

  PublishSubject<GetInformasiModel> get resInformasi => _informasiFetcher;

  checkId(String id) async {
    try {
      GetIdCheckModel getIdCheckModel = await _repository.checkId(id);
      _loginFetcher.sink.add(getIdCheckModel);
    } catch (error) {
      _loginFetcher.sink.addError(error);
    }
  }

  checkPin(String id, String pin, String token) async {
    try {
      GetUserLoginModel getUserLoginModel =
          await _repository.checkPin(id, pin, token);
      _pinFetcher.sink.add(getUserLoginModel);
    } catch (error) {
      _pinFetcher.sink.addError(error);
    }
  }

  penukaran(String idAnggota, String idPenukaran, String idDesa, String tgl,
      int nominal, String nomer, String token) async {
    try {
      GetResponseTukarModel getResponseTukarModel = await _repository.penukaran(
          idAnggota, idPenukaran, idDesa, tgl, nominal, nomer, token);
      _penukaranFetcher.sink.add(getResponseTukarModel);
    } catch (error) {
      _penukaranFetcher.sink.addError(error);
    }
  }

  setorSampah(String idDesa, String idAnggota, String tgl, List detailSetor,
      String token) async {
    try {
      GetResponseSetorModel getResponseSetorModel = await _repository
          .setorSampah(idDesa, idAnggota, tgl, detailSetor, token);
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

  ubahPin(String id, String token, String pinLama, String pinBaru) async {
    try {
      GetUbahPinModel getUbahPinModel =
          await _repository.ubahPin(id, token, pinLama, pinBaru);
      _ubahPinFetcher.sink.add(getUbahPinModel);
    } catch (error) {
      _ubahPinFetcher.sink.addError(error);
    }
  }

  getInformasi(String idDesa) async {
    try {
      GetInformasiModel getInformasiModel =
          await _repository.getInformasi(idDesa);
      _informasiFetcher.sink.add(getInformasiModel);
    } catch (error) {
      _informasiFetcher.sink.addError(error);
    }
  }

  dispose() {
    _loginFetcher.close();
    _pinFetcher.close();
    _saldoFetcher.close();
    _penukaranFetcher.close();
    _setorFetcher.close();
    _ubahPinFetcher.close();
    _informasiFetcher.close();
  }
}

final blocMember = MemberBloc();
