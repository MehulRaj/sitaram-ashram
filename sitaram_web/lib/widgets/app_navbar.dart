import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'language_switcher.dart';

class AppNavbar extends StatelessWidget implements PreferredSizeWidget {
  final void Function(String route) onNav;
  final String currentRoute;
  final Locale currentLocale;
  final void Function(Locale) onLocaleChanged;
  const AppNavbar(
      {super.key,
      required this.onNav,
      required this.currentRoute,
      required this.currentLocale,
      required this.onLocaleChanged});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final navItems = [
      {'label': l10n.aboutTitle, 'route': '/about'},
      {'label': l10n.ourWorkTitle, 'route': '/services'},
      {'label': l10n.productsTitle, 'route': '/products'},
      {'label': l10n.galleryTitle, 'route': '/gallery'},
      {'label': l10n.donateTitle, 'route': '/donate'},
      {'label': l10n.contactTitle, 'route': '/contact'},
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;
        if (isMobile) {
          return AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/herd_sunset.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.55),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              l10n.appTitle,
              style: GoogleFonts.mukta(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
            ),
            actions: [
              LanguageSwitcher(
                  currentLocale: currentLocale,
                  onLocaleChanged: onLocaleChanged,
                  color: Colors.white),
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              ),
            ],
          );
        } else {
          return Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/herd_sunset.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.55),
                    BlendMode.darken,
                  ),
                ),
              ),
              height: 64,
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            // Title (clickable)
                            GestureDetector(
                              onTap: () => onNav('/'),
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Text(
                                  l10n.appTitle,
                                  style: GoogleFonts.mukta(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 28,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 32),
                            ...navItems.map((item) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Container(
                                    decoration: currentRoute == item['route']
                                        ? BoxDecoration(
                                            color: Colors.white24,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          )
                                        : null,
                                    child: TextButton(
                                      onPressed: currentRoute == item['route']
                                          ? null
                                          : () => onNav(item['route']!),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                            currentRoute == item['route']
                                                ? Colors.white24
                                                : null,
                                        textStyle: GoogleFonts.mukta(
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                      child: Text(item['label']!,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                )),
                            const SizedBox(width: 16),
                          ],
                        ),
                      ),
                    ),
                    LanguageSwitcher(
                      currentLocale: currentLocale,
                      onLocaleChanged: onLocaleChanged,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class AppNavDrawer extends StatelessWidget {
  final void Function(String route) onNav;
  final String currentRoute;
  final Locale currentLocale;
  final void Function(Locale) onLocaleChanged;
  const AppNavDrawer(
      {super.key,
      required this.onNav,
      required this.currentRoute,
      required this.currentLocale,
      required this.onLocaleChanged});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final navItems = [
      {'label': l10n.aboutTitle, 'route': '/about'},
      {'label': l10n.ourWorkTitle, 'route': '/services'},
      {'label': l10n.productsTitle, 'route': '/products'},
      {'label': l10n.galleryTitle, 'route': '/gallery'},
      {'label': l10n.donateTitle, 'route': '/donate'},
      {'label': l10n.contactTitle, 'route': '/contact'},
    ];
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LanguageSwitcher(
                  currentLocale: currentLocale,
                  onLocaleChanged: onLocaleChanged,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
          ...navItems.map((item) => ListTile(
                title: Text(
                  item['label']!,
                  style: GoogleFonts.mukta(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: currentRoute == item['route']
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                onTap: currentRoute == item['route']
                    ? null
                    : () {
                        Navigator.of(context).pop();
                        onNav(item['route']!);
                      },
                selected: currentRoute == item['route'],
                selectedTileColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              )),
        ],
      ),
    );
  }
}
