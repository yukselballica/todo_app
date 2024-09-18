import 'package:flutter/material.dart';
import 'package:workshop/data/entity/todos.dart';
import 'package:workshop/main.dart';
import 'package:workshop/ui/cubit/detayt_sayfa_cubit.dart';
import 'package:workshop/ui/renkler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Detay_sayfa extends StatefulWidget {
  final ToDos toDos;
  Detay_sayfa({required this.toDos});

  @override
  State<Detay_sayfa> createState() => _Detay_sayfaState();
}

class _Detay_sayfaState extends State<Detay_sayfa> {
  var tfName = TextEditingController();

  @override
  void initState() {
    super.initState();
    var toDo = widget.toDos;
    tfName.text = toDo.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ToDos",
          style: TextStyle(
              color: Colors.black, fontFamily: "Pacifico", fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: renkBaslik,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: TextField(
                controller: tfName,
                decoration: const InputDecoration(
                  hintText: "Görev Ekle...",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (tfName.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Uyarı"),
                          content: Text("Boş görev kayıt edilemez!"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Tamam"),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    context.read<DetaySayfaCubit>().guncelle(widget.toDos.id, tfName.text);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Color(0xFFFFF6EA),
                          title: Text("Başarılı", style: TextStyle(fontWeight: FontWeight.bold)),
                          content: Text("Görev güncellendi!", style: TextStyle(color: Colors.black)),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop(); // Detay sayfasını kapat ve anasayfaya dön
                              },
                              child: Text("Tamam", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple.shade900)),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text(
                  "GÜNCELLE",
                  style: TextStyle(color: yaziRenk),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
