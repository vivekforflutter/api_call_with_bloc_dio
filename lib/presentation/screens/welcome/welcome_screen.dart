import 'package:flutter/material.dart';
import '../../../api/api_helper.dart';
import '../login/login_in_ui.dart';
import '../registration/registration_ui.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with ApiHelper {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF191720),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 90, 20, 10),
              height: MediaQuery.of(context).size.height / 2.7,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
                image: DecorationImage(
                    image: AssetImage("assets/image.png"), fit: BoxFit.cover),
              ),
            ),
            const Text(
              "Enterprise team",
              style: TextStyle(
                height: 3,
                leadingDistribution: TextLeadingDistribution.proportional,
                letterSpacing: 0.5,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 30,
              ),
            ),
            const Text(
              "collaboration.",
              style: TextStyle(
                height: 1,
                leadingDistribution: TextLeadingDistribution.proportional,
                letterSpacing: 0.5,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 30,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(55, 25, 55, 5),
              child: Text(
                "Bring together your files,your tools, projects and people.Including a new mobile and desktop application",
                style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF666670),
                    height: 1.3,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF3b3a42),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TabBar(
                  onTap: (i) {
                    if (i == 0) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RegisterScreen()));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignIn()));
                    }
                  },
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.white70,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.blue,
                  indicator: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xFFffffff), Color(0xFFffffff)]),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.redAccent),
                  tabs: const [
                    Tab(
                      text: "Register",
                    ),
                    Tab(
                      text: "Sign In",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
