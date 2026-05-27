import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/photo/presentation/screens/gallery_screen.dart';

void main() {
  runApp(
    const ProviderScope(child: PhotoVaultApp()),
  );
}

class PhotoVaultApp extends StatelessWidget {
  const PhotoVaultApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhotoVault',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const GalleryScreen(),
    );
  }
}
