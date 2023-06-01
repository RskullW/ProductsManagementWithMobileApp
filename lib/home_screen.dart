import 'package:flutter/material.dart';
import 'package:nonton_test/bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return _buildAllBars();
  }

  Widget _buildAllBars() {
    var body = _buildBody();
    return Container(
      child: Scaffold(
        key: _scaffoldKey,
        body: body,
        appBar: _buildAppBar(),
        backgroundColor: Colors.white70,
        bottomNavigationBar: CustomBottomBar(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: AppBar(
          backgroundColor: Colors.red,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Center(
              child: Text("BARS",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.3,
                  )))),
    );
  }

  Widget _buildBottomAppBar() {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Text(
        "TEST",
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      child: Center(
        child: Icon(
          Icons.ac_unit,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}
