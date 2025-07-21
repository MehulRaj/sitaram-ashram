import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/url_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/animated_card.dart';
import '../widgets/animated_button.dart';
import '../widgets/home_footer.dart';
import '../widgets/background_container.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({super.key});

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  late final AssetImage _bgImage;
  bool _bgReady = false;

  @override
  void initState() {
    super.initState();
    _bgImage = const AssetImage('assets/images/calf_barn.jpg');
    _precacheBg();
  }

  void _precacheBg() async {
    await precacheImage(_bgImage, context);
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BackgroundContainer(
        image: _bgImage,
        overlayColor: Color.fromRGBO(0, 0, 0, 0.45),
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
                              vertical: 16.0, horizontal: 24.0),
                          child: HoverBeat(
                            builder: (context, hovered) => Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                HeartbeatText(
                                  text: l10n.donateTitle,
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
                                const SizedBox(height: 16),
                                HeartbeatText(
                                  text: l10n.donateDescCreative,
                                  style: GoogleFonts.mukta(
                                    fontSize: 18,
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
                                HeartbeatIcon(
                                  icon: const Icon(Icons.account_balance_wallet,
                                      color: Colors.white),
                                  beat: hovered,
                                  duration: Duration(milliseconds: 3200),
                                ),
                                const SizedBox(height: 20),
                                AnimatedButton(
                                  text: l10n.donatePaypal,
                                  onPressed: () =>
                                      launchAppUrl('https://paypal.com'),
                                  primary: true,
                                  icon: const Icon(Icons.account_balance_wallet,
                                      color: Colors.white),
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
