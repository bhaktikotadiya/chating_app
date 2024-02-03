import 'package:chating_app/one.dart';
import 'package:chating_app/three.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    home: two(),debugShowCheckedModeBanner: false,
  ));
}
class two extends StatefulWidget {
  const two({super.key});

  @override
  State<two> createState() => _twoState();
}

class _twoState extends State<two> {

  List id_key = [];
  List val = [];
  bool t = false;
  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('chatt');


  TextEditingController t5 = TextEditingController();
  TextEditingController t6 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  get()
  async {
    one.prefs=await SharedPreferences.getInstance();
      bool? islogin = one.prefs!.getBool('status');
      if(islogin==true)
      {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return three();
          },));
      }
      else
      {
           final name = one.prefs!.getString('name');
           final contact = one.prefs!.getString('contact');
           if(name!=null && contact!=null)
           {
             Navigator.push(context, MaterialPageRoute(builder: (context) {
               return three();
             },));
           }
      }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          padding: EdgeInsets.all(30),
          child: Column(children: [
            TextFormField(
              controller: t5,
              style: TextStyle(color: Colors.teal),
              decoration: InputDecoration(
                  hintText: "Enter name",
                  labelText: "name",
                  prefixIcon: Icon(Icons.account_circle, color: Colors.teal.shade300),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.teal.shade100,width: 3),
                  ),
                  labelStyle: const TextStyle(color: Colors.teal)),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: t6,
              // keyboardType: TextInputType.numberWithOptions(),
              style: TextStyle(color: Colors.teal),
              decoration: InputDecoration(
                  hintText: "Enter contact",
                  labelText: "contact",
                  prefixIcon: Icon(Icons.phone, color: Colors.teal.shade300),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.teal.shade100,width: 3),
                  ),
                  labelStyle: const TextStyle(color: Colors.teal)),
            ),
            ElevatedButton(onPressed: (){

              starCountRef.onValue.listen((DatabaseEvent event) {
                final data = event.snapshot.value;
                Map m = data as Map;
                val = m.values.toList();
                print(val);

                for(int i=0;i<val.length;i++)
                {
                  if(t5.text == val[i]['name'] && t6.text == val[i]['contact'])
                  {
                    t=true;
                  }
                  // else
                  // {
                    // showDialog(context: context, builder: (context) {
                    //   return AlertDialog(
                    //     title: Text("Invalid name or contact"),
                    //     actions: [
                    //       TextButton(onPressed: (){
                    //         Navigator.pop(context);
                    //       }, child: Text("OK")),
                    //     ],
                    //   );
                    // },);
                  // }
                }
                if(t==true)
                {
                  one.prefs!.setString('name', t5.text);
                  one.prefs!.setString('contact', t6.text);
                  one.prefs!.setBool('status', true);
                  print("success");
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return three();
                  },));
                }

              });

            }, child: Text("login")),
            SizedBox(height: 20),
            InkWell(onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return one();
              },));
            },child: Text("New login")
            ),
          ]),
        )
      ),
    );
  }
}
