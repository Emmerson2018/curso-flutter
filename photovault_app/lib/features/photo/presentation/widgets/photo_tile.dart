import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../features/photo/domain/entities/photo.dart';
import '../screens/photo_detail_screen.dart';

class PhotoTile extends StatelessWidget {
  final Photo photo;
  const PhotoTile({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'photo_${photo.id}',
      child: GestureDetector(
        onTap: () => Navigator.push(context, PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (_, _, _) => PhotoDetailScreen(photo: photo),
          transitionsBuilder: (_, anim, _, child) =>
              FadeTransition(opacity: anim, child: child),
        )),
        child: photo.remoteUrl != null
          ? CachedNetworkImage(
              imageUrl: photo.remoteUrl!,
              fit: BoxFit.cover,
              placeholder: (_, _) => Container(color: Colors.grey[850]),
              errorWidget: (_, _, _) => const Icon(Icons.broken_image, color: Colors.grey),
            )
          : Image.file(File(photo.localPath), fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const Icon(Icons.broken_image, color: Colors.grey)),
      ),
    );
  }
}