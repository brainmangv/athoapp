import 'package:atho/models/course.dart';
import 'package:atho/repositories/account_repository.dart';
import 'package:atho/repositories/api.dart';
import 'package:atho/stores/app.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class ExplorerTab extends StatefulWidget {
  @override
  _ExplorerState createState() => _ExplorerState();
}

class _ExplorerState extends State<ExplorerTab> {
  final accountRepository = AccountRepository(api);
  late List<SubscribedCourse> items;

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<AppStore>(context, listen: false);
    items = store.user!.subscribedCourses!;
    _buildSubTitle({required DateTime limiteDate, required double percent}) {
      limiteDate =
          limiteDate.add(Duration(hours: 23, minutes: 59, seconds: 59));
      final DateFormat formatter = DateFormat('dd/MM/yy');
      final String date = formatter.format(limiteDate);
      final bool dateisOver = limiteDate.isBefore(DateTime.now());

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                FontAwesomeIcons.solidCalendar,
                size: 12.0,
                color: Colors.red,
              ),
              SizedBox(width: 5),
              Text(
                'Data limite: ' + date,
                style: TextStyle(
                    color: Colors.red,
                    decoration: dateisOver ? TextDecoration.lineThrough : null),
              ),
            ],
          ),
          SizedBox(height: 5),
          LinearPercentIndicator(
            center: Text('${(percent * 100).toString()} %',
                style: TextStyle(color: Colors.white)),
            lineHeight: 15,
            backgroundColor: Colors.grey,
            progressColor: Colors.green,
            percent: percent,
          )
        ],
      );
    }

    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        padding: const EdgeInsets.all(8),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int i) {
          return ListTile(
              leading: Image.network(
                items[i].thumbnailUrl,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
              title: Text(items[i].title),
              subtitle: _buildSubTitle(
                  limiteDate: items[i].limiteDate,
                  percent: items[i].completionRate));
        });
  }
}
