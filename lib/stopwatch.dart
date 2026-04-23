import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: StopwatchPage()));
}

class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  final Duration _initialOffset = Duration(
    minutes: 0,
    seconds: 0,
    milliseconds: 00,
  );

  late String _displayTime;
  List<String> _laps = [];

  @override
  void initState() {
    super.initState();
    // Inisialisasi tampilan awal dengan offset yang ditentukan
    _displayTime = _formatTime(_initialOffset.inMilliseconds);
  }

  void _updateTime(Timer timer) {
    if (_stopwatch.isRunning && mounted) {
      setState(() {
        // Logika: Waktu berjalan + Waktu awal
        int totalMilliseconds =
            _stopwatch.elapsedMilliseconds + _initialOffset.inMilliseconds;
        _displayTime = _formatTime(totalMilliseconds);
      });
    }
  }

  String _formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate() % 100;
    int seconds = (milliseconds / 1000).truncate() % 60;
    int minutes = (milliseconds / 60000).truncate();

    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String hundredsStr = hundreds.toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr:$hundredsStr";
  }

  void _startStopwatch() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _timer = Timer.periodic(Duration(milliseconds: 30), _updateTime);
      setState(() {});
    }
  }

  void _pauseStopwatch() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer?.cancel();
      setState(() {});
    }
  }

  void _recordLap() {
    if (_stopwatch.isRunning) {
      setState(() {
        _laps.insert(0, _displayTime);
      });
    }
  }

  void _resetStopwatch() {
    _stopwatch.stop();
    _stopwatch.reset();
    _timer?.cancel();
    setState(() {
      // Kembali ke waktu awal (offset), bukan ke 00:00:00
      _displayTime = _formatTime(_initialOffset.inMilliseconds);
      _laps.clear();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Stopwatch Custom Start",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[800],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          SizedBox(height: 80),
          Text(
            _displayTime,
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
              fontFamily: 'monospace',
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Mulai dari: ${_formatTime(_initialOffset.inMilliseconds)}",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_stopwatch.isRunning)
                _buildButton(
                  Icons.play_arrow,
                  Colors.green,
                  _startStopwatch,
                  "Mulai",
                )
              else
                _buildButton(
                  Icons.pause,
                  Colors.amber[700]!,
                  _pauseStopwatch,
                  "Pause",
                ),

              SizedBox(width: 20),

              _buildButton(
                Icons.timer,
                _stopwatch.isRunning ? Colors.orange : Colors.grey,
                _recordLap,
                "Catat",
              ),

              SizedBox(width: 20),

              _buildButton(Icons.refresh, Colors.red, _resetStopwatch, "Reset"),
            ],
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Daftar Waktu :",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: _laps.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Lap ${_laps.length - index}"),
                      Text(
                        _laps[index],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    IconData icon,
    Color color,
    VoidCallback onPressed,
    String tooltip,
  ) {
    return Column(
      children: [
        FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: color,
          heroTag: null,
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        SizedBox(height: 8),
        Text(tooltip, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}
