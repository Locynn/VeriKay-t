import 'package:flutter/material.dart';
import 'package:verikaydet/shared_kayit.dart';
import 'package:verikaydet/tarih_saat.dart';
import 'package:verikaydet/text_kayit.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int secilenMenuItem = 0;
  late SharedKayit sayfaShared;
  late TextKayit sayfaTextkayit;
  late TarihSaat sayfaTarihsaat;
  late List<Widget> tumSayfalar;

  @override
  void initState() {
    super.initState();
    sayfaShared = SharedKayit();
    sayfaTextkayit = TextKayit(kayitIslemleri: KayitIslemleri(),);
    sayfaTarihsaat = TarihSaat();
    tumSayfalar = [sayfaShared, sayfaTextkayit, sayfaTarihsaat];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: Scaffold(
        bottomNavigationBar: BottomNavigationMenu(),
        body: tumSayfalar[secilenMenuItem],
      ),
    );
  }

  Theme BottomNavigationMenu() {
    return Theme(
      data: ThemeData(canvasColor: Colors.cyan, primaryColor: Colors.red),
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility),
            label: "shared kayit",
              backgroundColor: Colors.orange
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: "dosya kayit",
              backgroundColor: Colors.green.shade200
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm),
              label: "tarih saat",
              backgroundColor: Colors.purpleAccent
          ),
        ],
        type: BottomNavigationBarType.shifting,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.black,
        currentIndex: secilenMenuItem,
        onTap: (indis){
          setState(() {
            secilenMenuItem=indis;
          });
        },
      ),
    );
  }
}
