import 'package:chating_app/four.dart';
import 'package:chating_app/one.dart';
import 'package:chating_app/two.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main()
{
  runApp(MaterialApp(
    home: three(),debugShowCheckedModeBanner: false,
  ));
}
class three extends StatefulWidget {
  const three({super.key});

  @override
  State<three> createState() => _threeState();
}

class _threeState extends State<three> {


  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('chatt');
  String name = "";
  List val = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    name = one.prefs!.getString('name') ?? "";

    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      Map m = data as Map;
      // print("m : $m");
      val = m.values.toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${name}"),
        backgroundColor: Colors.black,
        actions: [
          TextButton(onPressed: (){
            one.prefs!.setBool('status', false);
            one.prefs!.remove('name');
            one.prefs!.remove('contact');
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return two();
            },));
          }, child: Text("LOG OUT",style: TextStyle(color: Colors.white),))
        ],
      ),
      backgroundColor: Colors.grey.shade700,
      body: StreamBuilder(stream: starCountRef.onValue, builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.active)
        {
          return ListView.builder(
            itemCount: val.length,
            itemBuilder: (context, index) {
              return (name!=val[index]['name'])?Card(
                child: ListTile(
                  onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return four(val[index]);
                      },));
                  },
                  tileColor: Colors.black,
                  leading: CircleAvatar(backgroundColor: Colors.white),
                  title: Text("${val[index]['name']}",style: TextStyle(color: Colors.white)),
                ),
              ):Text("");
            },);
        }
        else
        {
            return CircularProgressIndicator();
        }
      },)
    );
  }
}
