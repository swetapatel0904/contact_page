import 'package:flutter/cupertino.dart';

class HomeIosScreen extends StatefulWidget {
  const HomeIosScreen({super.key});

  @override
  State<HomeIosScreen> createState() => _HomeIosScreenState();
}

class _HomeIosScreenState extends State<HomeIosScreen> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(),
      navigationBar: CupertinoNavigationBar(
          middle: Text("Home Screen"), trailing: Icon(CupertinoIcons.search)),
    );
  }
}
