import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchCustomUrl(context, String? url) async {
  if (url != null) {
    Uri uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Cannot launch $url')));
    }
  }
}
