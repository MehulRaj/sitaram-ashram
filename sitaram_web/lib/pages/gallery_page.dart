import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/animated_card.dart';
import '../widgets/animated_button.dart';
import '../widgets/home_footer.dart';
import '../widgets/background_container.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  void initState() {
    super.initState();
    final images = [
      'assets/images/herd_sunset.jpg',
      'assets/images/cow_closeup.jpg',
      'assets/images/calf_barn.jpg',
      'assets/images/buffalo_portrait.jpg',
      'assets/images/barn_feeding.jpg',
      'assets/images/cow_calf_field.jpg',
      'assets/images/cows_resting.jpg',
      'assets/images/cow_feeding_street.jpg',
      'assets/images/calf_village.jpg',
      'assets/images/cow_statue.jpg',
      'assets/images/dairy_cow.jpg',
      'assets/images/cows-1.jpg',
      'assets/images/pexels-cottonbro-4428270.jpg',
    ];
    for (final img in images) {
      precacheImage(AssetImage(img), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
          return mobileView(context);
        } else {
          return webView(context);
        }
      },
    );
  }

  Widget mobileView(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final images = [
      'assets/images/herd_sunset.jpg',
      'assets/images/cow_closeup.jpg',
      'assets/images/calf_barn.jpg',
      'assets/images/buffalo_portrait.jpg',
      'assets/images/barn_feeding.jpg',
      'assets/images/cow_calf_field.jpg',
      'assets/images/cows_resting.jpg',
      'assets/images/cow_feeding_street.jpg',
      'assets/images/calf_village.jpg',
      'assets/images/cow_statue.jpg',
      'assets/images/dairy_cow.jpg',
      'assets/images/cows-1.jpg',
      'assets/images/pexels-cottonbro-4428270.jpg',
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BackgroundContainer(
        image: const AssetImage('assets/images/herd_sunset.jpg'),
        overlayColor: Color.fromRGBO(0, 0, 0, 0.45),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 32),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
                child: HoverBeat(
                  builder: (context, hovered) => HeartbeatText(
                    text: l10n.galleryTitle,
                    style: GoogleFonts.mukta(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    beat: hovered,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CarouselSlider(
                options: CarouselOptions(
                  height: 320,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: images.asMap().entries.map((entry) {
                  final i = entry.key;
                  final img = entry.value;
                  return AnimatedCard(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        img,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 320,
                        errorBuilder: (c, e, s) => Container(
                          color: Theme.of(context).colorScheme.surface,
                          child: const Icon(Icons.image,
                              size: 48, color: Colors.black),
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: (i * 100).ms)
                      .slideY(
                          begin: 0.2,
                          end: 0,
                          duration: 600.ms,
                          delay: (i * 100).ms);
                }).toList(),
              ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
              const SizedBox(height: 32),
              HoverBeat(
                builder: (context, hovered) => Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Colors.black
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 36, horizontal: 32),
                    child: Column(
                      children: [
                        HeartbeatIcon(
                          icon: Icon(Icons.favorite,
                              size: 48, color: Colors.white),
                          beat: hovered,
                          duration: const Duration(milliseconds: 3200),
                        ),
                        const SizedBox(height: 18),
                        HeartbeatText(
                          text: l10n.donateTitle,
                          style: GoogleFonts.mukta(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          beat: hovered,
                          textAlign: TextAlign.center,
                          duration: const Duration(milliseconds: 3200),
                        ),
                        const SizedBox(height: 18),
                        HeartbeatText(
                          text: l10n.donateDescCreative,
                          style: GoogleFonts.mukta(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                          beat: hovered,
                          textAlign: TextAlign.center,
                          duration: const Duration(milliseconds: 3200),
                        ),
                        const SizedBox(height: 28),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.005),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: AnimatedButton(
                            text: l10n.donatePaypal,
                            onPressed: () =>
                                Navigator.of(context).pushNamed('/donate'),
                            primary: true,
                            icon: const Icon(Icons.account_balance_wallet,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              HomeFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget webView(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final images = [
      'assets/images/herd_sunset.jpg',
      'assets/images/cow_closeup.jpg',
      'assets/images/calf_barn.jpg',
      'assets/images/buffalo_portrait.jpg',
      'assets/images/barn_feeding.jpg',
      'assets/images/cow_calf_field.jpg',
      'assets/images/cows_resting.jpg',
      'assets/images/cow_feeding_street.jpg',
      'assets/images/calf_village.jpg',
      'assets/images/cow_statue.jpg',
      'assets/images/dairy_cow.jpg',
      'assets/images/cows-1.jpg',
      'assets/images/pexels-cottonbro-4428270.jpg',
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BackgroundContainer(
        image: const AssetImage('assets/images/herd_sunset.jpg'),
        overlayColor: Color.fromRGBO(0, 0, 0, 0.45),
        child: LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 1;
            final width = constraints.maxWidth;
            if (width > 1200) {
              crossAxisCount = 4;
            } else if (width > 900) {
              crossAxisCount = 3;
            } else if (width > 600) {
              crossAxisCount = 2;
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 96),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 24,
                        mainAxisExtent: 320,
                      ),
                      itemCount: images.length,
                      itemBuilder: (context, i) => AnimatedCard(
                        child: GestureDetector(
                          onTap: () => showDialog(
                            context: context,
                            builder: (_) => Dialog(
                              backgroundColor: Colors.transparent,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: PhotoView(
                                  imageProvider: AssetImage(images[i]),
                                  backgroundDecoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              images[i],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 320,
                              errorBuilder: (c, e, s) => Container(
                                color: Theme.of(context).colorScheme.surface,
                                child: const Icon(Icons.image,
                                    size: 48, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    HoverBeat(
                      builder: (context, hovered) => Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.primary,
                              Colors.black
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 36, horizontal: 32),
                          child: Column(
                            children: [
                              HeartbeatIcon(
                                icon: Icon(Icons.favorite,
                                    size: 48, color: Colors.white),
                                beat: hovered,
                                duration: const Duration(milliseconds: 3200),
                              ),
                              const SizedBox(height: 18),
                              HeartbeatText(
                                text: l10n.donateTitle,
                                style: GoogleFonts.mukta(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                                beat: hovered,
                                textAlign: TextAlign.center,
                                duration: const Duration(milliseconds: 3200),
                              ),
                              const SizedBox(height: 18),
                              HeartbeatText(
                                text: l10n.donateDescCreative,
                                style: GoogleFonts.mukta(
                                  fontSize: 20,
                                  color: Colors.white70,
                                ),
                                beat: hovered,
                                textAlign: TextAlign.center,
                                duration: const Duration(milliseconds: 3200),
                              ),
                              const SizedBox(height: 28),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.005),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: AnimatedButton(
                                  text: l10n.donatePaypal,
                                  onPressed: () => Navigator.of(context)
                                      .pushNamed('/donate'),
                                  primary: true,
                                  icon: const Icon(Icons.account_balance_wallet,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    HomeFooter(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
