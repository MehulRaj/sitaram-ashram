import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/animated_card.dart';
import '../widgets/home_footer.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

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
    final products = [
      {
        'name': l10n.productGhee,
        'desc': l10n.productGheeDesc,
        'img':
            'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=400&q=80',
      },
      {
        'name': l10n.productDung,
        'desc': l10n.productDungDesc,
        'img':
            'https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=400&q=80',
      },
      {
        'name': l10n.productUrine,
        'desc': l10n.productUrineDesc,
        'img':
            'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80',
      },
      {
        'name': l10n.productCompost,
        'desc': l10n.productCompostDesc,
        'img':
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
      },
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/cows_resting.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.18),
              BlendMode.darken,
            ),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 96.0),
                itemCount: products.length,
                itemBuilder: (context, i) {
                  final p = products[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: HoverBeat(
                      builder: (context, hovered) => AnimatedCard(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                p['img']!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 120,
                                errorBuilder: (c, e, s) => Container(
                                  color: Theme.of(context).colorScheme.surface,
                                  child: const Icon(Icons.image,
                                      size: 48, color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            HoverBeat(
                              builder: (context, hovered) => HeartbeatText(
                                text: p['name']!,
                                style: GoogleFonts.mukta(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                beat: hovered,
                                duration: Duration(milliseconds: 2400),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              p['desc']!,
                              style: GoogleFonts.mukta(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            HomeFooter(),
          ],
        ),
      ),
    );
  }

  Widget webView(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final products = [
      {
        'name': l10n.productGhee,
        'desc': l10n.productGheeDesc,
        'img':
            'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=400&q=80',
      },
      {
        'name': l10n.productDung,
        'desc': l10n.productDungDesc,
        'img':
            'https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=400&q=80',
      },
      {
        'name': l10n.productUrine,
        'desc': l10n.productUrineDesc,
        'img':
            'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80',
      },
      {
        'name': l10n.productCompost,
        'desc': l10n.productCompostDesc,
        'img':
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
      },
    ];
    int crossAxisCount = 1;
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) {
      crossAxisCount = 4;
    } else if (width > 900) {
      crossAxisCount = 3;
    } else if (width > 600) {
      crossAxisCount = 2;
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/cows_resting.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.18),
              BlendMode.darken,
            ),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 3D Animated Section Header (always visible)
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.7, end: 0),
                        duration: 1200.ms,
                        builder: (context, value, child) {
                          return Center(
                            child: HoverBeat(
                              builder: (context, hovered) => HeartbeatText(
                                text: l10n.productsTitle,
                                style: GoogleFonts.mukta(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.10),
                                      blurRadius: 8,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 32),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          mainAxisExtent:
                              320, // Fixed height for each card, adjust as needed
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, i) {
                          final p = products[i];
                          return HoverBeat(
                            builder: (context, hovered) => AnimatedCard(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      p['img']!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 120,
                                      errorBuilder: (c, e, s) => Container(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        child: const Icon(Icons.image,
                                            size: 48, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  HeartbeatText(
                                    text: p['name']!,
                                    style: GoogleFonts.mukta(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    beat: hovered,
                                    duration: Duration(milliseconds: 2400),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    p['desc']!,
                                    style: GoogleFonts.mukta(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
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
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            HomeFooter(),
          ],
        ),
      ),
    );
  }
}
