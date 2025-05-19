import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

class IntegrantesScreen extends StatelessWidget {
  const IntegrantesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Integrantes', textAlign: TextAlign.center),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              child: ResponsiveRowColumn(
                layout:
                    isDesktop
                        ? ResponsiveRowColumnType.ROW
                        : ResponsiveRowColumnType.COLUMN,
                rowMainAxisAlignment: MainAxisAlignment.center,
                columnMainAxisAlignment: MainAxisAlignment.center,
                rowSpacing: MediaQuery.of(context).size.width * 0.05,
                columnSpacing: 30,
                children: [
                  ResponsiveRowColumnItem(
                    child: _buildIntegrante(
                      name: 'López Nava Joshua',
                      assetPicture:
                          'Assets/Captura de pantalla 2025-03-29 111038.png',
                      context: context,
                      email: 'joshua.lopez@fi.unam.edu',
                      numeroDeCuenta: '317309733',
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    child: _buildIntegrante(
                      name: 'Test',
                      assetPicture:
                          'Assets/Captura de pantalla 2025-03-29 111038.png',
                      context: context,
                      email: 'correo@correo.com',
                      numeroDeCuenta: '123456789',
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    child: _buildIntegrante(
                      name: 'Test',
                      assetPicture:
                          'Assets/Captura de pantalla 2025-03-29 111038.png',
                      context: context,
                      email: 'correo@correo.com',
                      numeroDeCuenta: '123456789',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildIntegrante({
  required String assetPicture,
  required String name,
  required String email,
  required String numeroDeCuenta,
  required BuildContext context,
}) {
  bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircleAvatar(
        radius:
            !isDesktop
                ? MediaQuery.sizeOf(context).height * 0.05
                : MediaQuery.sizeOf(context).width * 0.1,
        backgroundImage: Image.asset(assetPicture).image,
      ),
      SizedBox(
        width:
            isDesktop
                ? MediaQuery.of(context).size.width * 0.2
                : MediaQuery.of(context).size.width * 0.85,
        child: Card(
          child: ListTile(
            leading: Icon(Icons.person),
            title: AutoSizeText(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24.0),
              maxLines: 2,
            ),
            subtitle: AutoSizeText(
              numeroDeCuenta,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24.0),
              maxLines: 1,
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () async {
          final uri = Uri(scheme: 'mailto', path: email);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
        child: SizedBox(
          width:
              isDesktop
                  ? MediaQuery.of(context).size.width * 0.2
                  : MediaQuery.of(context).size.width * 0.85,
          child: Card(
            child: ListTile(
              leading: Icon(Icons.email),
              title: AutoSizeText(
                email,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24.0, color: Colors.blue),
                maxLines: 2,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
