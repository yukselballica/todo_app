import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/ui/cubit/anasayfa_cubit.dart';
import 'package:workshop/ui/cubit/detayt_sayfa_cubit.dart';
import 'package:workshop/ui/cubit/kayitt_sayfa_cubit.dart';
import 'package:workshop/ui/renkler.dart';
import 'package:workshop/ui/views/anasayfa.dart';
import 'package:workshop/ui/views/detay_sayfa.dart';
import 'package:workshop/ui/views/kayit_sayfa.dart';
import 'package:workshop/ui/views/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> KayitSayfaCubit()),
        BlocProvider(create: (context)=> DetaySayfaCubit()),
        BlocProvider(create: (context)=>AnasayfaCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          scaffoldBackgroundColor: Color(0XFFFFD7C4),
          useMaterial3: true,
        ),
        home: LoginScreen(),
      ),
    );
  }
}


