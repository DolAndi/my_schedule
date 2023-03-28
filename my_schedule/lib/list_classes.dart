import 'package:flutter/material.dart';
import 'package:my_schedule/confs/routes.dart';
import 'package:my_schedule/model/class.dart';
import 'package:my_schedule/new_class.dart';

class ListClasses extends StatefulWidget {
  const ListClasses({Key? key}) : super(key: key);

  @override
  State<ListClasses> createState() => _ListClassesState();
}

class _ListClassesState extends State<ListClasses> {
  List<MyClass> classes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Minhas aulas"),
          actions: [
            IconButton(
              onPressed: () {
                Future future = Navigator.of(context).pushNamed(ADD_CLASS_PAGE);
                future.then((myClass) {
                  if (myClass != null) {
                    setState(() {
                      classes.add(myClass);
                    });
                  }
                });
              },
              icon: const Icon(Icons.add_circle),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  classes.clear();
                });
              },
              child: const Text('Limpar lista'),
            ),
          ],
        ),
        body: ListView.separated(
          itemBuilder: (context, index) => buildItem(classes[index]),
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemCount: classes.length,
        ));
  }

  Widget buildItem(MyClass myClass) => ListTile(
        leading: myClass.like ? const Icon(Icons.favorite) : const Icon(Icons.favorite_outline),
        title: Text(myClass.name),
        subtitle: Text(myClass.dayOfWeek),
        trailing: Text(myClass.local),
        onLongPress: () {
          setState(() {
            myClass.like = !myClass.like;
          });
        },
      );
}
