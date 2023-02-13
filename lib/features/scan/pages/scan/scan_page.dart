import 'package:flutter/material.dart';
import 'package:menu/core/widgets/core_page_title.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CorePageTitle(
                title: 'Bem-vindo(a)! ao Startto\'s Mexican Food',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Text(
                  'Para acessar o cardápio, abra sua câmera e escaneie o QR Code localizado em sua mesa.',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff212730),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: const Icon(
                      Icons.qr_code_scanner,
                      size: 200,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
