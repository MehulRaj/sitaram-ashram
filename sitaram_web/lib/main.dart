import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'pages/ambulance_page.dart';
import 'pages/treatment_page.dart';
import 'pages/products_page.dart';
import 'pages/gallery_page.dart';
import 'pages/donate_page.dart';
import 'pages/contact_page.dart';
import 'pages/services_page.dart';
import 'widgets/app_navbar.dart';
import 'theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/locale_bloc.dart';
import 'utils/url_utils.dart';
import 'package:animations/animations.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => LocaleBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> _precacheAllImages(BuildContext context) async {
    await precacheImages(context, [
      AssetImage('assets/images/herd_sunset.jpg'),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _precacheAllImages(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.black,
            ),
            home: Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        return BlocBuilder<LocaleBloc, LocaleState>(
          builder: (context, localeState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: appTheme,
              supportedLocales: const [
                Locale('en'),
                Locale('hi'),
                Locale('gu'),
              ],
              locale: localeState.locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (locale, supportedLocales) {
                if (locale == null) return supportedLocales.first;
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale.languageCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
              onGenerateTitle: (context) =>
                  AppLocalizations.of(context)!.appTitle,
              home: _SectionalRoot(),
            );
          },
        );
      },
    );
  }
}

class _SectionalRoot extends StatefulWidget {
  @override
  State<_SectionalRoot> createState() => _SectionalRootState();
}

class _SectionalRootState extends State<_SectionalRoot> {
  String _currentRoute = '/';

  Widget _getPage(String route) {
    switch (route) {
      case '/about':
        return AboutPage(onNav: _onNav);
      case '/ambulance':
        return AmbulancePage(onNav: _onNav);
      case '/treatment':
        return TreatmentPage(onNav: _onNav);
      case '/products':
        return ProductsPage(onNav: _onNav);
      case '/gallery':
        return GalleryPage(onNav: _onNav);
      case '/donate':
        return DonatePage(onNav: _onNav);
      case '/contact':
        return ContactPage(onNav: _onNav);
      case '/services':
        return ServicesPage(onNav: _onNav);
      case '/':
      default:
        return HomePage(onNav: _onNav);
    }
  }

  void _onNav(String route) {
    if (route != _currentRoute) {
      setState(() {
        _currentRoute = route;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localeState = context.watch<LocaleBloc>().state;
    return WillPopScope(
      onWillPop: () async {
        if (_currentRoute != '/') {
          setState(() {
            _currentRoute = '/';
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppNavbar(
          onNav: _onNav,
          currentRoute: _currentRoute,
          currentLocale: localeState.locale,
          onLocaleChanged: (locale) =>
              context.read<LocaleBloc>().add(ChangeLocale(locale)),
        ),
        endDrawer: AppNavDrawer(
          onNav: _onNav,
          currentRoute: _currentRoute,
          currentLocale: localeState.locale,
          onLocaleChanged: (locale) =>
              context.read<LocaleBloc>().add(ChangeLocale(locale)),
        ),
        body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 600),
          reverse: false,
          transitionBuilder: (child, animation, secondaryAnimation) =>
              FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          ),
          child: KeyedSubtree(
            key: ValueKey(_currentRoute),
            child: _getPage(_currentRoute),
          ),
        ),
      ),
    );
  }
}
