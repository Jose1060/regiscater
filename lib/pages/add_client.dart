import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:regiscater/constants/ui_constants.dart';
import 'package:regiscater/models/client.dart';
import 'package:rive/rive.dart';

import '../services/db_services.dart';

class AddClientScreen extends StatefulWidget {
  const AddClientScreen({super.key});

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  String? gender = "Gender";
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController dniController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final List<String> _errores = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: primaryColor),
          title: const Text(
            'Add clients',
            style: TextStyle(color: primaryColor, fontSize: 15),
          ),
          centerTitle: true,
        ),
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
                        decoration: inputDecoration.copyWith(
                            hintText: "Enter your Name"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            const error = 'Please enter your Name';
                            setState(() {
                              _errores.add(error);
                            });
                            return error;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: spaceFormInput),
                      const Text(
                        'Age',
                        style: textStyle,
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        style: inputTextStyle,
                        decoration: inputDecoration.copyWith(
                            hintText: "Enter Your Age"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            const error = 'Please enter your Age';
                            setState(() {
                              _errores.add(error);
                            });
                            return error;
                          }
                          if (int.parse(value) >= 100 ||
                              int.parse(value) <= 0) {
                            const error = 'Please enter a valid Age';
                            setState(() {
                              _errores.add(error);
                            });
                            return error;
                          }
                          if (int.parse(value) < 18) {
                            const error = 'Need to be of legal age';
                            setState(() {
                              _errores.add(error);
                            });
                            return error;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: spaceFormInput),
                      const Text('DNI', style: textStyle),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        controller: dniController,
                        keyboardType: TextInputType.number,
                        style: inputTextStyle,
                        maxLength: 8,
                        decoration: inputDecoration.copyWith(
                            hintText: "Enter your DNI"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            const error = 'Please enter your DNI';
                            setState(() {
                              _errores.add(error);
                            });
                            return error;
                          }
                          if (value.length != 8) {
                            const error = 'Invalid DNI';
                            setState(() {
                              _errores.add(error);
                            });
                            return error;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: spaceFormInput),
                      const Text(
                        'Email',
                        style: textStyle,
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: inputTextStyle,
                        decoration: inputDecoration.copyWith(
                            hintText: "Enter your Email"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            const error = 'Please enter your Email';
                            setState(() {
                              _errores.add(error);
                            });
                            return error;
                          }
                          if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value) ==
                              false) {
                            String error = 'Invalid Email $value';
                            setState(() {
                              _errores.add(error);
                            });
                            return error;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: spaceFormInput),
                      const Text(
                        'Phone',
                        style: textStyle,
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        style: inputTextStyle,
                        maxLength: 9,
                        decoration: inputDecoration.copyWith(
                            hintText: "Enter your phone"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            const error = 'Please enter your Phone';
                            setState(() {
                              _errores.add(error);
                            });
                            return error;
                          }
                          if (value.length != 9) {
                            const error = 'Please enter a valid Phone';
                            setState(() {
                              _errores.add(error);
                            });
                            return error;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: spaceFormInput),
                      const Text(
                        'Password',
                        style: textStyle,
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        controller: passController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        style: inputTextStyle,
                        decoration: inputDecoration.copyWith(
                            hintText: "Enter your Password"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            const error = 'Please enter your Password';
                            setState(() {
                              _errores.add(error);
                            });
                            return error;
                          }
                          if (value.length < 5) {
                            const error =
                                'The password must be greater than 5 digits';
                            setState(() {
                              _errores.add(error);
                            });
                            return error;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: spaceFormInput),
                      const Text(
                        'Gender',
                        style: textStyle,
                      ),
                      const SizedBox(height: 8.0),
                      DropdownButtonFormField(
                          validator: (value) {
                            if (value == "Gender") {
                              const error = 'Please select a Gender';
                              setState(() {
                                _errores.add(error);
                              });
                              return error;
                            }
                            return null;
                          },
                          onChanged: (String? v) {
                            setState(() {
                              gender = v;
                            });
                          },
                          value: gender,
                          items: <String>["Gender", "Female", "Male", "Other"]
                              .map((v) => DropdownMenuItem(
                                    value: v,
                                    child: Text(
                                      v,
                                      style: inputTextStyle,
                                    ),
                                  ))
                              .toList()),
                      const SizedBox(height: spaceFormInput),
                      !isLoading
                          ? Center(
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(
                                          const Size(200, 50)),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              const Color.fromARGB(
                                                  255, 83, 80, 80))),
                                  onPressed: (() async {
                                    List<String> err = _errores;
                                    _errores.clear();
                                    bool validated =
                                        _formKey.currentState!.validate();
                                    if (validated) {
                                      DatabaseService service =
                                          DatabaseService();
                                      Clients client = Clients(
                                        name: nameController.text,
                                        age: int.parse(ageController.text),
                                        dni: int.parse(dniController.text),
                                        email: emailController.text,
                                        phone: int.parse(phoneController.text),
                                        gender: gender!,
                                      );
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await service.addEmployee(
                                          client, context);

                                      setState(() {
                                        isLoading = false;
                                      });
                                    } else if (validated == false) {
                                      showModalBottomSheet(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        )),
                                        builder: (context) => Center(
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 90,
                                                width: 90,
                                                child: RiveAnimation.asset(
                                                  'lib/assets/rive/error.riv',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Text(
                                                "Se encontraron errores en",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: Colors.grey[300],
                                                  ),
                                                  margin: const EdgeInsets.only(
                                                      left: 30, right: 30),
                                                  child: ListView.builder(
                                                    itemCount:
                                                        err.toSet().length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final error = err[index];
                                                      return ListTile(
                                                        title: Text(
                                                          error,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 13),
                                                        ),
                                                        leading: const SizedBox(
                                                          height: 40,
                                                          width: 40,
                                                          child: RiveAnimation
                                                              .asset(
                                                            'lib/assets/rive/error.riv',
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  backgroundColor:
                                                      Colors.red[300],
                                                ),
                                                child: const Text(
                                                  'Close',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    _errores.clear();
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
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
