import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/photo.dart';
import '../screens/photo_detail_screen.dart';

class PhotoTile extends StatelessWidget {
  final Photo photo;
  const PhotoTile({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'photo_${photo.id}',
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (ctx, anim, secondary) =>
                PhotoDetailScreen(photo: photo),
            transitionsBuilder: (ctx, anim, secondary, child) =>
                FadeTransition(opacity: anim, child: child),
          ),
        ),
        child: photo.remoteUrl != null
            ? CachedNetworkImage(
                imageUrl:    photo.remoteUrl!,
                fit:         BoxFit.cover,
                placeholder: (ctx, url) =>
                    Container(color: Colors.grey[850]),
                errorWidget: (ctx, url, err) =>
                    const Icon(Icons.broken_image, color: Colors.grey),
              )
            : Image.file(
                File(photo.localPath),
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, stack) =>
                    const Icon(Icons.broken_image, color: Colors.grey),
              ),
      ),
    );
  }
}
