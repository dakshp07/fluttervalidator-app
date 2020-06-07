import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.deepOrangeAccent,
      ),
      home: FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  String email;
  String password;

  final fkey = GlobalKey <FormState>();
  final scaff = GlobalKey <ScaffoldState>();

  void submit(){
    if(fkey.currentState.validate()){
      fkey.currentState.save();
      login();
    }
  }
  void login(){
    final snackb = new SnackBar(
        content: new Text("Email-ID : $email , Password : $password"),
    ) ;
    scaff.currentState.showSnackBar(snackb);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Form Validation",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
      ),
      key: scaff,
      body: new Container(
        padding: const EdgeInsets.all(40),
        child: new Form(
          key: fkey,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new TextFormField(
                  decoration: new InputDecoration(
                    icon: Icon(Icons.mail_outline),
                    labelText: "Enter Email-ID",
                    labelStyle: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.deepOrange),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (val) => val.contains("@" ) ? null : "Invalid Email",
                  onSaved: (val) => email=val,
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                    icon: Icon(Icons.vpn_key),
                    labelText: "Enter Password",
                    labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.deepOrange),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (val) => val.length<6 ? "Password Too Short" : null,
                  onSaved: (val) => password=val,
                  obscureText: true,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Padding(padding: const EdgeInsets.only(top: 75)),
                    new RaisedButton(
                      child: new Text("Submit",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                        onPressed: submit,
                      color: Colors.deepOrange,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    )
                  ],
                )
              ],
            )
        ),
      ),
    );
  }
}

