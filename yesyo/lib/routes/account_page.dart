import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'login.dart';


class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => new _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int currentStep = 0;
  bool complete = false;
  StepperType stepperType = StepperType.horizontal;

  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController nick = TextEditingController();
  String _selectedGender = "Male";
  String _dateofBirth= "Date of Birth";
  DateTime _dateofBirthObject = DateTime.now();
  bool _privacy = false;

  List<String> _genders = ['Male', 'Female'];




  next()
  {
    currentStep < 2 ? setState(() => currentStep += 1): null;
  }

  goTo(int step){
    setState(() {
      currentStep = step;
    });
  }

  cancel (){
    if (currentStep > 0){
      goTo(currentStep - 1);
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('YesYo'),
        leading: TextButton(
          child: Icon(Icons.arrow_back_ios) ,
          onPressed: () {
            Navigator.of(context).pushReplacement(_createRoute());
          },
        ) ,
        backgroundColor: Colors.grey,
      ),
      body: Column(
        children: <Widget>[
          complete ? Expanded(
            child: Center(
              child: AlertDialog(
                title: new Text("Profile Created"),
                content: new Text(
                  "Tada!",
                ),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("Close"),
                    onPressed: () {
                      setState(() => complete = false);
                    },
                  ),
                ],
              ),
            ),
          )
              : Expanded(
            child: Theme(
              data: ThemeData(
                primaryTextTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)),
                textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)),
                primaryColor: Colors.white,
                canvasColor: Colors.grey

              ),
              child: Stepper(
                type: stepperType,
                steps: [
                  Step(
                    title: const Text(''),
                    isActive: currentStep >= 0,
                    state: currentStep >= 0 ? StepState.complete : StepState.disabled,
                    content: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text("Sign Up With Email",
                            style: TextStyle(color: Colors.white),),
                        ),
                        TextFieldsCustom("Email", "abc@gmail.com", false, user),
                        TextFieldsCustom("Password", "123456", true, pass),
                        Container(
                            child: Text("Min 8 characters with 1 uppercase, 1 number, 1 symbol", style: TextStyle(color: Colors.blue),)
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0, bottom: 10.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: InkWell(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.black54,
                                  padding: EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.white, width: 1, ),
                                    borderRadius: BorderRadius.circular(5.0)
                                  ),
                                ),
                                child: Text("SIGN UP", style: TextStyle(color: Colors.blue),),
                                onPressed: (){
                                  register();
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                  ),
                  Step(
                    isActive: currentStep >= 0,
                    state: currentStep >= 1 ? StepState.complete : StepState.disabled,
                    title: const Text(''),
                    content: Column(
                      children: <Widget>[

                        Text("Check "+user.text+" inbox to verify", style: TextStyle(color: Colors.white),),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0, bottom: 10.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: InkWell(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.black54,
                                  padding: EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.white, width: 1, ),
                                      borderRadius: BorderRadius.circular(5.0)
                                  ),
                                ),
                                child: Text("Check Verification", style: TextStyle(color: Colors.blue),),
                                onPressed: (){
                                  verification();
                                },
                              ),
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                  Step(
                    isActive: currentStep >= 0,
                    state: currentStep >= 0 ? StepState.complete : StepState.disabled,
                    title: const Text(''),
                    content: Column(
                      children: <Widget>[
                        TextFieldsCustom("Choose a nickname", "ABC", false, nick),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Text('Gender', style: TextStyle(color: Colors.white),), // Not necessary for Option 1
                              value: _selectedGender,
                              onChanged: (_newValue) {
                                setState(() {
                                  _selectedGender = _newValue.toString();
                                });
                              },
                              items: _genders.map((gen) {
                                return DropdownMenuItem(
                                  child: new Text(gen,style: TextStyle(color: Colors.white),),
                                  value: gen,
                                );
                              }).toList(),
                          ),
                          ),
                        ),
                        TextButton(
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1950, 3, 5),
                              maxTime: DateTime.now(),
                              onChanged: (date) {
                                _dateofBirthObject = date;
                                setState(() {
                                  _dateofBirth = date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();
                                });

                              },
                              onConfirm: (date) {
                                _dateofBirthObject = date;
                                setState(() {
                                  _dateofBirth = date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();
                                });

                              },
                              currentTime: _dateofBirthObject,
                              locale: LocaleType.en
                          );
                        },
                        child: Text(
                          _dateofBirth,
                          style: TextStyle(color: Colors.white),
                        )
                      ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Checkbox(value: _privacy, onChanged: (value){
                                setState(() {
                                  _privacy = value!;
                                });
                              }),
                              Expanded(child: Text("I have read and understood the Privacy Statement.", style: TextStyle(color: Colors.white)))
                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: InkWell(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.black54,
                                padding: EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.white, width: 1, ),
                                    borderRadius: BorderRadius.circular(5.0)
                                ),
                              ),
                              child: Text("Next", style: TextStyle(color: Colors.blue),),
                              onPressed: (){
                                updateDetails();
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
                currentStep: currentStep,
                //onStepContinue: next,
                //onStepTapped: (step) => goTo(step),
                //onStepCancel: cancel,
                controlsBuilder: (BuildContext context, {VoidCallback? onStepContinue, VoidCallback? onStepCancel}){
                  return Row();
                },
              ),
            ),

          ),
        ],

      ),
      backgroundColor: Colors.grey,
    );
  }

  @override
  void dispose() {
    user.dispose();
    pass.dispose();
    super.dispose();
  }

  Future register() async{
    var url = "https://yesyo.net/verification/signup.php";
    var response = await http.post(Uri.parse(url), body: {
    "username": user.text,
    "password": pass.text
    });
    
    var data = jsonDecode(response.body);
    if (data == "Success"){
      next();

    }else{
      if (data == "Error"){

      }else{
        if (data == "This email is already in use."){

        }else{
          if (data == "Password must have atleast 8 characters."){

          }else{
            //Unknown Error
          }
        }
      }
    }

  }
  Future verification() async{
    var url = "https://yesyo.net/verification/check_verification.php";
    var response = await http.post(Uri.parse(url), body: {
      "Email": user.text,
    });

    if(response.body.isNotEmpty) {
      var data = jsonDecode(response.body);
      final snackBar = SnackBar(content: Text(data));

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      if (data == "Success"){
        next();

      }else{
        if (data=="Failed"){
          //Failed
        }
      }
    }


  }

  Future updateDetails() async {

    if (!_privacy){
      final snackBar = SnackBar(content: Text("Accept the privacy statement."));

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }else {
      var url = "https://yesyo.net/verification/update_details.php";
      var response = await http.post(Uri.parse(url), body: {
        "email": user.text,
        "nick": nick.text,
        "gender": _selectedGender=="Male"? "M":"F",
        "dob": _dateofBirth,
      });

      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body);
        final snackBar = SnackBar(content: Text(data));

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        if (data == "Success") {
          Navigator.of(context).pushReplacement(_createRoute());
        } else {
          final snackBar = SnackBar(content: Text(data));

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }else {
        final snackBar = SnackBar(content: Text("Response from server failed"));

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }


  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Login(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);

        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

}


class TextFieldsCustom extends StatelessWidget {
  TextFieldsCustom(this.labelText, this.hintText, this.isPassword, this.controller);

  final String labelText;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        obscuringCharacter: "*",
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          helperStyle: TextStyle(color: Colors.white),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white.withAlpha(30)),
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.white)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.white)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.white)
          ),
        ),
        style: TextStyle(color: Colors.white),

      ),
    );
  }


}
