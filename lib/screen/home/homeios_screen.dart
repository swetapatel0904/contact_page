import 'package:contact_page/screen/contact/provider/contact_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomeIosScreen extends StatefulWidget {
  const HomeIosScreen({super.key});

  @override
  State<HomeIosScreen> createState() => _HomeIosScreenState();
}

class _HomeIosScreenState extends State<HomeIosScreen> {
  ContactProvider? providerR;
  ContactProvider? providerW;
  @override
  Widget build(BuildContext context) {
    providerR= context.read<ContactProvider>();
    providerW= context.watch<ContactProvider>();
    return  CupertinoPageScaffold(
      child: Center(),
      navigationBar: CupertinoNavigationBar(
          middle: Text("iOS"),
      trailing: CupertinoSwitch(value:providerW!.isAndroid, onChanged: (value) {
        providerR!.changeUI();
      },
      )
  ),

    );
  }
}
