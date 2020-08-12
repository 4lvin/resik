
import 'package:b_sampah/src/models/getHistoryModel.dart';
import 'package:b_sampah/src/models/getSampahModel.dart';
import 'package:b_sampah/src/resources/repositories.dart';
import 'package:rxdart/rxdart.dart';

class ListSampahBloc{
  final _repository = Repositories();
  final _hargaFetcher = PublishSubject<GetSampahModel>();
  final _historyFetcher = PublishSubject<GetHistoryModel>();

  PublishSubject<GetSampahModel> get listHarga => _hargaFetcher.stream;
  PublishSubject<GetHistoryModel> get listHistory => _historyFetcher.stream;

  getSampah() async{
    GetSampahModel getSampahModel = await _repository.getSampah();
    _hargaFetcher.sink.add(getSampahModel);
  }

  getHistory(String id) async{
    GetHistoryModel getHistoryModel = await _repository.getHistory(id);
    _historyFetcher.sink.add(getHistoryModel);
  }

  dispose(){
    _hargaFetcher.close();
    _historyFetcher.close();
  }
}
final blocListSampah = ListSampahBloc();