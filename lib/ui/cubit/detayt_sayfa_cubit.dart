import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/data/repo/tododao_repository.dart';

class DetaySayfaCubit extends Cubit<void> {
  DetaySayfaCubit() : super(8);
  var toDoRepo = ToDoDaoRepository();

  Future<void> guncelle(int id, String name) async {
    await toDoRepo.guncelle(id, name);
  }
}
