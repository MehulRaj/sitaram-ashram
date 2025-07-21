import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/url_utils.dart';
import 'animated_card.dart';

class HomeFooter extends StatefulWidget {
  const HomeFooter({super.key});

  @override
  State<HomeFooter> createState() => _HomeFooterState();
}

class _HomeFooterState extends State<HomeFooter> {
  final bool _hoveredEmail = false;
  final bool _hoveredFacebook = false;
  final bool _hoveredInstagram = false;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      // color: Colors.black,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/cows-1.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.75),
            BlendMode.darken,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          HeartbeatText(
            text: l10n.appTitle,
            style: GoogleFonts.mukta(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
            beat: false,
            duration: const Duration(milliseconds: 3200),
          ),
          const SizedBox(height: 12),
          Text(
            '© 2024 Sitaram Ashram. All rights reserved.',
            style: GoogleFonts.mukta(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HoverBeat(
                builder: (context, hovered) => IconButton(
                  icon: HeartbeatIcon(
                    icon: const Icon(Icons.email, color: Colors.white),
                    beat: hovered,
                    duration: const Duration(milliseconds: 3200),
                  ),
                  onPressed: () => launchAppUrl('mailto:mpgvka@gmail.com'),
                  tooltip: l10n.contactEmail,
                ),
              ),
              HoverBeat(
                builder: (context, hovered) => IconButton(
                  icon: HeartbeatIcon(
                    icon: const Icon(Icons.facebook, color: Colors.white),
                    beat: hovered,
                    duration: const Duration(milliseconds: 3200),
                  ),
                  onPressed: () => launchAppUrl('https://facebook.com'),
                  tooltip: 'Facebook',
                ),
              ),
              HoverBeat(
                builder: (context, hovered) => IconButton(
                  icon: HeartbeatIcon(
                    icon: const Icon(Icons.camera_alt, color: Colors.white),
                    beat: hovered,
                    duration: const Duration(milliseconds: 3200),
                  ),
                  onPressed: () => launchAppUrl('https://instagram.com'),
                  tooltip: 'Instagram',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
