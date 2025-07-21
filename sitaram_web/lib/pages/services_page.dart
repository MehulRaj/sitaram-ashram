import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/animated_card.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/home_footer.dart';
import '../widgets/background_container.dart';

class ServicesPage extends StatefulWidget {
  final void Function(String route)? onNav;
  const ServicesPage({super.key, this.onNav});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  late final AssetImage _bgImage;
  bool _bgReady = false;
  bool _didPrecache = false;

  @override
  void initState() {
    super.initState();
    _bgImage = const AssetImage('assets/images/cow_statue.jpg');
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
    final services = [
      {
        'icon': Icons.auto_stories,
        'title': l10n.servicesAmbulanceTitle,
        'desc': l10n.servicesAmbulanceDesc,
      },
      {
        'icon': Icons.flag,
        'title': l10n.servicesTreatmentTitle,
        'desc': l10n.servicesTreatmentDesc,
      },
      {
        'icon': Icons.auto_stories,
        'title': l10n.productsTitle,
        'desc':
            '${l10n.productGheeDesc}\n${l10n.productDungDesc}\n${l10n.productUrineDesc}\n${l10n.productCompostDesc}',
      },
      {
        'icon': Icons.photo_library,
        'title': l10n.galleryTitle,
        'desc': '${l10n.galleryTitle}: ${l10n.ourWorkDesc}',
      },
      {
        'icon': Icons.volunteer_activism,
        'title': l10n.donateTitle,
        'desc': l10n.donateDescCreative,
      },
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BackgroundContainer(
        image: _bgImage,
        overlayColor: Color.fromRGBO(0, 0, 0, 0.38),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 3D Animated Section Header
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 48),
                      child: HoverBeat(
                        builder: (context, hovered) => Column(
                          children: [
                            HeartbeatText(
                              text: l10n.ourWorkTitle,
                              style: GoogleFonts.mukta(
                                fontSize: 44,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.2,
                              ),
                              textAlign: TextAlign.center,
                              beat: hovered,
                              duration: Duration(milliseconds: 3200),
                            ),
                            const SizedBox(height: 16),
                            HeartbeatText(
                              text: l10n.ourWorkDesc,
                              style: GoogleFonts.mukta(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70,
                                letterSpacing: 0.1,
                              ),
                              textAlign: TextAlign.center,
                              beat: hovered,
                              duration: Duration(milliseconds: 3200),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    // Modern vertical timeline/stepper for services
                    Column(
                      children: List.generate(services.length, (i) {
                        final s = services[i];
                        return HoverBeat(
                          builder: (context, hovered) => Container(
                            margin: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 16,
                                  offset: Offset(0, 6),
                                ),
                              ],
                              border: Border.all(
                                color: Theme.of(context)
                                    .dividerColor
                                    .withOpacity(0.08),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 36, horizontal: 32),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  HeartbeatIcon(
                                    icon: Icon(s['icon'] as IconData,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        size: 40),
                                    beat: hovered,
                                    duration: Duration(milliseconds: 3200),
                                  ),
                                  const SizedBox(height: 24),
                                  HeartbeatText(
                                    text: s['title'] as String,
                                    style: GoogleFonts.mukta(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    textAlign: TextAlign.center,
                                    beat: hovered,
                                    duration: Duration(milliseconds: 3200),
                                  ),
                                  const SizedBox(height: 16),
                                  HeartbeatText(
                                    text: s['desc'] as String,
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
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
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
