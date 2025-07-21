import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/animated_button.dart';
import '../widgets/animated_card.dart';
import '../utils/url_utils.dart';
import '../widgets/background_container.dart';
import '../widgets/home_footer.dart';

class ZigZagSection extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final bool imageLeft;
  final String route;
  final bool isMobile;
  const ZigZagSection({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.imageLeft,
    required this.route,
    required this.isMobile,
  });

  @override
  State<ZigZagSection> createState() => _ZigZagSectionState();
}

class _ZigZagSectionState extends State<ZigZagSection> {
  bool _hovering = false;
  bool _pressed = false;

  void _onTap(BuildContext context) async {
    setState(() => _pressed = true);
    await Future.delayed(const Duration(milliseconds: 120));
    setState(() => _pressed = false);
    Navigator.of(context).pushNamed(widget.route);
  }

  @override
  Widget build(BuildContext context) {
    final image = ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        widget.imageUrl,
        width: widget.isMobile ? double.infinity : 680, // 2x width
        height: widget.isMobile ? 400 : 440, // 2x height
        fit: BoxFit.cover,
        errorBuilder: (c, e, s) => Container(
          color: Theme.of(context).colorScheme.surface,
          width: widget.isMobile ? double.infinity : 680,
          height: widget.isMobile ? 400 : 440,
          child: const Icon(Icons.image, size: 48, color: Colors.black),
        ),
        loadingBuilder: (c, child, progress) => progress == null
            ? child
            : Container(
                color: Theme.of(context).colorScheme.surface,
                width: widget.isMobile ? double.infinity : 680,
                height: widget.isMobile ? 400 : 440,
                child: const Center(child: CircularProgressIndicator()),
              ),
      ),
    );
    final text = Column(
      crossAxisAlignment: widget.isMobile
          ? CrossAxisAlignment.center
          : (widget.imageLeft
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end),
      children: [
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: (GoogleFonts.mukta(
            fontSize: _hovering
                ? (widget.isMobile ? 30 : 38)
                : (widget.isMobile ? 26 : 32),
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.primary,
          )).copyWith(
            letterSpacing: 0.5,
          ),
          child: Text(widget.title),
        ),
        const SizedBox(height: 16),
        Text(
          widget.description,
          style: GoogleFonts.mukta(
            fontSize: widget.isMobile ? 16 : 20,
            color: Theme.of(context).colorScheme.secondary,
          ),
          textAlign: widget.isMobile
              ? TextAlign.center
              : (widget.imageLeft ? TextAlign.left : TextAlign.right),
        ),
      ],
    );
    final section = widget.isMobile
        ? Column(
            children: [
              image
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: 0.2, end: 0),
              const SizedBox(height: 20),
              text
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 100.ms)
                  .slideY(begin: 0.2, end: 0),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.imageLeft
                ? [
                    image
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .slideX(begin: -0.2, end: 0),
                    const SizedBox(width: 48),
                    Expanded(
                      child: text
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 100.ms)
                          .slideX(begin: 0.2, end: 0),
                    ),
                  ]
                : [
                    Expanded(
                      child: text
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 100.ms)
                          .slideX(begin: -0.2, end: 0),
                    ),
                    const SizedBox(width: 48),
                    image
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .slideX(begin: 0.2, end: 0),
                  ],
          );
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.isMobile ? 16 : 32,
        vertical: widget.isMobile ? 16 : 32,
      ),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: GestureDetector(
          onTap: () => _onTap(context),
          child: AnimatedScale(
            scale: _hovering || _pressed ? 1.05 : 1.0,
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            child: SizedBox(
              width: double.infinity,
              child: AnimatedCard(child: section),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    precacheImages(context, [
      AssetImage('assets/images/herd_sunset.jpg'),
      AssetImage('assets/images/cow_statue.jpg'),
      AssetImage('assets/images/calf_barn.jpg'),
      AssetImage('assets/images/cows_resting.jpg'),
      AssetImage('assets/images/cow_calf_field.jpg'),
      AssetImage('assets/images/cows-1.jpg'),
      // Add more as needed
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BackgroundContainer(
        image: const AssetImage('assets/images/herd_sunset.jpg'),
        overlayColor: Color.fromRGBO(0, 0, 0, 0.45),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Hero Section
              _HomeHeroSection(),
              // 2. Mission/Intro Section
              _HomeMissionSection(),
              // 3. Highlights Grid
              _HomeHighlightsGrid(),
              // 4. Donate Call-to-Action
              _HomeDonateCTA(),
              // 6. Creative Footer
              HomeFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

// 1. Hero Section
class _HomeHeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage('assets/images/herd_sunset.jpg'),
      //     fit: BoxFit.cover,
      //     colorFilter: ColorFilter.mode(
      //       Colors.black.withOpacity(0.55),
      //       BlendMode.darken,
      //     ),
      //   ),
      // ),
      child: Center(
        child: HoverBeat(
          builder: (context, hovered) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeartbeatText(
                text: l10n.homeTitle,
                style: GoogleFonts.mukta(
                  fontSize: 54,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.18),
                      blurRadius: 16,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                beat: hovered,
                duration: const Duration(milliseconds: 3200),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              HeartbeatText(
                text: l10n.homeMissionCreative,
                style: GoogleFonts.mukta(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.92),
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                beat: hovered,
                duration: const Duration(milliseconds: 3200),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 44),
              HoverBeat(
                builder: (context, btnHovered) => Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.005),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: AnimatedButton(
                    text: l10n.donateTitle,
                    onPressed: () =>
                        Navigator.of(context).pushReplacementNamed('/donate'),
                    primary: true,
                    icon: HeartbeatIcon(
                      icon: const Icon(Icons.volunteer_activism,
                          color: Colors.white),
                      beat: btnHovered,
                      duration: const Duration(milliseconds: 3200),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Smoother heartbeat for buttons
class _AnimatedHeartbeatButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Icon icon;
  const _AnimatedHeartbeatButton({
    required this.text,
    required this.onPressed,
    required this.icon,
  });
  @override
  State<_AnimatedHeartbeatButton> createState() =>
      _AnimatedHeartbeatButtonState();
}

class _AnimatedHeartbeatButtonState extends State<_AnimatedHeartbeatButton> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedButton(
        text: widget.text,
        onPressed: widget.onPressed,
        primary: true,
        icon: HeartbeatIcon(
          icon: widget.icon,
          beat: _hovered,
          duration: const Duration(milliseconds: 3200), // smoother
          scale: 1.0,
        ),
      ),
    );
  }
}

// 2. Mission/Intro Section (no card, creative, centered)
class _HomeMissionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.stars, size: 56, color: Colors.white),
          const SizedBox(height: 18),
          Text(
            l10n.ourMissionTitle,
            style: GoogleFonts.mukta(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          Text(
            l10n.ourMissionCreative,
            style: GoogleFonts.mukta(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// 3. Highlights Grid (About Us more creative, beautiful, centered, descriptive)
class _HomeHighlightsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final highlights = [
      {
        'icon': Icons.info_outline,
        'label': l10n.aboutTitle,
        'route': '/about',
      },
      {
        'icon': Icons.volunteer_activism,
        'label': l10n.ourWorkTitle,
        'route': '/services',
      },
      {
        'icon': Icons.shopping_bag_outlined,
        'label': l10n.productsTitle,
        'route': '/products',
      },
      {
        'icon': Icons.photo_library_outlined,
        'label': l10n.galleryTitle,
        'route': '/gallery',
      },
      {
        'icon': Icons.favorite_border,
        'label': l10n.donateTitle,
        'route': '/donate',
      },
      {
        'icon': Icons.mail_outline,
        'label': l10n.contactTitle,
        'route': '/contact',
      },
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = constraints.maxWidth > 900
              ? 3
              : constraints.maxWidth > 600
                  ? 2
                  : 1;
          return GridView.count(
            crossAxisCount: crossAxisCount,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 32,
            crossAxisSpacing: 32,
            childAspectRatio: 1.7,
            children: highlights.map((h) {
              return _HighlightCard(
                icon: h['icon'] as IconData,
                label: h['label'] as String,
                route: h['route'] as String,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class _HighlightCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;
  const _HighlightCard({
    required this.icon,
    required this.label,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return HoverBeat(
      builder: (context, hovered) => InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => Navigator.of(context).pushNamed(route),
        child: AnimatedCard(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HeartbeatIcon(
                  icon: Icon(icon,
                      size: 48, color: Theme.of(context).colorScheme.primary),
                  beat: hovered,
                  duration: const Duration(milliseconds: 3200),
                ),
                const SizedBox(height: 18),
                HeartbeatText(
                  text: label,
                  style: GoogleFonts.mukta(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  beat: hovered,
                  textAlign: TextAlign.center,
                  duration: const Duration(milliseconds: 3200),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 4. Remove Gallery Preview section from home (delete _HomeGalleryPreview and its usage)
// 5. Donate Call-to-Action (more creative and descriptive)
class _HomeDonateCTA extends StatefulWidget {
  @override
  State<_HomeDonateCTA> createState() => _HomeDonateCTAState();
}

class _HomeDonateCTAState extends State<_HomeDonateCTA> {
  final bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: HoverBeat(
        builder: (context, hovered) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Theme.of(context).colorScheme.primary, Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 32),
            child: Column(
              children: [
                HeartbeatIcon(
                  icon: Icon(Icons.favorite, size: 48, color: Colors.white),
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
                    onPressed: () => Navigator.of(context).pushNamed('/donate'),
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
    );
  }
}
