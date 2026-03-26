import 'package:flutter/material.dart';

class KalkulatorPage extends StatefulWidget {
  @override
  _KalkulatorPageState createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  String _output = "0";
  String _currentInput = "";
  double _num1 = 0;
  String _operator = "";

  String _formatDouble(double val) {
    String res = val.toString();
    if (res.endsWith('.0')) {
      res = res.substring(0, res.length - 2);
    }
    return res.replaceAll('.', ',');
  }

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _currentInput = "";
        _num1 = 0;
        _operator = "";
      } else if (value == "⌫") {
        if (_currentInput.isNotEmpty) {
          _currentInput = _currentInput.substring(0, _currentInput.length - 1);
          if (_currentInput == "-" || _currentInput.isEmpty) {
            _currentInput = "";
            _output = "0";
          } else {
            _output = _currentInput;
          }
        }
      } else if (value == "+/-") {
        if (_currentInput.isEmpty) {
          _currentInput = "-";
          _output = "-";
        } else if (_currentInput == "-") {
          _currentInput = "";
          _output = "0";
        } else {
          if (_currentInput.startsWith("-")) {
            _currentInput = _currentInput.substring(1);
          } else {
            _currentInput = "-" + _currentInput;
          }
          _output = _currentInput;
        }
      } else if (value == ",") {
        if (!_currentInput.contains(",")) {
          if (_currentInput.isEmpty || _currentInput == "0") {
            _currentInput = "0,";
          } else if (_currentInput == "-") {
            _currentInput = "-0,";
          } else {
            _currentInput += ",";
          }
          _output = _currentInput;
        }
      } else if (value == "+" || value == "-") {
        _num1 = double.tryParse(_output.replaceAll(',', '.')) ?? 0;
        _operator = value;
        _currentInput = "";
      } else if (value == "=") {
        if (_operator.isNotEmpty) {
          double num2 = double.tryParse(_output.replaceAll(',', '.')) ?? 0;
          double result = 0;
          if (_operator == "+") {
            result = _num1 + num2;
          } else if (_operator == "-") {
            result = _num1 - num2;
          }
          _output = _formatDouble(result);
          _currentInput = _output;
          _operator = "";
        }
      } else {
        if (_currentInput == "0") {
          _currentInput = value;
        } else {
          _currentInput += value;
        }
        _output = _currentInput;
      }
    });
  }

  Widget _buildButton(String text, Color bgColor, Color textColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            foregroundColor: textColor,
            elevation: 2,
            padding: EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Kalkulator Penjumlahan & Pengurangan",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[800],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Display Area
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                border: Border(
                  bottom: BorderSide(color: Colors.blue[100]!, width: 2),
                ),
              ),
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
                  Text(
                    _output,
                    style: TextStyle(
                      fontSize: 60,
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Button Grid
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
}
