import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: KalkulatorPage()),
  );
}

class KalkulatorPage extends StatefulWidget {
  @override
  _KalkulatorPageState createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  // Controller untuk mengontrol teks di dalam TextField
  TextEditingController _controller = TextEditingController(text: "0");

  String _currentInput = "";
  double _num1 = 0;
  String _operator = "";

  @override
  void initState() {
    super.initState();
    // Menyimak perubahan di TextField (jika user paste manual)
    _controller.addListener(() {
      String newText = _controller.text.replaceAll(',', '.');
      if (newText != _currentInput && double.tryParse(newText) != null) {
        _currentInput = newText;
      }
    });
  }

  String _formatDouble(double val) {
    String res = val.toString();
    if (res.endsWith('.0')) {
      res = res.substring(0, res.length - 2);
    }
    return res.replaceAll('.', ',');
  }

  void _updateDisplay(String text) {
    setState(() {
      _controller.text = text;
    });
  }

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _updateDisplay("0");
        _currentInput = "";
        _num1 = 0;
        _operator = "";
      } else if (value == "⌫") {
        if (_currentInput.isNotEmpty) {
          _currentInput = _currentInput.substring(0, _currentInput.length - 1);
          _updateDisplay(
            _currentInput.isEmpty ? "0" : _currentInput.replaceAll('.', ','),
          );
        }
      } else if (value == "+/-") {
        if (_currentInput.startsWith("-")) {
          _currentInput = _currentInput.substring(1);
        } else {
          _currentInput = "-" + (_currentInput.isEmpty ? "0" : _currentInput);
        }
        _updateDisplay(_currentInput.replaceAll('.', ','));
      } else if (value == ",") {
        if (!_currentInput.contains(".")) {
          _currentInput += (_currentInput.isEmpty ? "0." : ".");
          _updateDisplay(_currentInput.replaceAll('.', ','));
        }
      } else if (value == "+" || value == "-") {
        _num1 =
            double.tryParse(_currentInput) ??
            double.tryParse(_controller.text.replaceAll(',', '.')) ??
            0;
        _operator = value;
        _currentInput = "";
      } else if (value == "=") {
        if (_operator.isNotEmpty) {
          double num2 =
              double.tryParse(_currentInput) ??
              double.tryParse(_controller.text.replaceAll(',', '.')) ??
              0;
          double result = (_operator == "+") ? _num1 + num2 : _num1 - num2;

          String formatted = _formatDouble(result);
          _updateDisplay(formatted);
          _currentInput = result.toString();
          _operator = "";
        }
      } else {
        if (_currentInput == "0") {
          _currentInput = value;
        } else {
          _currentInput += value;
        }
        _updateDisplay(_currentInput.replaceAll('.', ','));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Kalkulator ", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              color: Colors.blue[50],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _operator.isNotEmpty
                        ? "${_formatDouble(_num1)} $_operator"
                        : "",
                    style: TextStyle(fontSize: 20, color: Colors.blue[300]),
                  ),
                  // MENGGUNAKAN TEXTFIELD AGAR BISA COPY-PASTE SEMPURNA
                  TextField(
                    controller: _controller,
                    readOnly: false, // Biarkan false agar menu paste muncul
                    showCursor: true,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none, // Hilangkan garis bawah
                      contentPadding: EdgeInsets.zero,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,-]')),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Tombol-tombol kalkulator
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton("C", Colors.red[50]!, Colors.red),
                    _buildButton("-", Colors.blue[50]!, Colors.blue[800]!),
                    _buildButton("+", Colors.blue[50]!, Colors.blue[800]!),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("7", Colors.white, Colors.black87),
                    _buildButton("8", Colors.white, Colors.black87),
                    _buildButton("9", Colors.white, Colors.black87),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("4", Colors.white, Colors.black87),
                    _buildButton("5", Colors.white, Colors.black87),
                    _buildButton("6", Colors.white, Colors.black87),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("1", Colors.white, Colors.black87),
                    _buildButton("2", Colors.white, Colors.black87),
                    _buildButton("3", Colors.white, Colors.black87),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("+/-", Colors.white, Colors.black87),
                    _buildButton("0", Colors.white, Colors.black87),
                    _buildButton(",", Colors.white, Colors.black87),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("⌫", Colors.blue[600]!, Colors.white),
                    _buildButton("=", Colors.blue[800]!, Colors.white),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color bgColor, Color textColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            foregroundColor: textColor,
            padding: EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
