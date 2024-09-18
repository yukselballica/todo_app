import 'package:flutter/material.dart';
import 'package:workshop/sqlite/veritabani_log.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  bool _obscureText = true;
  String _errorMessage = '';

  Future<bool> isUserRegistered(String username) async {
    return await VeritabaniLog.kullaniciVarMi(username);
  }

  Future<void> _resetPassword() async {
    String username = _usernameController.text;
    String newPassword = _newPasswordController.text;

    if (username.isEmpty || newPassword.isEmpty) {
      setState(() {
        _errorMessage = 'Kullanıcı adı ve yeni şifre giriniz!';
      });
      return;
    }

    if (await isUserRegistered(username)) {
      await VeritabaniLog.sifreGuncelle(username, newPassword);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AlertDialog(
              backgroundColor: Colors.green,
              content: Row(
                children: [
                  Icon(Icons.check, color: Colors.white),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      'Şifre başarıyla yenilendi!',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Tamam',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      setState(() {
        _errorMessage = 'Kullanıcı bulunamadı';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.black,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 100),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Yeni Şifre Oluştur',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Lütfen yeni şifrenizi giriniz",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Kullanıcı Adı',
                          errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: _newPasswordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Yeni Şifre',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscureText,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _resetPassword,
                    child: Text('Şifreyi Yenile', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
