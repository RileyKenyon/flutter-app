import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class DndManager extends StatefulWidget {
  const DndManager({super.key});

  @override
  State<DndManager> createState() => _DndManager();
}

class _DndManager extends State<DndManager> {
  final Future<Response<dynamic>> _future = getDndApiList("monsters");

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Response<dynamic>>(
        future: _future,
        builder: (context, snapshot) {
          Widget child;
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data?.statusCode == 200) {
            // child = Text('Result: ${snapshot.data}');
            child = ListView.builder(
              itemCount: snapshot.data?.data['count'],
              prototypeItem: ListTile(title: Text("Prototype")),
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(snapshot.data?.data['results'][index]['name']));
              },
            );
          } else {
            child = const Icon(Icons.refresh);
          }
          return Center(child: child);
        },
      ),
    );
  }
}

Future<Response<dynamic>> getDndApiList(String query) async {
  final dio = Dio();
  final response = await dio.get('https://www.dnd5eapi.co/api/${query}');
  return response;
}
