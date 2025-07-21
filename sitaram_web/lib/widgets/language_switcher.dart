import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:google_fonts/google_fonts.dart';

const supportedLocales = [
  Locale('en'),
  Locale('hi'),
  Locale('gu'),
];

class LanguageSwitcher extends StatelessWidget {
  final Locale currentLocale;
  final void Function(Locale) onLocaleChanged;
  final Color? color;
  const LanguageSwitcher({
    super.key,
    required this.currentLocale,
    required this.onLocaleChanged,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? Theme.of(context).colorScheme.primary;
    return DropdownButtonHideUnderline(
      child: DropdownButton2<Locale>(
        value: supportedLocales.firstWhere(
          (l) => l.languageCode == currentLocale.languageCode,
          orElse: () => supportedLocales.first,
        ),
        customButton: Row(
          children: [
            Text(
              _labelForLocale(currentLocale),
              style: GoogleFonts.mukta(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: effectiveColor,
              ),
            ),
            const SizedBox(width: 6),
            Icon(Icons.language, color: effectiveColor, size: 20),
          ],
        ),
        items: supportedLocales
            .map((locale) => DropdownMenuItem<Locale>(
                  value: locale,
                  child: Builder(
                    builder: (context) {
                      final isSelected =
                          locale.languageCode == currentLocale.languageCode;
                      return Container(
                        decoration: isSelected
                            ? BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.85),
                                borderRadius: BorderRadius.circular(6),
                              )
                            : null,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Text(
                          _labelForLocale(locale),
                          style: GoogleFonts.mukta(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: isSelected
                                ? Colors.white
                                : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      );
                    },
                  ),
                ))
            .toList(),
        onChanged: (locale) {
          if (locale != null) onLocaleChanged(locale);
        },
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
          width: 140, // Set a fixed width for the dropdown options
        ),
        menuItemStyleData: const MenuItemStyleData(
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
          selectedMenuItemBuilder: null,
        ),
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          height: 40,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }

  static String _labelForLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'hi':
        return 'हिन्दी';
      case 'gu':
        return 'ગુજરાતી';
      case 'en':
      default:
        return 'English';
    }
  }
}
