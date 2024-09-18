import 'package:flutter/material.dart';
import 'package:workshop/sqlite/veritabani_log.dart';
import 'register.dart';
import 'anasayfa.dart';
import 'resetpass.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  String _errorMessage = '';
  bool _isSuccess = false;

  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Kullanıcı adı ve şifre giriniz!';
        _isSuccess = false;
      });
      return;
    }

    bool kullaniciVar = await VeritabaniLog.kullaniciKontrol(username, password);
    if (kullaniciVar) {
      setState(() {
        _errorMessage = '';
        _isSuccess = true;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Anasayfa()),
      );
    } else {
      setState(() {
        _errorMessage = 'Kullanıcı adı veya şifre yanlış!';
        _isSuccess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (_isSuccess)
                  Container(
                    color: Colors.green,
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      children: [
                        Icon(Icons.check, color: Colors.white),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            'Giriş başarılı!',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              _isSuccess = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 90),
                Image.asset("images/login.png",width: 200,),
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
                        offset: Offset(0, 3), // Gölge konumu
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
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Şifre',
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
                    onPressed: _login,
                    child: Text('Giriş Yap', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                    );
                  },
                  child: Text('Şifremi Unuttum', style: TextStyle(fontSize: 16,color: Colors.blue)),
                ),
                SizedBox(height: 50), // Butonlar arasında boşluk
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child:
                  RichText(
                    text: TextSpan(
                      text: 'Hesabın yok mu? ',
                      style: TextStyle(fontSize: 16, color: Colors.black), // Varsayılan metin rengi
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Kaydol',
                          style: TextStyle(fontSize: 16, color: Colors.blue,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
