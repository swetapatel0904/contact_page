import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/shared_helper.dart';
import '../contact/provider/contact_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ContactProvider? providerR;
  ContactProvider? providerW;

  @override
  Widget build(BuildContext context) {
    providerR = context.read<ContactProvider>();
    providerW = context.watch<ContactProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                providerR!.setTheme();
              },
              icon: Icon(providerW!.themeMode)),
          IconButton(
              onPressed: () async {
                // bool? authLock = await providerR!.authLock();
                // if (authLock==true) {
                  Navigator.pushNamed(context, 'hide');
                // }
              },
              icon: const Icon(Icons.lock)),

    ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: providerR!.contactList.length,
          itemBuilder: (context, index) => Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'details', arguments: [index,true]);
                },
                child: Container(
                  height: 80,
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: FileImage(
                                File("${providerW!.contactList[index].image}")),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${providerW!.contactList[index].name}",
                                  style: const TextStyle(fontSize: 20)),
                              Text("${providerW!.contactList[index].mobile}",
                                  style: const TextStyle(fontSize: 15)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.pushNamed(context, 'add_data').then((value) {
              setState(() {});
            });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
