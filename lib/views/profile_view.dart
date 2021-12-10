import 'package:atho/stores/app.store.dart';
import 'package:atho/views/widgets/widget_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<AppStore>(context, listen: false);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 60,
                      // child: Text('AH'),
                      backgroundImage: NetworkImage(
                        store.user!.picture!,
                      ))
                ],
              ),
              SizedBox(height: 30),
              Text(
                '${store.user!.name} ${store.user!.lastname}',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  children: [
                    ListTile(
                      //selectedTileColor: Colors.blueAccent,
                      tileColor: Colors.white,
                      title: Text('Nome'),
                      subtitle:
                          Text('${store.user!.name} ${store.user!.lastname}'),
                      leading: Icon(
                        Icons.account_circle,
                        size: 40,
                        color: Colors.blue,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: 15),
                      onTap: (() {}),
                    ),
                    ListTile(
                      autofocus: true,
                      enabled: true,
                      leading: Icon(
                        Icons.email,
                        size: 40,
                        color: Colors.blue,
                      ),
                      focusColor: Colors.red,
                      trailing: Icon(Icons.arrow_forward_ios, size: 15),
                      onTap: (() {}),
                      title: Text('Email'),
                      subtitle: Text(store.user!.email),
                    ),
                    ListTile(
                      autofocus: true,
                      enabled: true,
                      leading: Icon(
                        Icons.phone,
                        size: 40,
                        color: Colors.blue,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: 15),
                      onTap: (() {}),
                      title: Text('Fone'),
                      subtitle: Text(store.user!.phone ?? ''),
                    ),
                    ListTile(
                      autofocus: true,
                      enabled: true,
                      leading: Icon(
                        Icons.apartment,
                        size: 40,
                        color: Colors.blue,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: 15),
                      onTap: (() {}),
                      title: Text('Cidade'),
                      subtitle: Text(store.user!.city ?? ''),
                    ),
                    ListTile(
                      autofocus: true,
                      enabled: true,
                      leading: Icon(
                        Icons.account_balance,
                        size: 40,
                        color: Colors.blue,
                      ),
                      focusColor: Colors.red,
                      trailing: Icon(Icons.arrow_forward_ios, size: 15),
                      onTap: (() {}),
                      title: Text('Estado'),
                      subtitle: Text(store.user!.uf ?? ''),
                    ),
                    ListTile(
                      autofocus: true,
                      enabled: true,
                      leading: Icon(
                        Icons.business_center,
                        size: 40,
                        color: Colors.blue,
                      ),
                      focusColor: Colors.red,
                      trailing: Icon(Icons.arrow_forward_ios, size: 15),
                      onTap: (() {}),
                      title: Text('Empresa'),
                      subtitle: Text(store.user!.company ?? ''),
                    ),
                    ListTile(
                      // autofocus: true,
                      // enabled: true,
                      leading: Icon(
                        Icons.assignment_ind,
                        size: 40,
                        color: Colors.blue,
                      ),

                      trailing: Icon(Icons.arrow_forward_ios, size: 15),
                      onTap: (() {}),
                      title: Text('Cargo'),
                      subtitle: Text(store.user!.jobTitle ?? ''),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Headline(
                'Sair',
                usePrimaryColor: true,
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
