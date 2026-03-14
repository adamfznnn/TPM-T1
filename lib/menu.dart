import 'package:flutter/material.dart';
import 'package:tugasmobile/konversihari.dart';
import 'kelompok.dart';
import 'kalkulator.dart';
import 'bilangan.dart';
import 'stopwatch.dart';
import 'login.dart';
import 'piramid.dart';
import 'cek_umur.dart';
import 'cek_bulan.dart';
import 'jumlah_angka.dart';

class MenuPage extends StatelessWidget {
  final String username;

  const MenuPage({Key? key, required this.username}) : super(key: key);

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget page,
    required List<Color> gradientColors,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 40, color: Colors.white),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Menu Utama",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade800, Colors.blue.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting Section
              SizedBox(height: 10),
              Text(
                "Welcome, $username! 👋",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.indigo.shade900,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Silakan pilih menu yang tersedia di bawah ini.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 40),

              // Menu List
              _buildMenuCard(
                context,
                title: "Data Kelompok",
                subtitle: "Lihat informasi anggota dan mata kuliah",
                icon: Icons.groups_rounded,
                page: KelompokPage(),
                gradientColors: [Colors.blue.shade700, Colors.blue.shade400],
              ),

              // Anda bisa dengan mudah menambahkan menu lainnya di sini meniru _buildMenuCar
              _buildMenuCard(
                context,
                title: "Kalkulator",
                subtitle: "Penjumlahan dan Pengurangan Angka",
                icon: Icons.calculate,
                page: KalkulatorPage(),
                gradientColors: [Colors.blue.shade700, Colors.blue.shade400],
              ),

              _buildMenuCard(
                context,
                title: "Input Bilangan",
                subtitle: "Input Bilangan Ganjil/Genap dan Bilangan Prima",
                icon: Icons.numbers,
                page: BilanganPage(),
                gradientColors: [Colors.blue.shade700, Colors.blue.shade400],
              ),

              _buildMenuCard(
                context,
                title: "Stopwatch",
                subtitle: "Mengukur Durasi Waktu yang Singkat atau Panjang",
                icon: Icons.access_alarm,
                page: StopwatchPage(),
                gradientColors: [Colors.blue.shade700, Colors.blue.shade400],
              ),

              _buildMenuCard(
                context,
                title: "Hitung Luas dan Volume Piramid",
                subtitle: "Kalkulator untuk menghitung luas dan volume piramid",
                icon: Icons.architecture,
                page: PiramidPage(),
                gradientColors: [Colors.blue.shade700, Colors.blue.shade400],
              ),

              _buildMenuCard(
                context,
                title: "Konversi",
                subtitle: "Konversi Tanggal ke Hari dan Hari Pasaran",
                icon: Icons.calendar_today,
                page: JavaCalendarPage(),
                gradientColors: [Colors.blue.shade700, Colors.blue.shade400],
              ),
              _buildMenuCard(
                context,
                title: "Cek Umur",
                subtitle: "Hitung Umur Detail Menurut Waktu Lahir",
                icon: Icons.cake,
                page: CekUmurPage(),
                gradientColors: [Colors.blue.shade700, Colors.blue.shade400],
              ),
              _buildMenuCard(
                context,
                title: "Cek Bulan",
                subtitle: "Konversi Tanggal Masehi dan Hijriah",
                icon: Icons.calendar_month,
                page: CekBulanPage(),
                gradientColors: [Colors.blue.shade700, Colors.blue.shade400],
              ),
              _buildMenuCard(
                context,
                title: "Jumlah Angka",
                subtitle: "Menjumlahkan Angka",
                icon: Icons.add_circle_outline,
                page: JumlahAngkaPage(),
                gradientColors: [Colors.blue.shade700, Colors.blue.shade400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
