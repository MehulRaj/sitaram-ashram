import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/animated_card.dart';
import '../widgets/home_footer.dart';
import '../widgets/background_container.dart';
import '../utils/responsive_utils.dart';

class ContactPage extends StatefulWidget {
  final void Function(String route)? onNav;
  const ContactPage({super.key, this.onNav});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late final AssetImage _bgImage;
  bool _bgReady = false;
  bool _didPrecache = false;

  @override
  void initState() {
    super.initState();
    _bgImage = const AssetImage('assets/images/cow_calf_field.jpg');
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BackgroundContainer(
        image: _bgImage,
        overlayColor: Color.fromRGBO(0, 0, 0, 0.35),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: constraints.maxHeight,
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: ResponsiveUtils.cardMaxWidth(context)),
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                ResponsiveUtils.cardHorizontalPadding(context)),
                        child: AnimatedCard(
                          child: Padding(
                            padding: ResponsiveUtils.cardPadding(context),
                            child: HoverBeat(
                              builder: (context, hovered) => Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  HeartbeatText(
                                    text: l10n.contactTitle,
                                    style: GoogleFonts.mukta(
                                      fontSize: ResponsiveUtils.fontSize(
                                          context,
                                          small: 22,
                                          medium: 28,
                                          large: 36),
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
                                      fontSize: ResponsiveUtils.fontSize(
                                          context,
                                          small: 14,
                                          medium: 16,
                                          large: 20),
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
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
                  ),
                  HomeFooter(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
