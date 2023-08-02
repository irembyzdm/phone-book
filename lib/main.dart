import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const MyContacts());
}

class MyContacts extends StatelessWidget {
  const MyContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Color.fromARGB(255, 242, 152, 212),
          unselectedItemColor: Colors.black38,
        ),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CustomPageTransitionBuilder(),
            TargetPlatform.iOS: CustomPageTransitionBuilder(),
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (route.settings.name == '/') {
      return child;
    }

    // Slide from right to left
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    // Apply slide transition
    return SlideTransition(
      position: animation.drive(tween),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
