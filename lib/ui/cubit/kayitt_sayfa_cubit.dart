import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/data/repo/tododao_repository.dart';

class KayitSayfaCubit extends Cubit<void> {
  KayitSayfaCubit() : super(0);
  var toDoRepo = ToDoDaoRepository();

  Future <void> kaydet(String name) async{
    await toDoRepo.kaydet(name);
    emit(0);
  }
}
