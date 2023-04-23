import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:go_router/go_router.dart';

class DndManager extends StatefulWidget {
  const DndManager({super.key});

  @override
  State<DndManager> createState() => _DndManager();
}

class _DndManager extends State<DndManager> {
  final Future<Response<dynamic>> _future = getDndApiList("monsters");
  final Future<Image> _futureImage =
      getDndApiImage("images/monsters/adult-black-dragon.png");
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
            child = ListView.builder(
              itemCount: snapshot.data?.data['count'],
              prototypeItem: const ListTile(title: Text("Prototype")),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data?.data['results'][index]['name']),
                  onTap: () => (context.push('/monster-detail',
                      extra: Monster(
                          url: snapshot.data?.data['results'][index]['name']
                              as String,
                          name: snapshot.data?.data['results'][index]['name']
                              as String))),
                );
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

class Monster {
  Monster({required this.url, required this.name});
  final String name;
  final String url;
}

Future<Response<dynamic>> getDndApiList(String query) async {
  final dio = Dio();
  final response = await dio.get('https://www.dnd5eapi.co/api/${query}');
  return response;
}

Future<Image> getDndApiImage(String query) async {
  // child: FutureBuilder<Image>(
  // future: _futureImage,
  // builder: (context, snapshot) {
  //   Widget child;
  //   if (snapshot.hasData)
  //   child = snapshot.data!;
  return Image.network('https://www.dnd5eapi.co/api/$query');
}
