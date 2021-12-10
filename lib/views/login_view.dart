import 'package:atho/controllers/login_controller.dart';
import 'package:atho/models/logindata.dart';
import 'package:atho/repositories/account_repository.dart';
import 'package:atho/repositories/api.dart';
import 'package:atho/stores/app.store.dart';
import 'package:atho/views/widgets/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HorizontalOrLine extends StatelessWidget {
  final String label;

  final double height;
  const HorizontalOrLine({
    required this.label,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 10.0, right: 15.0),
            child: Divider(
              color: Colors.black,
              height: height,
            )),
      ),
      Text(label),
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: Divider(
              color: Colors.black,
              height: height,
            )),
      ),
    ]);
  }
}

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  final emailController = new TextEditingController();
  final passController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final accountRepository = AccountRepository(api);
  bool _displayError = false;

  late LoginController _controller;
  late String _buttonText;

  late AnimationController _animPasswordController;
  late Animation<double> _animationPassword;

  Widget build(BuildContext context) {
    final store = Provider.of<AppStore>(context, listen: false);

    return Scaffold(
      body: Builder(
        builder: (context) => SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 400,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 96, 16, 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 320,
                                constraints: BoxConstraints(minWidth: 320),
                                child: Image.asset(
                                  'assets/images/logo.png',
                                ),
                              ),
                              SizedBox(height: 58.0),
                              AnimatedContainer(
                                margin: EdgeInsets.symmetric(vertical: 16),
                                height: _displayError ? 120 : 0,
                                duration: Duration(milliseconds: 500),
                                child: ClipRect(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(15),
                                    leading: Icon(
                                      Icons.block,
                                      color: Colors.red,
                                    ),
                                    tileColor: Colors.red[100],
                                    title: Text(
                                        'Você ainda nao foi convidado para esse aplicativo.'),
                                    subtitle: Text(
                                        'Entre em contato com seu departamento de TI ou o gerente para obter ajuda.'),
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: emailController,
                                validator: _validateEmail,
                                onTap: (() {
                                  _animPasswordController.animateBack(0);
                                  setState(() {
                                    _displayError = false;
                                    _buttonText = 'CONTINUAR';
                                  });
                                }),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(FontAwesomeIcons.envelope),
                                  labelText: 'Email',
                                ),
                                //filled: true,
                              ),
                              SizedBox(height: 20.0),
                              SizeTransition(
                                //duration: Duration(milliseconds: 600),
                                //constraints: BoxConstraints(),
                                axis: Axis.vertical,
                                sizeFactor: _animationPassword,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        obscureText: true,
                                        controller: passController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          prefixIcon:
                                              Icon(FontAwesomeIcons.lock),
                                          labelText: 'Senha',
                                        ),
                                      ),
                                      SizedBox(height: 20.0),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: 45,
                                      child: TextButton(
                                          onPressed: () async {
                                            if (_buttonText == 'CONTINUAR') {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                checkEmail();
                                              }
                                            } else {
                                              _login(store, context);
                                            }
                                          },
                                          child: Text(_buttonText,
                                              style: TextStyle(
                                                  color: Colors.white))),
                                    ),
                                    // FlatButton(
                                    //     onPressed: () async {
                                    //       if (_buttonText == 'CONTINUAR') {
                                    //         if (_formKey.currentState.validate()) {
                                    //           checkEmail();
                                    //         }
                                    //       } else {
                                    //         _login(store, context);
                                    //       }
                                    //     },
                                    //     splashColor: Colors.white,
                                    //     color: Theme.of(context).primaryColor,
                                    //     disabledColor: Colors.grey[300],
                                    //     padding: EdgeInsets.all(16.0),
                                    //     child: Text(_buttonText,
                                    //         style: TextStyle(color: Colors.white))),
                                  ]),
                            ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animPasswordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    //timeDilation = 5;
    _buttonText = 'CONTINUAR';
    _controller = LoginController(AccountRepository(api));

    _animPasswordController = (AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1400),
    ));

    _animationPassword = CurvedAnimation(
      parent: _animPasswordController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void checkEmail() async {
    print('ckecking');
    if (await accountRepository.verifyEmail(emailController.text)) {
      _animPasswordController.forward();
      setState(() {
        _buttonText = 'LOGIN';
      });
    } else {
      showErrorToast(context,
          title: 'Você ainda nao foi convidado para esse aplicativo.',
          message:
              'Entre em contato com seu departamento de TI ou o gerente para obter ajuda.',
          duration: Duration(seconds: 8));
    }
  }

  String? _validateEmail(String? email) {
    if (email!.isEmpty) return "O email é obrigatório";
    RegExp emailPattern = RegExp(
        r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    print(emailPattern.hasMatch(email).toString());
    return emailPattern.hasMatch(email)
        ? null
        : 'Este não é um Endereço de Email válido';
  }

  _login(AppStore store, BuildContext context) async {
    final logindata =
        LoginModel(email: emailController.text, password: passController.text);

    final user = await _controller.login(logindata);

    if (_controller.state == LoginState.success) {
      store.setUser(user);
      Navigator.pushNamed(context, '/signup');
    } else if (_controller.state == LoginState.error) {
      showErrorToast(context, message: 'Usuário ou senha inválida.');
      // Scaffold.of(context)
      //     .showSnackBar(SnackBar(content: Text('Usuário ou senha inválida.')));
    }
  }
}
