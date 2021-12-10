import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_login/src/providers/auth.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_login/src/widgets/auth_card.dart';
// import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  final emailController = new TextEditingController();
  final passController = new TextEditingController();

  late bool isButtonDisabled;
  // late FacebookLogin plugin;
  late AnimationController _loadingController;
  late AnimationController _animPasswordController;
  late Animation<double> _animationPassword;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    //const headerMargin = 15;
    const cardInitialHeight = 300;
    final cardTopPosition = deviceSize.height / 2 - cardInitialHeight / 2;
    // final headerHeight = cardTopPosition - headerMargin;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => Auth(
                  onLogin: _loginUser,
                  onSignup: _loginUser,
                  onRecoverPassword: _recoverPassword,
                )),
        ChangeNotifierProvider.value(value: LoginMessages())
      ],
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: AuthCard(
                userType: LoginUserType.email,
                padding: EdgeInsets.only(top: cardTopPosition),
                loadingController: _loadingController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _loadingController.dispose();
    _animPasswordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    //timeDilation = 5;
    isButtonDisabled = true;
    // plugin = FacebookLogin(debug: true);
    print('loginview initistate');

    _loadingController = (AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1400),
    ));

    Future.delayed(const Duration(seconds: 3), () {
      _loadingController.forward();
    });
    _animationPassword = CurvedAnimation(
      parent: _animationPassword,
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<String> _loginUser(LoginData data) {
    return Future.delayed(Duration(milliseconds: 200))
        .then((_) => 'Password does not match');
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(Duration(milliseconds: 200))
        .then((_) => 'Username not exists');
  }
}
