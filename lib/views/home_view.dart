import 'dart:core';
import 'dart:ui';

import 'package:atho/models/course.dart';
import 'package:atho/stores/app.store.dart';
import 'package:atho/views/widgets/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'explorer_view.dart';
import 'profile_view.dart';

class ExplorerTitle extends StatefulWidget {
  @override
  _ExplorerTitleState createState() => _ExplorerTitleState();
}

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<AppStore>(context, listen: true);

    Widget _buildUsage() {
      //final TextTheme theme = Theme.of(context).textTheme;
      final width = MediaQuery.of(context).size.width;
      //final height = 147.5;

      return Center(
        child: Container(
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(8),
          constraints: BoxConstraints(maxWidth: 768),
          width: width,

          //height: height,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(color: Colors.black, blurRadius: 6),
              ],
              image: DecorationImage(
                image: AssetImage('assets/images/aproveitamento.jpg'),
                fit: BoxFit.cover,
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Headline(
                'Seu Aproveitamento no Curso',
                color: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Headline(
                    '${(store.user!.courseAchievement() * 100).toStringAsFixed(0)} %',
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      strokeWidth: 8,
                      value: store.user!.courseAchievement(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 200,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18)),
                child: Center(child: Text('5 Cursos concluídos de 30')),
              )
            ],
          ),
        ),
      );
    }

    Widget _buildBanner(
        {required SubscribedCourse course,
        required double width,
        required double height}) {
      String title = course.title;
      DateTime limiteDate = course.limiteDate;
      Image image = Image.network(
        course.thumbnailUrl,
        width: width - 16,
        height: height,
        fit: BoxFit.cover,
      );
      limiteDate =
          limiteDate.add(Duration(hours: 23, minutes: 59, seconds: 59));
      final DateFormat formatter = DateFormat('dd/MM/yy');
      final String date = formatter.format(limiteDate);
      final bool dateisOver = limiteDate.isBefore(DateTime.now());
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Container(
          width: width,
          child: Stack(
            children: [
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                clipBehavior: Clip.hardEdge,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: width,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: image),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 40,
                          child: Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 7),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              FontAwesomeIcons.solidCalendar,
                              size: 12.0,
                              color: Colors.red,
                            ),
                            SizedBox(width: 2),
                            Text(
                              'Data limite: ' + date,
                              style: TextStyle(
                                  color: Colors.red,
                                  decoration: dateisOver
                                      ? TextDecoration.lineThrough
                                      : null),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('INICIAR CURSO',
                                style: TextStyle(color: Colors.blue)),
                            SizedBox(width: 37),
                            Icon(
                              Icons.arrow_right,
                              color: Colors.red,
                              size: 30,
                            )
                          ],
                        ),
                        //SizedBox(height: 20)
                      ]),
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    // splashColor: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => Navigator.pushNamed(context, '/course',
                        arguments: course),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildCarousel(
        {required String title, required List<SubscribedCourse>? courses}) {
      final List<Widget> items = courses != null
          ? courses
              .map((course) =>
                  _buildBanner(course: course, width: 180, height: 90))
              .toList()
          : [];
      items.insert(0, Padding(padding: EdgeInsets.fromLTRB(8, 0, 0, 0)));
      Color? getColor(Set<MaterialState> states) {
        return Colors.grey[50];
      }

      items.add(Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: TextButton(
              //minWidth: width - 16,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(getColor)),
              onPressed: (() => print('click')),
              child: Headline('Ver tudo', color: Colors.black))));

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Headline(title, color: Colors.black),
          ),
          Container(
            height: 244,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: items,
            ),
          ),
        ],
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildUsage(),
                _buildCarousel(
                    title: 'Cursos Inscritos',
                    courses: store.user?.subscribedCourses),
                _buildCarousel(
                    title: 'Cursos Finalizados',
                    courses: store.user?.subscribedCourses),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class ProfileTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Headline(
      'Perfil do Usuário',
    );
  }
}

class HomeTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<AppStore>(context, listen: false);
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Bem vindo',
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
        Headline('${store.user!.name} ${store.user!.lastname}')
      ]),
      CircleAvatar(
          radius: 20,
          //backgroundImage: NetworkImage(store.user.picture!),
          child: Text(
              "${store.user!.name[0].toUpperCase()} ${store.user!.lastname[0].toUpperCase()}"))
    ]);
  }
}

class _ExplorerTitleState extends State<ExplorerTitle> {
  String? dropdownValue = 'Todos os Cursos';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      style: TextStyle(color: Colors.white),
      dropdownColor: Colors.blue[800],
      isExpanded: true,
      value: dropdownValue,
      iconSize: 24,
      elevation: 8,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue;
          print(newValue);
        });
      },
      items: <String>[
        'Todos os Cursos',
        'Cursos em Andamento',
        'Cursos Finalizados',
        'Cursos Vencidos'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Headline(value),
        );
      }).toList(),
    );
  }
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  List _tab = [
    HomeTab(),
    ExplorerTab(),
    ProfileTab(),
  ];

  List appTitle = [HomeTitle(), ExplorerTitle(), ProfileTitle()];

  @override
  void initState() {
    super.initState();
    print('Home initState');
  }

  @override
  Widget build(BuildContext context) {
    print('Home build');
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF3594DD),
          elevation: 0,
          title: appTitle[_selectedIndex],
        ),
        bottomNavigationBar: _buildBottonNavigationBar(),
        body: _tab[_selectedIndex],
      ),
    );
  }

  Widget _buildBottonNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Color(0xFFFFFFFF),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Explorar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Perfil',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int i) {
    setState(() {
      _selectedIndex = i;
      print(_selectedIndex);
    });
  }
}

class MyTicket extends TickerProvider {
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
