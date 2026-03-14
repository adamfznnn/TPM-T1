import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('id_ID', null).then((_) {
    runApp(
      const MaterialApp(
        home: CekBulanPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  });
}

class CekBulanPage extends StatefulWidget {
  const CekBulanPage({super.key});

  @override
  State<CekBulanPage> createState() => _CekBulanPageState();
}

class _CekBulanPageState extends State<CekBulanPage> {
  String hasilMasehi = "";
  String hasilHijriah = "";

  // 1. Konversi Masehi ke Hijriah menggunakan DatePicker Bawaan
  Future<void> pilihTanggalMasehi() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      locale: const Locale('id', 'ID'),
    );

    if (picked != null) {
      setState(() {
        HijriCalendar hijri = HijriCalendar.fromDate(picked);
        hasilHijriah = "${hijri.hDay} ${hijri.longMonthName} ${hijri.hYear} H";
        hasilMasehi = DateFormat("dd MMMM yyyy", "id_ID").format(picked);
      });
    }
  }

  // 2. Dialog untuk Memilih Tanggal Hijriah secara Manual
  void dialogPilihHijriah() {
    int selDay = HijriCalendar.now().hDay;
    int selMonth = HijriCalendar.now().hMonth;
    int selYear = HijriCalendar.now().hYear;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Pilih Tanggal Hijriah"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  // Dropdown Hari
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      decoration: const InputDecoration(labelText: "Tgl"),
                      value: selDay,
                      items: List.generate(30, (i) => i + 1)
                          .map(
                            (e) =>
                                DropdownMenuItem(value: e, child: Text("$e")),
                          )
                          .toList(),
                      onChanged: (v) => selDay = v!,
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Dropdown Bulan
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<int>(
                      decoration: const InputDecoration(labelText: "Bulan"),
                      value: selMonth,
                      items: List.generate(12, (i) => i + 1)
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(getNamaBulanHijriah(e)),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => selMonth = v!,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Input Tahun
              TextFormField(
                decoration: const InputDecoration(labelText: "Tahun (H)"),
                initialValue: selYear.toString(),
                keyboardType: TextInputType.number,
                onChanged: (v) => selYear = int.tryParse(v) ?? selYear,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                konversiHijriahKeMasehi(selDay, selMonth, selYear);
                Navigator.pop(context);
              },
              child: const Text("Konversi"),
            ),
          ],
        );
      },
    );
  }

  // Fungsi Inti Konversi Hijriah -> Masehi
  void konversiHijriahKeMasehi(int hari, int bulan, int tahun) {
    try {
      HijriCalendar h = HijriCalendar();
      // Gunakan fungsi hijriToGregorian dengan parameter eksplisit
      DateTime masehiRes = h.hijriToGregorian(tahun, bulan, hari);

      setState(() {
        // Refresh objek hijri dari tanggal masehi agar sinkron (nama bulan dsb)
        HijriCalendar hijriFix = HijriCalendar.fromDate(masehiRes);
        hasilHijriah =
            "${hijriFix.hDay} ${hijriFix.longMonthName} ${hijriFix.hYear} H";
        hasilMasehi = DateFormat("dd MMMM yyyy", "id_ID").format(masehiRes);
      });
    } catch (e) {
      // Handle jika tanggal hijriah tidak valid (misal 30 Ramadhan padahal cuma 29)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tanggal Hijriah tidak valid!")),
      );
    }
  }

  String getNamaBulanHijriah(int bulan) {
    List<String> months = [
      "Muharram",
      "Safar",
      "Rabi'ul Awal",
      "Rabi'ul Akhir",
      "Jumadil Ula",
      "Jumadil Akhira",
      "Rajab",
      "Sya'ban",
      "Ramadhan",
      "Syawal",
      "Dzulqa'dah",
      "Dzulhijjah",
    ];
    return months[bulan - 1];
  }

  Widget buildCard(String title, String value, IconData icon) {
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
                Text(title,
                    style: TextStyle(color: Colors.blue[300], fontSize: 14)),
                Text(value,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Konverter Masehi-Hijriah", style: TextStyle(color: Colors.white)),
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
              Icon(Icons.sync_alt, size: 80, color: Colors.blue[800]),
              const SizedBox(height: 20),
              Text(
                "Konversi Masehi & Hijriah",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900]),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: pilihTanggalMasehi,
                icon: const Icon(Icons.calendar_month),
                label: const Text(
                  "Pilih Tanggal Masehi",
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
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: dialogPilihHijriah,
                icon: const Icon(Icons.mosque),
                label: const Text(
                  "Pilih Tanggal Hijriah",
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
              if (hasilMasehi.isNotEmpty || hasilHijriah.isNotEmpty)
                Column(
                  children: [
                    if (hasilMasehi.isNotEmpty) ...[
                      buildCard("Tanggal Masehi", hasilMasehi, Icons.event),
                      const SizedBox(height: 15),
                    ],
                    if (hasilHijriah.isNotEmpty)
                      buildCard("Tanggal Hijriah", hasilHijriah, Icons.star),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
