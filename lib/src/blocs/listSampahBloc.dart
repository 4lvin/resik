import 'package:new_resik/src/models/getHistoryModel.dart';
import 'package:new_resik/src/models/getPenukaranModel.dart';
import 'package:new_resik/src/models/getSampahModel.dart';
import 'package:new_resik/src/resources/repositories.dart';
import 'package:rxdart/rxdart.dart';

class ListSampahBloc {
  final _repository = Repositories();
  final _hargaFetcher = PublishSubject<GetSampahModel>();
  final _historyFetcher = PublishSubject<GetHistoryModel>();
  final _penukaranFetcher = PublishSubject<GetPenukaranModel>();

  PublishSubject<GetSampahModel> get listHarga => _hargaFetcher;
  PublishSubject<GetHistoryModel> get listHistory => _historyFetcher;
  PublishSubject<GetPenukaranModel> get listPenukaran => _penukaranFetcher;

  getSampah(String id) async {
    GetSampahModel getSampahModel = await _repository.getSampah(id);
    _hargaFetcher.sink.add(getSampahModel);
  }

  getHistory(String id) async {
    GetHistoryModel getHistoryModel = await _repository.getHistory(id);
    _historyFetcher.sink.add(getHistoryModel);
  }

  getPenukaran(String idDesa) async {
    try {
      GetPenukaranModel getPenukaranModel =
          await _repository.getPenukaran(idDesa);
      _penukaranFetcher.sink.add(getPenukaranModel);
    } catch (error) {
      _penukaranFetcher.sink.addError(error);
    }
  }

  dispose() {
    _hargaFetcher.close();
    _historyFetcher.close();
    _penukaranFetcher.close();
  }
}

final blocListSampah = ListSampahBloc();
