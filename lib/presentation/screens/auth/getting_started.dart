import 'package:agriapp/presentation/widgets/buttons/full_width_button.dart';
import 'package:agriapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GettingStartedScreen extends StatelessWidget {
  const GettingStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Kissandost",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: darkGreenColor, fontSize: 35, letterSpacing: 1.5, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Your farming bestfriend - from sowing to harvesting",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ],
                    ),
                    SvgPicture.asset('assets/main.svg', height: MediaQuery.of(context).size.height * 0.3, fit: BoxFit.contain),
                    FullWidthButton(onPressed: () => Navigator.pushNamed(context, '/login'), text: 'Get Started'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
