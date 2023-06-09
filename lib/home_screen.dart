import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'bottom_bar.dart';
import 'gradient_color.dart';
import 'package:url_launcher/url_launcher.dart';
import 'products.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void>? _launched;

  Widget build(BuildContext context) {
    return _buildAllBars();
  }

  Widget _buildAllBars() {
    var body = _buildBody();
    return Container(
      decoration: GetGradientBackgroundScreen(),
      child: Scaffold(
        key: _scaffoldKey,
        body: body,
        appBar: _buildAppBar(),
        bottomNavigationBar: CustomBottomBar(),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Center(
          child: Column(
            children: [
              Image.asset(
                "assets/img/logo.png",
                height: 50,
                width: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        SizedBox(height: 40),
        Container(
          alignment: Alignment.center,
          child: Text(
            "Всего продуктов: ",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        Text(
          "${Products.GetSize()}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 40),
        Text(
          "Информация о работе: ",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: RichText(
            text: TextSpan(
              text:
                  "Приложение написано в качестве тестовой работы для компании ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
              children: [
                TextSpan(
                  text: "НОНТОН.РФ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      _launchSite("nonton.ru", path: "");
                    },
                ),
              ],
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: RichText(
            text: TextSpan(
              text: "Мой профиль на ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
              children: [
                TextSpan(
                  text:
                      "GitHub                                                                                  ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      _launchSite("github.com", path: "RskullW");
                    },
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          width: 5,
        ),
      ],
    );
  }

  void _launchSite(String url, {String path = ""}) {
    final Uri toLaunch = Uri(scheme: 'https', host: url, path: path);
    _launchInBrowser(toLaunch);
    FutureBuilder<void>(future: _launched, builder: _launchStatus);
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }
}
