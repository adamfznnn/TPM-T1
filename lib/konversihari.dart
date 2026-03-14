import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JavaCalendarPage extends StatefulWidget {
  @override
  _JavaCalendarPageState createState() => _JavaCalendarPageState();
}

class _JavaCalendarPageState extends State<JavaCalendarPage> {
  DateTime? _selectedDate;
  String _hariNama = "-";
  String _pasaranNama = "-";

  // Urutan Pasaran Jawa yang benar
  final List<String> _pasaranList = [
    'Wage', // Indeks 0
    'Kliwon', // Indeks 1
    'Legi', // Indeks 2
    'Pahing', // Indeks 3
    'Pon', // Indeks 4
  ];

  void _hitungHariDanPasaran(DateTime date) {
    // 1. Nama Hari Masehi (Senin, Selasa, dst)
    String hari = DateFormat('EEEE', 'id_ID').format(date);

    // 2. Hitung Pasaran berdasarkan referensi 13 Maret 2026 = Wage
    // Kita gunakan UTC untuk menghindari selisih jam/timezone
    DateTime referenceDate = DateTime.utc(2026, 3, 13);
    DateTime targetDate = DateTime.utc(date.year, date.month, date.day);

    int diffInDays = targetDate.difference(referenceDate).inDays;

    // Hitung indeks pasaran (Modulo 5)
    int indexPasaran = diffInDays % 5;

    // Jika tanggal yang dipilih sebelum referensi (hasil modulo negatif)
    if (indexPasaran < 0) indexPasaran += 5;

    setState(() {
      _selectedDate = date;
      _hariNama = hari;
      _pasaranNama = _pasaranList[indexPasaran];
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      locale: const Locale('id', 'ID'), // Ini akan pakai bahasa Indonesia
    );
    if (picked != null) {
      _hitungHariDanPasaran(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Konversi Hari Pasaran",
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
              Icon(Icons.event_note, size: 80, color: Colors.blue[800]),
              const SizedBox(height: 20),
              Text(
                "Cek Hari & Pasaran",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue[900]),
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () => _selectDate(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "Pilih Tanggal",
                  style: TextStyle(fontSize: 16),
                ),
              ),

              const SizedBox(height: 40),

              // Tampilan Hasil
              if (_selectedDate != null)
                Column(
                  children: [
                    Text(
                      DateFormat('dd MMMM yyyy', 'id_ID').format(_selectedDate!),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue[800]),
                    ),
                    const SizedBox(height: 20),
                    _buildResultCard("Hari", _hariNama, Icons.calendar_today),
                    const SizedBox(height: 15),
                    _buildResultCard("Pasaran", _pasaranNama, Icons.brightness_high),
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
          BoxShadow(color: Colors.blue.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue[50],
            child: Icon(icon, color: Colors.blue[800]),
          ),
          const SizedBox(width: 20),
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
