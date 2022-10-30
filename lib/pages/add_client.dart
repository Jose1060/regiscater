import 'package:flutter/material.dart';
import 'package:regiscater/constants/ui_constants.dart';
import 'package:regiscater/models/client.dart';

import '../services/db_services.dart';

class AddClientScreen extends StatefulWidget {
  const AddClientScreen({super.key});

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController dniController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Name', style: textStyle),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    style: inputTextStyle,
                    decoration:
                        inputDecoration.copyWith(hintText: "Enter your Name"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  const Text(
                    'Age',
                    style: textStyle,
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    style: inputTextStyle,
                    decoration:
                        inputDecoration.copyWith(hintText: "Enter Your Age"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your age';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  const Text('DNI', style: textStyle),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: dniController,
                    keyboardType: TextInputType.number,
                    style: inputTextStyle,
                    decoration:
                        inputDecoration.copyWith(hintText: "Enter your DNI"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your dni';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  const Text(
                    'Email',
                    style: textStyle,
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    style: inputTextStyle,
                    decoration:
                        inputDecoration.copyWith(hintText: "Enter your Email"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  const Text(
                    'Phone',
                    style: textStyle,
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    style: inputTextStyle,
                    decoration:
                        inputDecoration.copyWith(hintText: "Enter your phone"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your dni';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  !isLoading
                      ? Center(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(200, 50)),
                                  backgroundColor: MaterialStateProperty.all<
                                          Color>(
                                      const Color.fromARGB(255, 83, 80, 80))),
                              onPressed: (() async {
                                if (_formKey.currentState!.validate()) {
                                  DatabaseService service = DatabaseService();
                                  Clients client = Clients(
                                    name: nameController.text,
                                    age: int.parse(ageController.text),
                                    dni: int.parse(dniController.text),
                                    email: emailController.text,
                                    phone: int.parse(phoneController.text),
                                  );
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await service.addEmployee(client);
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              }),
                              child: const Text(
                                "Submit",
                                style: TextStyle(fontSize: 20),
                              )),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        )
                ],
              ),
            )),
      ),
    ));
  }
}
