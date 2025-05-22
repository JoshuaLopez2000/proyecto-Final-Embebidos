import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';

import 'temperatura.dart';

class TemperaturaGraphScreen extends StatefulWidget {
  const TemperaturaGraphScreen({super.key});

  @override
  State<TemperaturaGraphScreen> createState() => _TemperaturaGraphScreenState();
}

class _TemperaturaGraphScreenState extends State<TemperaturaGraphScreen> {
  final List<double> historial = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadTemperatura();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _loadTemperatura();
    });
  }

  Future<void> _loadTemperatura() async {
    try {
      final temp = await getTemperatura();
      setState(() {
        historial.add(temp);
        if (historial.length > 20) {
          historial.removeAt(0); // mantiene un máximo de 20 puntos
        }
      });
    } catch (e) {
      if (kDebugMode) print('Error al obtener temperatura: $e');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historial de Temperatura')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: historial.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : LineChart(
          LineChartData(
            minY: 10,
            maxY: 40,
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: false),
            lineBarsData: [
              LineChartBarData(
                isCurved: true,
                spots: List.generate(
                  historial.length,
                      (i) => FlSpot(i.toDouble(), historial[i]),
                ),
                dotData: FlDotData(show: false),
                color: Colors.blue,
                belowBarData: BarAreaData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
