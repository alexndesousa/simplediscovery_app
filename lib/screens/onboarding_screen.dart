import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:simplediscovery_app/home_page.dart';
import 'package:simplediscovery_app/screens/pre_auth_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {

    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    void _onIntroEnd(context) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomePage()));
    }

    return IntroductionScreen(
      pages: [
        PageViewModel(
          titleWidget: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Text("Simple discovery", style: TextStyle(fontSize: 40.0),),
          ),
          body: "your better music recommender",
          decoration: pageDecoration
        ),
        PageViewModel(
          title: "Info",
          body: "Simply import a playlist and we'll take care of the rest",
          decoration: pageDecoration
        ),
        PageViewModel(
          title: "Auth",
          bodyWidget: PreAuthScreen(),
          decoration: pageDecoration
        ),
        PageViewModel(
          title: "Complete",
          body:"You're all set, go forth and find yourself some bangers",
          decoration: pageDecoration
        )
      ],
      onDone: () => _onIntroEnd(context),
      done: Text("done"),
      next: Icon(Icons.arrow_forward_ios),
    );
  }
}