import 'package:flutter/material.dart';

class JumlahAngkaPage extends StatefulWidget {
  const JumlahAngkaPage({super.key});

  @override
  _JumlahAngkaPageState createState() => _JumlahAngkaPageState();
}

class _JumlahAngkaPageState extends State<JumlahAngkaPage> {
  final TextEditingController _controller = TextEditingController();
  double _total = 0;
  int _banyakAngka = 0;
  bool _sudahDihitung = false;

  void _hitungTotal() {
    String input = _controller.text;
    
    // Regex untuk menangkap angka beraturan (bisa negatif atau desimal)
    // Contoh matches: "10", "-5", "3.14"
    RegExp regExp = RegExp(r'-?\d+(\.\d+)?');
    Iterable<Match> matches = regExp.allMatches(input);
    
    double total = 0;
    int count = 0;
    
    for (final Match m in matches) {
      if (m[0] != null) {
        total += double.tryParse(m[0]!) ?? 0;
        count++;
      }
    }

    setState(() {
      _total = total;
      _banyakAngka = count;
      _sudahDihitung = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Hitung Total Angka",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[800],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              Icon(Icons.calculate, size: 80, color: Colors.blue[800]),
              const SizedBox(height: 20),
              Text(
                "Jumlahkan Angka",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900]),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _controller,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Masukkan deretan angka atau kalimat disini...\nContoh: Beli apel 5 dan mangga 10",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue[800]!, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.blue[50],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  FocusScope.of(context).unfocus(); // Menyembunyikan keyboard
                  _hitungTotal();
                },
                icon: const Icon(Icons.add_circle_outline),
                label: const Text(
                  "Hitung Total",
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 40),
              if (_sudahDihitung)
                Column(
                  children: [
                    _buildResultCard("Angka Ditemukan", "$_banyakAngka angka", Icons.numbers),
                    const SizedBox(height: 15),
                    _buildResultCard(
                        "Total Jumlah",
                        _total == _total.toInt() ? _total.toInt().toString() : _total.toStringAsFixed(2),
                        Icons.functions),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard(String judul, String hasil, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue[100]!),
        boxShadow: [
          BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue[50],
            child: Icon(icon, color: Colors.blue[800]),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(judul,
                    style: TextStyle(color: Colors.blue[300], fontSize: 14)),
                Text(hasil,
                    style: TextStyle(
                        color: Colors.blue[900],
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
