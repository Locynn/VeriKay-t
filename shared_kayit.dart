import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedKayit extends StatefulWidget {
  const SharedKayit({Key? key}) : super(key: key);

  @override
  _SharedKayitState createState() => _SharedKayitState();
}

class _SharedKayitState extends State<SharedKayit> {
  final isimCtrl = TextEditingController();
  final soyisimCtrl = TextEditingController();
  final sayiCtrl = TextEditingController();
  final genelCtrl = GlobalKey<FormState>();
  String isimStr = "";
  String soyisimStr = "";
  int kayitNo = 0;
  bool kayitDurum = false;

  @override
  void dispose() {
    isimCtrl.dispose();
    soyisimCtrl.dispose();
    sayiCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Kayıt"),
      ),
      body: Form(
        key: genelCtrl,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                validator: (deger) {
                  if (deger!.isEmpty) {
                    return "Lütfen isim alanını boş geçmeyiniz";
                  }
                  if (deger.length < 3) {
                    return "En az 3 karakter giriniz";
                  }
                },
                controller: isimCtrl,
                decoration: InputDecoration(hintText: "İsim giriniz"),
              ),
              TextFormField(
                validator: (deger) {
                  if (deger!.isEmpty) {
                    return "Lütfen soyad alanını boş geçmeyiniz";
                  }
                  if (deger.length < 3) {
                    return "En az 3 karakter giriniz";
                  }
                },
                controller: soyisimCtrl,
                decoration: InputDecoration(hintText: "Soyad giriniz"),
              ),
              TextFormField(
                 validator: (deger) {
                  if (deger!.isEmpty) {
                     return "Lütfen isim alanını boş geçmeyiniz";
                   }
                  },
                controller: sayiCtrl,
                decoration: InputDecoration(hintText: "Sayı giriniz"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => kayitYap(
                        isimCtrl.text, soyisimCtrl.text, sayiCtrl.text),
                    child: Text("Kaydet"),
                  ),
                  ElevatedButton(
                    onPressed: () => oku(),
                    child: Text("Oku"),
                  ),
                  ElevatedButton(
                    onPressed: () => sil(),
                    child: Text("Sil"),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text("İsim : $isimStr"),
                    Text("Soyad : $soyisimStr"),
                    Text("Numara : $kayitNo"),
                    Text("Durum : $kayitDurum"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  kayitYap(String ad, String soyad, String numara) async {
    final kayitAraci = await SharedPreferences.getInstance();
    if (genelCtrl.currentState!.validate()) {
      kayitAraci.setString("isim", ad);
      kayitAraci.setString("soyad", soyad);
      kayitAraci.setInt("numara", int.parse(numara));
      kayitAraci.setBool("durum", true);
      setState(() {
        isimStr = ad;
        soyisimStr = soyad;
        kayitNo = int.parse(numara);
        kayitDurum = true;
        soyisimCtrl.text = "";
        isimCtrl.text = "";
        sayiCtrl.text = "";
      });
      Fluttertoast.showToast(
          msg: "KAyıt yapıldı",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
  }

  oku() async {
    final kayitAraci = await SharedPreferences.getInstance();
    String? kIsim = kayitAraci.getString("isim");
    String? kSoyad = kayitAraci.getString("soyad");
    int? kNumara = kayitAraci.getInt("numara");
    bool? kDurum = kayitAraci.getBool("durum");
    setState(() {
      isimStr = kIsim!;
      soyisimStr = kSoyad!;
      kayitNo = kNumara!;
      kayitDurum = kDurum!;
    });
  }

  sil() async {
    final kayitAraci = await SharedPreferences.getInstance();
    kayitAraci.remove("isim");
    kayitAraci.remove("soyad");
    kayitAraci.remove("numara");
    kayitAraci.remove("durum");
    setState(() {
      isimStr = "";
      soyisimStr = "";
      kayitNo = 0;
      kayitDurum = false;
    });
    Fluttertoast.showToast(
        msg: "Kayıt Siloindi",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER);
  }
}
