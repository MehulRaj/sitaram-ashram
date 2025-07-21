import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/url_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/animated_card.dart';
import '../widgets/animated_button.dart';
import '../widgets/home_footer.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  bool _bgReady = false;

  @override
  void initState() {
    super.initState();
    _precacheBg();
  }

  void _precacheBg() async {
    await precacheImage(
        const AssetImage('assets/images/cow_calf_field.jpg'), context);
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/cow_calf_field.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.35),
              BlendMode.darken,
            ),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: AnimatedCard(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 24.0),
                          child: HoverBeat(
                            builder: (context, hovered) => Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                HeartbeatText(
                                  text: l10n.contactTitle,
                                  style: GoogleFonts.mukta(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  textAlign: TextAlign.center,
                                  beat: hovered,
                                  duration: Duration(milliseconds: 3200),
                                ),
                                const SizedBox(height: 12),
                                HeartbeatText(
                                  text: l10n.contactDesc,
                                  style: GoogleFonts.mukta(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  textAlign: TextAlign.center,
                                  beat: hovered,
                                  duration: Duration(milliseconds: 3200),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    HeartbeatIcon(
                                      icon: Icon(Icons.email,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      beat: hovered,
                                      duration: Duration(milliseconds: 3200),
                                    ),
                                    const SizedBox(width: 24),
                                    HeartbeatIcon(
                                      icon: Icon(Icons.facebook,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      beat: hovered,
                                      duration: Duration(milliseconds: 3200),
                                    ),
                                    const SizedBox(width: 24),
                                    HeartbeatIcon(
                                      icon: Icon(Icons.camera_alt,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      beat: hovered,
                                      duration: Duration(milliseconds: 3200),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            HomeFooter(),
          ],
        ),
      ),
    );
  }
}
