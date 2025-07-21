import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/url_utils.dart';
import '../theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/animated_card.dart';
import '../widgets/animated_button.dart';
import '../widgets/home_footer.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({super.key});

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  @override
  void initState() {
    super.initState();
    precacheImages(context, [
      AssetImage('assets/images/calf_barn.jpg'),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/calf_barn.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.45),
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
                                        .onBackground,
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
