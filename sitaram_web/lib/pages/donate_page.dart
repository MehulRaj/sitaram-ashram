import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/url_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/animated_card.dart';
import '../widgets/animated_button.dart';
import '../widgets/home_footer.dart';
import '../widgets/background_container.dart';
import '../utils/responsive_utils.dart';

class DonatePage extends StatefulWidget {
  final void Function(String route)? onNav;
  const DonatePage({super.key, this.onNav});

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BackgroundContainer(
        image: _bgImage,
        overlayColor: Color.fromRGBO(0, 0, 0, 0.45),
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
                                    text: l10n.donateTitle,
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
                                  const SizedBox(height: 16),
                                  HeartbeatText(
                                    text: l10n.donateDescCreative,
                                    style: GoogleFonts.mukta(
                                      fontSize: ResponsiveUtils.fontSize(
                                          context,
                                          small: 14,
                                          medium: 16,
                                          large: 18),
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                    textAlign: TextAlign.center,
                                    beat: hovered,
                                    duration: Duration(milliseconds: 3200),
                                  ),
                                  const SizedBox(height: 20),
                                  AnimatedButton(
                                    text: l10n.donatePaypal,
                                    onPressed: () =>
                                        launchAppUrl('https://paypal.com'),
                                    primary: true,
                                    icon: const Icon(
                                        Icons.account_balance_wallet,
                                        color: Colors.white),
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
