import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/data/entity/todos.dart';
import 'package:workshop/data/repo/tododao_repository.dart';

class AnasayfaCubit extends Cubit<List<ToDos>>{
  AnasayfaCubit():super(<ToDos>[]);
var toDoRepo=ToDoDaoRepository();

  Future <void> toDosYukle() async{
    var liste=await toDoRepo.toDosYukle();
    emit(liste); // tetikleme

  }

  Future<void> ara(String aramaKelimesi) async{
    var liste=await toDoRepo.ara(aramaKelimesi);
    emit(liste);
  }
  Future<void> sil(int id) async{
    await toDoRepo.sil(id);
    toDosYukle();
  }
}