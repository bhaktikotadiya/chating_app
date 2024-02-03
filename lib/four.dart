import 'package:chating_app/one.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main()
{
      runApp(MaterialApp(
        home: four(),
        debugShowCheckedModeBanner: false,
      ));
}
class four extends StatefulWidget {
  final val;
  four([this.val]);

  // const four({super.key});

  @override
  State<four> createState() => _fourState();
}

class _fourState extends State<four> {

  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('chat_msg_data');
  List msg = [];
  List id_key = [];

  TextEditingController t1 = TextEditingController();
  // DatabaseReference? starCountRef;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final send_name = widget.val['name'];
    // print("${widget.val}");
    // starCountRef.onValue.listen((DatabaseEvent event) {
    //   final data = event.snapshot.value;
    //   Map m = data as Map;
    //   print("m : $m");
    //   msg = m.values.toList();
    //   print("${msg}");
    // });
    get_msg();
  }

  get_msg()
  {
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      Map m = data as Map;
      print("m : $m");
      msg = m.values.toList();
      id_key = m.keys.toList();
      print("${id_key}");
      print("${msg}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.val['name']}"),
          backgroundColor: Colors.black,
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.video_call_sharp,color: Colors.white),),
            IconButton(onPressed: (){}, icon: Icon(Icons.call,color: Colors.white),),
            IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,color: Colors.white),),
          ],
        ),
      backgroundColor: Colors.grey.shade800,
      body: Column(children: [
        Expanded(flex: 10,
          child: Container(
            child: StreamBuilder(
              stream: starCountRef.onValue,
              builder: (context, snapshot) {
                if(snapshot.connectionState==ConnectionState.active)
                  {
                    return ListView.builder(
                          itemCount: msg.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Align(alignment: Alignment.centerRight,child: Text("${msg[index]['msg']}",style: TextStyle(color: Colors.white,))),
                            );
                          },
                        );
                  }
                else
                  {
                    return Center(child: CircularProgressIndicator());
                  }
            },),
          ),
        ),
        Row(children: [
          Expanded(flex: 3,child:
            TextField(
              controller: t1,
              style: TextStyle(color: Colors.white,),
            decoration: InputDecoration(
              suffix: Container(
                child: Wrap(alignment: WrapAlignment.spaceAround,children: [
                  Icon(Icons.attachment,color: Colors.white),
                  Icon(Icons.currency_rupee_sharp,color: Colors.white),
                  Icon(Icons.camera_alt,color: Colors.white),
                ]),
              ),
              prefixIcon: Icon(Icons.emoji_emotions_rounded,color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.white),
              hintText: "Type in your text",
              fillColor: Colors.black12,
            ),
          ),
          ),
          InkWell(
            onTap: () async {
              DatabaseReference ref = FirebaseDatabase.instance.ref("chat_msg_data").push();
              await ref.set({
                "msg": "${t1.text}",
                "sender": "${widget.val['name']}",
                "reciver": "${one.prefs!.getString('name') ?? ""}"
              });
              //how to store multiple data in id and same database wise in realtime database flutter
              t1.text="";
            },
            child: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(Icons.send_sharp,color: Colors.black),
            ),
          )
        ],)
      ]),
    );
  }
}
