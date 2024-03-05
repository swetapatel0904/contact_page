import 'package:flutter/cupertino.dart';

class ContactIOSScreen extends StatefulWidget {
  const ContactIOSScreen({super.key});

  @override
  State<ContactIOSScreen> createState() => _ContactIOSScreenState();
}

class _ContactIOSScreenState extends State<ContactIOSScreen> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(),
      navigationBar: CupertinoNavigationBar(middle: Text("Add Contact")),
    );
  }
}
