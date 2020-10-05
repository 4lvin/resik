import 'dart:io';

import 'package:b_sampah/src/models/getIdCheckModel.dart';
import 'package:b_sampah/src/models/getResponseSetorModel.dart';
import 'package:b_sampah/src/models/getResponseTukarModel.dart';
import 'package:b_sampah/src/models/getSaldoModel.dart';
import 'package:b_sampah/src/models/getSampahModel.dart';
import 'package:b_sampah/src/models/getUbahPinModel.dart';
import 'package:b_sampah/src/models/getUserLoginModel.dart';
import 'package:b_sampah/src/resources/repositories.dart';
import 'package:rxdart/rxdart.dart';

class MemberBloc {
  final _repository = Repositories();
  final _loginFetcher = PublishSubject<GetIdCheckModel>();
  final _pinFetcher = PublishSubject<GetUserLoginModel>();
  final _saldoFetcher = PublishSubject<GetSaldoModel>();
  final _penukaranFetcher = PublishSubject<GetResponseTukarModel>();
  final _setorFetcher = PublishSubject<GetResponseSetorModel>();
  final _ubahPinFetcher = PublishSubject<GetUbahPinModel>();

  PublishSubject<GetIdCheckModel> get getUser => _loginFetcher.stream;

  PublishSubject<GetUserLoginModel> get getPin => _pinFetcher.stream;

  PublishSubject<GetSaldoModel> get resGetSaldo => _saldoFetcher.stream;

  PublishSubject<GetResponseTukarModel> get resGetPenukaran =>
      _penukaranFetcher.stream;

  PublishSubject<GetResponseSetorModel> get resGetSetor => _setorFetcher.stream;

  PublishSubject<GetUbahPinModel> get resUbahPin => _ubahPinFetcher.stream;

  checkId(String id) async {
    try {
      GetIdCheckModel getIdCheckModel = await _repository.checkId(id);
      _loginFetcher.sink.add(getIdCheckModel);
    } catch (error) {
      _loginFetcher.sink.addError(error);
    }
  }

  checkPin(String id, String pin) async {
    try {
      GetUserLoginModel getUserLoginModel = await _repository.checkPin(id, pin);
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

  dispose() {
    _loginFetcher.close();
    _pinFetcher.close();
    _saldoFetcher.close();
    _penukaranFetcher.close();
    _setorFetcher.close();
    _ubahPinFetcher.close();
  }
}

final blocMember = MemberBloc();
