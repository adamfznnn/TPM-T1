import 'package:flutter/material.dart';
import 'dart:math';

class PiramidPage extends StatefulWidget {
  @override
  _PiramidPageState createState() => _PiramidPageState();
}

class _PiramidPageState extends State<PiramidPage> {
  final TextEditingController _panjangController = TextEditingController(text: '0');
  final TextEditingController _lebarController = TextEditingController(text: '0');
  final TextEditingController _tinggiController = TextEditingController(text: '0');

  double _luas = 0;
  double _volume = 0;

  void _hitung() {
    double panjang = double.tryParse(_panjangController.text) ?? 0;
    double lebar = double.tryParse(_lebarController.text) ?? 0;
    double tinggi = double.tryParse(_tinggiController.text) ?? 0;

    // Luas piramid = luas alas + luas sisi tegak
    // Asumsi piramid dengan alas persegi panjang
    double luasAlas = panjang * lebar;
    double tinggiSisi = sqrt((panjang/2)*(panjang/2) + tinggi*tinggi); // tinggi sisi untuk panjang
    double lebarSisi = sqrt((lebar/2)*(lebar/2) + tinggi*tinggi); // tinggi sisi untuk lebar
    double luasSisi = (panjang * tinggiSisi / 2) * 2 + (lebar * lebarSisi / 2) * 2; // 2 sisi panjang + 2 sisi lebar
    _luas = luasAlas + luasSisi;

    // Volume piramid = (1/3) * luas alas * tinggi
    _volume = (1/3) * luasAlas * tinggi;

    setState(() {});
  }

  void _ubahNilai(TextEditingController controller, bool tambah) {
    double nilai = double.tryParse(controller.text) ?? 0;
    if (tambah) {
      nilai += 1;
    } else {
      nilai = max(0, nilai - 1);
    }
    controller.text = nilai.toString();
    _hitung();
  }

  Widget _buildInputField(String label, TextEditingController controller, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[900]),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blue[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(icon, color: Colors.blue[800]),
                ),
                onChanged: (value) => _hitung(),
              ),
            ),
            SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(12)),
              child: IconButton(
                icon: Icon(Icons.remove, color: Colors.blue[800]),
                onPressed: () => _ubahNilai(controller, false),
              ),
            ),
            SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(12)),
              child: IconButton(
                icon: Icon(Icons.add, color: Colors.blue[800]),
                onPressed: () => _ubahNilai(controller, true),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildResultCard(String judul, String hasil, IconData icon) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue[100]!),
        boxShadow: [
          BoxShadow(color: Colors.blue.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue[50],
            child: Icon(icon, color: Colors.blue[800]),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(judul, style: TextStyle(color: Colors.blue[300], fontSize: 14)),
              Text(hasil, style: TextStyle(color: Colors.blue[900], fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Hitung Piramid', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInputField('Panjang Alas', _panjangController, Icons.straighten),
              SizedBox(height: 16),
              _buildInputField('Lebar Alas', _lebarController, Icons.square_foot),
              SizedBox(height: 16),
              _buildInputField('Tinggi', _tinggiController, Icons.height),
              SizedBox(height: 32),
              _buildResultCard("Luas Permukaan", "${_luas.toStringAsFixed(2)}", Icons.layers),
              SizedBox(height: 15),
              _buildResultCard("Volume", "${_volume.toStringAsFixed(2)}", Icons.view_in_ar),
            ],
          ),
        ),
      ),
    );
  }
}