import 'dart:convert';

import 'package:atho/mock/json.dart';
import 'package:atho/models/uf.dart';
import 'package:atho/models/user.dart';
import 'package:atho/views/widgets/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:atho/controllers/signup_controller.dart';
import 'package:atho/stores/app.store.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = new SignupController();
  var model = new UserModel(name: '', lastname: '', email: '');

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    var store = Provider.of<AppStore>(context);
    model.token = store.user!.token;
    final List<UF> uFs = UFs.fromJson(jsonDecode(statesJson));
// <DropdownMenuItem<String>>
    final List<DropdownMenuItem<String>>? dropdownItems = uFs
        .map<DropdownMenuItem<String>>((UF value) => DropdownMenuItem<String>(
              value: value.sigla,
              child: Text(
                value.nome,
              ),
            ))
        .toList();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 40, 24, 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Headline(
                        'Vamos começar',
                        color: Colors.black,
                        size: 4,
                        padding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      SubHeadline(
                          'Fale um pouco sobre você para que possamos criar seu plano pessoal',
                          color: Colors.black,
                          size: 1,
                          padding: EdgeInsets.symmetric(vertical: 8))
                    ],
                    // child: RichText(
                    //     text: TextSpan(
                    //         text: "Seja Bem Vindo ",
                    //         style: TextStyle(fontSize: 18, color: Colors.black),
                    //         children: [
                    //       TextSpan(
                    //           text: store.user.name,
                    //           style: TextStyle(
                    //               fontSize: 22,
                    //               color: Colors.black,
                    //               fontWeight: FontWeight.bold)),
                    //       TextSpan(
                    //           text:
                    //               ', favor completar e confirmar seus dados cadastrais.')
                    //     ])),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    initialValue: store.user!.name,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle),
                      labelText: "Nome",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nome Inválido';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      model.name = val!;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: store.user!.lastname,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Sobrenome",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'SobreNome Inválido';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      model.lastname = val!;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: store.user!.cpf,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "CPF",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'CPF Inválido';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      model.cpf = val;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: store.user?.phone,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Telefone",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Telefone Inválido';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      model.phone = val;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: store.user!.city,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Cidade",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Cidade Inválida';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      model.city = val;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    hint: Text('hint'),
                    value: 'MG',
                    // dropdownColor: Colors.blue[800],
                    style: TextStyle(color: Colors.black),
                    onChanged: ((s) {}),
                    items: dropdownItems,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: store.user!.company,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Empresa",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Empresa Inválida';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      model.city = val;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: store.user!.jobTitle,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Função",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Função Inválida';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      model.jobTitle = val;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 45,
                        child: TextButton(
                          child: Text("CONTINUAR",
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              setState(() {});
                              _controller.update(model).then((data) {
                                setState(() {});
                                store.setUser(data);
                                Navigator.pushNamed(context, '/home');
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
