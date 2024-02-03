import 'package:chating_app/two.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
    runApp(MaterialApp(
      home: one(),debugShowCheckedModeBanner: false,
    ));
}
class one extends StatefulWidget {
  // const one({super.key});
  static SharedPreferences? prefs;

  @override
  State<one> createState() => _oneState();
}

class _oneState extends State<one> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 10,),
            TextFormField(
              controller: t1,
              // keyboardType: TextInputType.numberWithOptions(),
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
            SizedBox(height: 10,),
            TextFormField(
              controller: t2,
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
            SizedBox(height: 10,),
            TextFormField(
              controller: t3,
              // keyboardType: TextInputType.numberWithOptions(),
              style: TextStyle(color: Colors.teal),
              decoration: InputDecoration(
                  hintText: "Enter email",
                  labelText: "email",
                  prefixIcon: Icon(Icons.email_outlined, color: Colors.teal.shade300),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.teal.shade100,width: 3),
                  ),
                  labelStyle: const TextStyle(color: Colors.teal)),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: t4,
              // keyboardType: TextInputType.numberWithOptions(),
              style: TextStyle(color: Colors.teal),
              decoration: InputDecoration(
                  hintText: "Enter password",
                  labelText: "password",
                  prefixIcon: Icon(Icons.password, color: Colors.teal.shade300),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.teal.shade100,width: 3),
                  ),
                  labelStyle: const TextStyle(color: Colors.teal)),
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: () async {

              print("click");
              DatabaseReference ref = FirebaseDatabase.instance.ref("chatt").push();
              await ref.set({
                "name": "${t1.text}",
                "contact": "${t2.text}",
                "email": "${t3.text}",
                "password": "${t4.text}"
              });


              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return two();
              },));

            }, child: Text("submit")),
          ],
        ),
      ),
    );
  }
}
