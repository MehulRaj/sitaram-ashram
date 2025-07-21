import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/animated_card.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/home_footer.dart';
import '../widgets/background_container.dart';
import '../utils/responsive_utils.dart';

class AboutPage extends StatefulWidget {
  final void Function(String route)? onNav;
  const AboutPage({super.key, this.onNav});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late final AssetImage _bgImage;
  bool _bgReady = false;
  bool _didPrecache = false;

  @override
  void initState() {
    super.initState();
    _bgImage = const AssetImage('assets/images/calf_barn.jpg');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didPrecache) {
      _didPrecache = true;
      precacheImage(_bgImage, context).then((_) {
        if (mounted) setState(() => _bgReady = true);
      });
    }
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
    final isMobile = MediaQuery.of(context).size.width < 700;
    final headlineStyle = GoogleFonts.mukta(
      textStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
    );
    final subheadStyle = GoogleFonts.mukta(
      textStyle: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w500,
      ),
    );
    final bodyStyle = GoogleFonts.mukta(
      textStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeight.w400,
      ),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BackgroundContainer(
        image: _bgImage,
        overlayColor: Color.fromRGBO(0, 0, 0, 0.45),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Hero Section with 3D animation
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUtils.cardHorizontalPadding(context),
                    vertical: ResponsiveUtils.isSmallScreen(context) ? 24 : 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HoverBeat(
                      builder: (context, hovered) => HeartbeatText(
                        text: l10n.aboutTitle,
                        style: headlineStyle.copyWith(
                          fontSize: ResponsiveUtils.fontSize(context,
                              small: 28, medium: 36, large: 44),
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        beat: hovered,
                        duration: Duration(milliseconds: 3200),
                      ),
                    ),
                    const SizedBox(height: 20),
                    HoverBeat(
                      builder: (context, hovered) => HeartbeatText(
                        text: l10n.aboutDetailedCreative,
                        style: subheadStyle.copyWith(
                          fontSize: ResponsiveUtils.fontSize(context,
                              small: 14, medium: 18, large: 22),
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                        beat: hovered,
                        duration: Duration(milliseconds: 3200),
                      ),
                    ),
                  ],
                ),
              ),
              // Animated Cards for Story, Mission, Why Support
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUtils.cardHorizontalPadding(context),
                    vertical: ResponsiveUtils.isSmallScreen(context) ? 16 : 32),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 32,
                  runSpacing: 32,
                  children: [
                    HoverBeat(
                      builder: (context, hovered) => AnimatedCard(
                        child: Column(
                          children: [
                            HeartbeatIcon(
                              icon: Icon(Icons.auto_stories,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 40),
                              beat: hovered,
                              duration: Duration(milliseconds: 3200),
                            ),
                            const SizedBox(height: 12),
                            HeartbeatText(
                              text: l10n.ourStoryTitle,
                              style: GoogleFonts.mukta(
                                fontSize: ResponsiveUtils.fontSize(context,
                                    small: 16, medium: 20, large: 24),
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              textAlign: TextAlign.center,
                              beat: hovered,
                              duration: Duration(milliseconds: 3200),
                            ),
                            const SizedBox(height: 12),
                            HeartbeatText(
                              text: l10n.aboutStoryCreative,
                              style: GoogleFonts.mukta(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              textAlign: TextAlign.center,
                              beat: hovered,
                              duration: Duration(milliseconds: 3200),
                            ),
                          ],
                        ),
                      ),
                    ),
                    HoverBeat(
                      builder: (context, hovered) => AnimatedCard(
                        child: Column(
                          children: [
                            HeartbeatIcon(
                              icon: Icon(Icons.flag,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 40),
                              beat: hovered,
                              duration: Duration(milliseconds: 3200),
                            ),
                            const SizedBox(height: 12),
                            HeartbeatText(
                              text: l10n.ourMissionTitle,
                              style: GoogleFonts.mukta(
                                fontSize: ResponsiveUtils.fontSize(context,
                                    small: 16, medium: 20, large: 24),
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              textAlign: TextAlign.center,
                              beat: hovered,
                              duration: Duration(milliseconds: 3200),
                            ),
                            const SizedBox(height: 12),
                            HeartbeatText(
                              text: l10n.aboutMissionCreative,
                              style: GoogleFonts.mukta(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              textAlign: TextAlign.center,
                              beat: hovered,
                              duration: Duration(milliseconds: 3200),
                            ),
                          ],
                        ),
                      ),
                    ),
                    HoverBeat(
                      builder: (context, hovered) => AnimatedCard(
                        child: Column(
                          children: [
                            HeartbeatIcon(
                              icon: Icon(Icons.volunteer_activism,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 40),
                              beat: hovered,
                              duration: Duration(milliseconds: 3200),
                            ),
                            const SizedBox(height: 12),
                            HeartbeatText(
                              text: l10n.whySupportTitle,
                              style: GoogleFonts.mukta(
                                fontSize: ResponsiveUtils.fontSize(context,
                                    small: 16, medium: 20, large: 24),
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              textAlign: TextAlign.center,
                              beat: hovered,
                              duration: Duration(milliseconds: 3200),
                            ),
                            const SizedBox(height: 12),
                            HeartbeatText(
                              text: l10n.aboutWhySupportCreative,
                              style: GoogleFonts.mukta(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              textAlign: TextAlign.center,
                              beat: hovered,
                              duration: Duration(milliseconds: 3200),
                            ),
                          ],
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
      ),
    );
  }
}
