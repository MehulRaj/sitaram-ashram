import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

Future<void> launchAppUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}

Future<void> precacheImages(
    BuildContext context, List<ImageProvider> images) async {
  for (final image in images) {
    await precacheImage(image, context);
  }
}
