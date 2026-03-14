import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CekUmurPage extends StatefulWidget {
  @override
  _CekUmurPageState createState() => _CekUmurPageState();
}

class _CekUmurPageState extends State<CekUmurPage> {
  DateTime? _birthDate;
  Timer? _timer;

  int _years = 0;
  int _months = 0;
  int _days = 0;
  int _hours = 0;
  int _minutes = 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _calculateAge() {
    if (_birthDate == null) return;

    DateTime now = DateTime.now();
    int years = now.year - _birthDate!.year;
    int months = now.month - _birthDate!.month;
    int days = now.day - _birthDate!.day;
    int hours = now.hour - _birthDate!.hour;
    int minutes = now.minute - _birthDate!.minute;

    if (minutes < 0) {
      hours -= 1;
      minutes += 60;
    }
    if (hours < 0) {
      days -= 1;
      hours += 24;
    }
    if (days < 0) {
      months -= 1;
      final int daysInPrevMonth = DateTime(now.year, now.month, 0).day;
      days += daysInPrevMonth;
    }
    if (months < 0) {
      years -= 1;
      months += 12;
    }

    if (mounted) {
      setState(() {
        _years = years;
        _months = months;
        _days = days;
        _hours = hours;
        _minutes = minutes;
      });
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('id', 'ID'),
    );

    if (pickedDate != null) {
      setState(() {
        _birthDate = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          0,
          0,
        );
      });
      _calculateAge();
      _timer?.cancel();
      // Update setiap 1 menit sudah cukup untuk tampilan menit
      _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
        _calculateAge();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Cek Umur", style: TextStyle(color: Colors.white)),
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
              Icon(Icons.cake, size: 80, color: Colors.blue[800]),
              const SizedBox(height: 20),
              Text(
                "Hitung Detail Umur Anda",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900]),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => _selectDateTime(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "Pilih Tanggal Lahir",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 40),
              if (_birthDate != null)
                Column(
                  children: [
                    Text(
                      "Tanggal Lahir: ${DateFormat('dd MMMM yyyy', 'id_ID').format(_birthDate!)}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800]),
                    ),
                    const SizedBox(height: 20),
                    _buildResultCard("Tahun", "$_years", Icons.calendar_today),
                    const SizedBox(height: 15),
                    _buildResultCard("Bulan", "$_months", Icons.date_range),
                    const SizedBox(height: 15),
                    _buildResultCard("Hari", "$_days", Icons.today),
                    const SizedBox(height: 15),
                    _buildResultCard("Jam", "$_hours", Icons.access_time),
                    const SizedBox(height: 15),
                    _buildResultCard("Menit", "$_minutes", Icons.access_time_filled),
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
          Column(
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
        ],
      ),
    );
  }
}
