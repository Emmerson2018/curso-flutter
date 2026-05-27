import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photovault_app/features/photo/domain/entities/photo.dart';
import 'package:photovault_app/features/photo/presentation/providers/photo_providers.dart';
import 'package:photovault_app/main.dart';

void main() {
  testWidgets('PhotoVaultApp inicializa com ProviderScope e galeria vazia',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          photoGalleryStreamProvider.overrideWith(
            (ref) => Stream<List<Photo>>.value(const <Photo>[]),
          ),
        ],
        child: const PhotoVaultApp(),
      ),
    );

    await tester.pump();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('PhotoVault'), findsOneWidget);
    expect(find.text('Galeria vazia'), findsOneWidget);
    expect(find.text('Toque na câmera para começar'), findsOneWidget);
  });
}
