import 'package:flutter/material.dart';
import 'package:workshop/main.dart';
import 'package:workshop/ui/cubit/kayitt_sayfa_cubit.dart';
import 'package:workshop/ui/renkler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/sqlite/veritabani_yardimcisi.dart';

class kayit_sayfa extends StatefulWidget {
  const kayit_sayfa({super.key});

  @override
  State<kayit_sayfa> createState() => _kayit_sayfaState();
}

class _kayit_sayfaState extends State<kayit_sayfa> {
  var tfName = TextEditingController();

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
                decoration: InputDecoration(
                  hintText: "Görev Ekle...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
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
                    context.read<KayitSayfaCubit>().kaydet(tfName.text);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Color(0xFFFFF6EA),
                          title: Text("Başarılı", style: TextStyle(fontWeight: FontWeight.bold)),
                          content: Text("Görev kaydedildi!", style: TextStyle(color: Colors.black)),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Dialog'u kapat
                                Navigator.of(context).pop(); // Kayıt sayfasını kapat ve anasayfaya dön
                              },
                              child: Text("Tamam", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple.shade900)),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text(
                  "KAYDET",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
