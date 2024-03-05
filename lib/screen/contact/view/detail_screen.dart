import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:contact_page/screen/contact/model/contact_model.dart';
import 'package:contact_page/screen/contact/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  GlobalKey<FormState> key = GlobalKey();

  ContactProvider? providerR;
  ContactProvider? providerW;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  int i=0;
  bool isContact=true;

  @override
  Widget build(BuildContext context) {
    providerR = context.read<ContactProvider>();
    providerW = context.watch<ContactProvider>();
    List l1= ModalRoute.of(context)!.settings.arguments as List;
    i=l1[0];
    isContact=l1[1];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Details"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    onTap: () {
                      Share.share(
                          "${providerW!.contactList[i].name}\n${providerW!.contactList[i].mobile}");
                    },
                    child: Text("Share")),
                PopupMenuItem(
                  onTap: ()
                  {
                    editDialog(context, i);
                  },child: Text("Edit"),
                ),
                PopupMenuItem(
                  onTap: ()
                  {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Are you sure?"),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                providerR!.deleteContact(i);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text("Yes!")),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("No!")),
                        ],
                      ),
                    );
                  },child: Text("Delete"),
                ),
                PopupMenuItem(
                  onTap: ()
                  {
                    providerR!.addHiddenList(i);
                    Navigator.pop(context);
                  },child: Text("Lock"),
                )
              ];
            },
          )
        ],
      ),
      body: Column(
        children: [
          providerW!.contactList[i].image!.isEmpty
              ? Container()
              : Image.file(File("${providerW!.contactList[i].image}"),
                  height: 200,
                  width: MediaQuery.sizeOf(context).width,
                  fit: BoxFit.cover),
          ListTile(
            title: Text("${providerW!.contactList[i].name}",
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            subtitle: Text(
              "${providerW!.contactList[i].email}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: const Text("Phone", style: TextStyle(fontSize: 25)),
            subtitle: Text("+91 ${providerW!.contactList[i].mobile}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            trailing: IconButton.filledTonal(
                onPressed: () async {
                  String link = "tel:+91${providerW!.contactList[i].mobile}";
                  await launchUrl(Uri.parse(link));
                },
                icon: const Icon(Icons.call)),
          )
        ],
      ),
    );
  }

  void editDialog(BuildContext context, int index) {
    txtMobile.text = providerR!.contactList[i].mobile!;
    txtEmail.text = providerR!.contactList[i].email!;
    txtName.text = providerR!.contactList[i].name!;
    providerR!.editI(providerR!.contactList[i].image!);
    showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Form(
              key: key,
              child: AlertDialog(
                  title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 20),
                      height: MediaQuery.sizeOf(context).height * 0.30,
                      width: MediaQuery.sizeOf(context).width * 0.85,
                      child: Stack(alignment: Alignment.center, children: [
                        providerW!.editImage!.isEmpty
                            ? const CircleAvatar(
                                radius: 50,
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    FileImage(File(providerW!.editImage!)),
                              ),
                        Align(
                            alignment: const Alignment(0.3, 0.3),
                            child: IconButton(
                              onPressed: () async {
                                ImagePicker picker = ImagePicker();
                                XFile? image = await picker.pickImage(
                                    source: ImageSource.camera);
                                providerR!.editPath(image!.path);
                              },
                              icon: const Icon(
                                Icons.add_a_photo_rounded,
                                color: Colors.blueAccent,
                                weight: 50,
                              ),
                            )),
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: txtName,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "name is required";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: "Enter Name",
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: txtMobile,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "mobile no. is required";
                            } else if (value!.length != 10) {
                              return "Enter the valid number";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: "Enter Mobile Number",
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: txtEmail,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email is required ";
                            } else if (!RegExp(
                                    "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$")
                                .hasMatch(value)) {
                              return "enter the valid email";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: "Enter Email id",
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (key.currentState!.validate()) {
                                ContactModel c4 = ContactModel(
                                    name: txtName.text,
                                    mobile: txtMobile.text,
                                    image: providerR!.editImage!,
                                    email: txtEmail.text);
                                providerR!.updateContact(i: i, c3: c4);
                                txtName.clear();
                                txtMobile.clear();
                                txtEmail.clear();
                                ScaffoldMessenger.of(context)!.showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Your Contact is updated")));
                                Navigator.pop(context);
                              }
                            },
                            child: const Text("update",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 25,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
            ),
          );
        });
  }
}
