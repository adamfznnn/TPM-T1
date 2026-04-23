import 'package:flutter/material.dart';

class SakaConverterApp extends StatefulWidget {
  @override
  _SakaConverterAppState createState() => _SakaConverterAppState();
}

class _SakaConverterAppState extends State<SakaConverterApp> {
  final TextEditingController _masehiController = TextEditingController();
  final TextEditingController _sakaController = TextEditingController();
  String _hasilSaka = "-";
  String _hasilMasehi = "-";

  void _hitungSaka() {
    if (_masehiController.text.isNotEmpty) {
      int masehi = int.tryParse(_masehiController.text) ?? 0;
      if (masehi > 0) {
        int saka = masehi - 78;
        setState(() {
          _hasilSaka = saka.toString();
        });
      }
    }
  }

  void _hitungMasehi() {
    if (_sakaController.text.isNotEmpty) {
      int saka = int.tryParse(_sakaController.text) ?? 0;
      if (saka > 0) {
        int masehi = saka + 78;
        setState(() {
          _hasilMasehi = masehi.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Konversi Tahun Saka",
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
              Icon(Icons.history_edu, size: 80, color: Colors.blue[800]),
              const SizedBox(height: 20),
              Text(
                "Masehi ke Saka",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _masehiController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Masukkan Tahun Masehi",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: Colors.blue[800],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _hitungSaka,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Konversi ke Saka",
                  style: TextStyle(fontSize: 16),
                ),
              ),

              if (_hasilSaka != "-")
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: [
                      Text(
                        "Hasil Konversi:",
                        style: TextStyle(fontSize: 16, color: Colors.blue[800]),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Tahun Saka: $_hasilSaka",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900],
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 40),
              const Divider(thickness: 2),
              const SizedBox(height: 20),

              Text(
                "Saka ke Masehi",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _sakaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Masukkan Tahun Saka",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.event, color: Colors.blue[800]),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _hitungMasehi,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Konversi ke Masehi",
                  style: TextStyle(fontSize: 16),
                ),
              ),

              if (_hasilMasehi != "-")
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: [
                      Text(
                        "Hasil Konversi:",
                        style: TextStyle(fontSize: 16, color: Colors.blue[800]),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Tahun Masehi: $_hasilMasehi",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
