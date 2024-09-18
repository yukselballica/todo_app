import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/data/entity/todos.dart';
import 'package:workshop/ui/cubit/anasayfa_cubit.dart';
import 'package:workshop/ui/cubit/kayitt_sayfa_cubit.dart';
import 'package:workshop/ui/renkler.dart';
import 'package:workshop/ui/views/detay_sayfa.dart';
import 'package:workshop/ui/views/kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().toDosYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ToDos",
          style: TextStyle(color: Colors.black, fontFamily: "Pacifico", fontSize: 25),
        ),
        backgroundColor: renkBaslik,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const kayit_sayfa())).then((value) {
            context.read<AnasayfaCubit>().toDosYukle();
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoSearchTextField(
                backgroundColor: Colors.blue.shade50,
                placeholder: "Ara",
                style: TextStyle(color: Colors.black),
                onChanged: (searchText) {
                  context.read<AnasayfaCubit>().ara(searchText);
                },
              ),
            ),
            BlocListener<KayitSayfaCubit, void>(
              listener: (context, state) {
                context.read<AnasayfaCubit>().toDosYukle();
              },
              child: BlocBuilder<AnasayfaCubit, List<ToDos>>(
                builder: (context, toDosListesi) {
                  if (toDosListesi.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: toDosListesi.length,
                        itemBuilder: (context, indeks) {
                          var toDo = toDosListesi[indeks];
                          return Dismissible(
                            key: Key(toDo.id.toString()),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (direction) async {
                              return await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Color(0xFFFFF6EA),
                                    title: Text("Silme Onayı",style: TextStyle(fontWeight: FontWeight.bold),),
                                    content: Text("${toDo.name} silinsin mi?",style: TextStyle(color: Colors.black),),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(false),
                                        child: Text("Hayır",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.purple.shade900),),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(true),
                                        child: Text("Evet",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.purple.shade900),),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            onDismissed: (direction) {
                              context.read<AnasayfaCubit>().sil(toDo.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("${toDo.name} silindi"),
                                ),
                              );
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Detay_sayfa(toDos: toDo))).then((value) {
                                  context.read<AnasayfaCubit>().toDosYukle();
                                });
                              },
                              child: Card(
                                color: Color(0xFFC7FFD8),
                                child: Container(
                                  height: 100, // Yüksekliği artırır
                                  child: ListTile(
                                    leading: Checkbox(
                                      value: toDo.isCompleted,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          toDo.isCompleted = value!;
                                        });
                                      },
                                    ),
                                    title: Text(
                                      toDo.name,
                                      style: TextStyle(
                                        fontSize: 20,
                                        decoration: toDo.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Text("Görev bulunamadı",style: TextStyle(fontWeight: FontWeight.bold),),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
