import 'dart:io';

import 'package:contact_page/screen/contact/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HiddenScreen extends StatefulWidget {
  const HiddenScreen({super.key});

  @override
  State<HiddenScreen> createState() => _HiddenScreenState();
}

class _HiddenScreenState extends State<HiddenScreen> {
  ContactProvider? providerR;
  ContactProvider? providerW;
  @override
  Widget build(BuildContext context) {
    providerR = context.read<ContactProvider>();
    providerW = context.watch<ContactProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hidden Screen"),
      ),
      body:ListView.builder(
        itemCount: providerR!.hiddenList.length,
        itemBuilder: (context, index) => Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'details', arguments: [index,false]);
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
                        providerR!.hiddenList[index].image!.isEmpty
                            ? const CircleAvatar(
                          radius: 30,
                        )
                            : CircleAvatar(
                          radius: 30,
                          backgroundImage:
                          FileImage(File(providerW!.hiddenList[index].image!)),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${providerW!.hiddenList[index].name}",
                                style: const TextStyle(fontSize: 20)),
                            Text("${providerW!.hiddenList[index].mobile}",
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
    );
  }
}
