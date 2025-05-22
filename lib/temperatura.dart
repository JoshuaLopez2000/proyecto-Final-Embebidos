import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web/web.dart' as web;

/// Obtiene la URL base según el host actual
String getBaseUrl() {
  final host = web.window.location.hostname;
  //return 'http://$host:5000/api/temperatura';
  return 'http://10.42.0.63:5000/api/temperatura';
}

/// Llama al endpoint para obtener la temperatura
Future<double> getTemperatura() async {
  final url = Uri.parse(getBaseUrl());
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['valor'] * 1.0;
  } else {
    throw Exception('Error al obtener temperatura');
  }
}

/// Widget principal que muestra la temperatura actual
class ShowData extends StatefulWidget {
  const ShowData({super.key});

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  double? temperatura;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadTemperatura(); // primer fetch
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _loadTemperatura();
    });
  }

  void _loadTemperatura() async {
    try {
      final temp = await getTemperatura();
      setState(() {
        temperatura = temp;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error al obtener temperatura: $e');
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          temperatura != null
              ? AutoSizeText(
                'Temperatura: ${temperatura!.toStringAsFixed(1)} °C',
                style: const TextStyle(fontSize: 24),
                maxLines: 1,
              )
              : const CircularProgressIndicator(),
    );
  }
}
