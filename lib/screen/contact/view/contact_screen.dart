import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../model/contact_model.dart';
import '../provider/contact_provider.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  ContactProvider? providerR;
  ContactProvider? providerW;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    providerR = context.read<ContactProvider>();
    providerW = context.watch<ContactProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add New Contact"),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stepper(
                  currentStep: providerW!.index,
                  onStepContinue: () {
                    providerR!.onStepContinue();
                  },
                  onStepCancel: () {
                    providerR!.onStepCancel();
                  },
                  steps: [
                    Step(
                      title: const Text("Add a photo"),
                      content: Column(
                        children: [
                          providerW!.path!.isEmpty
                              ? const CircleAvatar(
                                  radius: 50,
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      FileImage(File(providerW!.path)),
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    ImagePicker picker = ImagePicker();
                                    XFile? image = await picker.pickImage(
                                        source: ImageSource.camera);
                                    providerR!.addPath(image!.path);
                                  },
                                  icon: const Icon(Icons.camera)),
                              IconButton(
                                  onPressed: () async {
                                    ImagePicker picker = ImagePicker();
                                    XFile? image = await picker.pickImage(
                                        source: ImageSource.gallery);
                                    providerR!.addPath(image!.path);
                                  },
                                  icon: const Icon(Icons.image)),
                            ],
                          )
                        ],
                      ),
                    ),
                    Step(
                        title: const Text("Name"),
                        content: TextFormField(
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "name is required";
                            }
                            return null;
                          },
                          controller: txtName,
                          decoration: const InputDecoration(
                              label: Text("Enter your Name")),
                        )),
                    Step(
                        title: const Text("Contact"),
                        content: TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: txtMobile,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Mobile number is required";
                            } else if (value!.length != 10) {
                              return "Enter the valid number";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            label: Text("Enter your Mobile Number"),
                          ),
                        )),
                    Step(
                        title: const Text("Email"),
                        content: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: txtEmail,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email is required";
                            } else if (!RegExp(
                                    "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$")
                                .hasMatch(value)) {
                              return "Enter the valid email";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            label: Text("Enter your Email id"),
                          ),
                        )),
                  ]),
              ElevatedButton(
                  onPressed: () {
                    ContactModel c1 = ContactModel(
                      name: txtName.text,
                      mobile: txtMobile.text,
                      email: txtEmail.text,
                      image: providerR!.path,
                    );
                    providerR!.addContact(c1);
                    Navigator.pop(context);
                    providerR!.index = 0;
                    providerW!.path = "";
                  },
                  child: const Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
