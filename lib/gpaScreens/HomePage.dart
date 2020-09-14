import 'package:cgpa_calculator/gpaScreens/CGPAPage.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget{
  @override
  HomePageState createState() => new HomePageState();
}
class HomePageState extends State<HomePage>{
  TextEditingController semController = new TextEditingController();
  int n;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:Text("CGPA calculator"), backgroundColor: Colors.lightBlueAccent),
      backgroundColor: Colors.orange[100],
      body:Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.transparent,width: 25.0),color: Colors.transparent),
        child: ListView(
          children: <Widget>[
             TextField(
              textAlign: TextAlign.center,
              autofocus: true,
              decoration:  InputDecoration(
                  fillColor: Colors.lightBlueAccent,
                  hintText: "Enter number of semester",
                  hintStyle: TextStyle(color: Colors.black54)
              ),
              keyboardType: TextInputType.number,
              controller: semController,
              onChanged: (String str){
                setState((){
                  if(semController.text=="")
                    {n=0;}
                  else{
                    n=int.parse(semController.text);
                  }
                });
              },
            ),
             IconButton(
              icon: Icon(Icons.touch_app,size: 35.0,color: Colors.deepPurpleAccent,),
              onPressed: (){
                if(n is int && n > 0 ){
                  int pass=n;
                  n=0;
                  semController.text="";
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder:(BuildContext context)=> cgpaCalc(pass)));
                }
                else{
                  semController.text="";
                  alert();
                }
              },
            )
          ],
        ),
      ),
    );
  }
  alert()  {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('Please enter number of semester to calculate CGPA'),

          actions: <Widget>[
             FlatButton(
              child:  Icon(Icons.clear,size: 40.0,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}