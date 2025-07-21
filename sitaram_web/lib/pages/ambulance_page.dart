import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/url_utils.dart';
import '../theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/animated_card.dart';
import '../widgets/animated_button.dart';
import '../widgets/home_footer.dart';
import '../widgets/background_container.dart';

class AmbulancePage extends StatefulWidget {
  const AmbulancePage({super.key});

  @override
  State<AmbulancePage> createState() => _AmbulancePageState();
}

class _AmbulancePageState extends State<AmbulancePage> {
  bool _bgReady = false;

  @override
  void initState() {
    super.initState();
    _precacheBg();
  }

  void _precacheBg() async {
    await precacheImage(
        const AssetImage('assets/images/cow_feeding_street.jpg'), context);
    if (mounted) setState(() => _bgReady = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_bgReady) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BackgroundContainer(
        imagePath: 'assets/images/cow_feeding_street.jpg',
        overlayColor: Color.fromRGBO(0, 0, 0, 0.38),
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 3D Animated Section Header
                Stack(
                  children: [
                    Positioned(
                      top: -30,
                      left: 0,
                      right: 0,
                      child: IgnorePointer(
                        child: Opacity(
                          opacity: 0.7,
                          child: SizedBox(
                            width: 320,
                            height: 120,
                            // TODO: Replace with actual Rive/Lottie asset
                            child: Image.asset(
                              'assets/images/3d_ambulance_header.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        l10n.ambulanceTitle,
                        style: GoogleFonts.mukta(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.primary,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.10),
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(duration: 700.ms),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.ambulanceDesc,
                  style: GoogleFonts.mukta(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(
                    begin: 0.2, end: 0, duration: 600.ms, delay: 200.ms),
                const SizedBox(height: 32),
                AnimatedButton(
                  text: l10n.ambulanceRequest,
                  onPressed: () => launchAppUrl('tel:+911234567890'),
                  icon: const Icon(Icons.local_hospital),
                ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideY(
                    begin: 0.2, end: 0, duration: 600.ms, delay: 400.ms),
                HomeFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
