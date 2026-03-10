import 'package:flutter/material.dart';
import 'dart:math';

class BilanganPage extends StatefulWidget {
  @override
  _BilanganPageState createState() => _BilanganPageState();
}

class _BilanganPageState extends State<BilanganPage> {
  final TextEditingController _controller = TextEditingController();
  String _hasilGanjilGenap = "-";
  String _hasilPrima = "-";

  void _cekBilangan() {
    int? angka = int.tryParse(_controller.text);

    if (angka == null) {
      setState(() {
        _hasilGanjilGenap = "Input tidak valid";
        _hasilPrima = "-";
      });
      return;
    }

    setState(() {
      // Logika Ganjil atau Genap
      _hasilGanjilGenap = (angka % 2 == 0) ? "Bilangan Genap" : "Bilangan Ganjil";

      // Logika Bilangan Prima
      if (_isPrima(angka)) {
        _hasilPrima = "Merupakan Bilangan Prima";
      } else {
        _hasilPrima = "Bukan Bilangan Prima";
      }
    });
  }

  bool _isPrima(int n) {
    if (n <= 1) return false;
    for (int i = 2; i <= sqrt(n); i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Cek Ganjil/Genap & Prima", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Masukkan Angka",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue[900]),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Contoh: 17",
                filled: true,
                fillColor: Colors.blue[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.numbers, color: Colors.blue[800]),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _cekBilangan,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text("Cek Bilangan", style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 30),
            
            // Kartu Hasil
            _buildResultCard("Ganjil / Genap", _hasilGanjilGenap, Icons.compare_arrows),
            SizedBox(height: 15),
            _buildResultCard("Status Bilangan Prima", _hasilPrima, Icons.star_outline),
          ],
        ),
      ),
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
}