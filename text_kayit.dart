import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class KayitIslemleri {
  Future<String> get dosyaYolu async {
    final konum = await getApplicationDocumentsDirectory();
    return konum.path;
  }

  Future<File> get yerelDosya async {
    final yol = await dosyaYolu;
    return File(yol + "/kayit.txt");
  }

  Future<String> dosyaOku() async {
    try {
      final dosya = await yerelDosya;
      String icerik = await dosya.readAsString();
      return icerik;
    } catch (e) {
      return "Dosya mevcut değil";
    }
  } //okuma sonu

  Future<File> dosyaYaz(String gelenIcerik) async {
    final dosya = await yerelDosya;
    return dosya.writeAsString('$gelenIcerik');
  } //yazma sonu

  Future<File> dosyaSil() async {
    final dosya = await yerelDosya;
    return dosya.writeAsString('');
  } //silme sonu
}

class TextKayit extends StatefulWidget {
  final KayitIslemleri kayitIslemleri;

  const TextKayit({Key? key, required this.kayitIslemleri}) : super(key: key);

  @override
  _TextKayitState createState() => _TextKayitState();
}

class _TextKayitState extends State<TextKayit> {
  final yaziCtrl = TextEditingController();
  String veri = "";

  @override
  void initState() {
    super.initState();
    widget.kayitIslemleri.dosyaOku().then((String deger) {
      setState(() {
        veri = deger;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text Kayıt"),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: "Veri giriniz"),
            controller: yaziCtrl,
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () => veriKaydet(), child: Text("Kaydet")),
              ElevatedButton(
                  onPressed: () => veriOku(), child: Text("Oku")),
              ElevatedButton(
                  onPressed: () => veriSil(), child: Text("Sil")),
            ],
          )
        ],
      ),
    );
  }

  veriKaydet() async{
    setState(() {
      veri=yaziCtrl.text;
      yaziCtrl.clear();
    });
    return widget.kayitIslemleri.dosyaYaz(veri);
  }

  veriOku() async{
    widget.kayitIslemleri.dosyaOku().then((String deger){
      setState(() {
        if(deger!=null)veri=deger;
        else veri="okunacak veri yok";
      });
    });
    Fluttertoast.showToast(
        msg: veri,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER);
  }

  veriSil() async {
    setState(() {
      veri="";
    });
    return widget.kayitIslemleri.dosyaSil();
  }
}
