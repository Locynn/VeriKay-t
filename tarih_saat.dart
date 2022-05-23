import 'package:flutter/material.dart';
class TarihSaat extends StatefulWidget {
  const TarihSaat({Key? key}) : super(key: key);

  @override
  _TarihSaatState createState() => _TarihSaatState();
}

class _TarihSaatState extends State<TarihSaat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarih Saat"),
      ),
    );
  }
}
