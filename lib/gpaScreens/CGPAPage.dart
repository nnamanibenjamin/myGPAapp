import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './ResultPage.dart';

class cgpaCalc extends StatefulWidget {
  final int n;
  cgpaCalc(this.n);

  @override
  GPAcalcstate createState() =>  GPAcalcstate();
}

class GPAcalcstate extends State<cgpaCalc> {
  List _sgpaController;
  List _creditController;
  List list;

  @override
  void initState() {
    super.initState();

    _sgpaController = List<String>()..length = widget.n;

    _creditController = List<String>()..length = widget.n;

    list = List<int>.generate(widget.n, (i) => i);

  }

  @override
  Widget build(BuildContext context) {

    double sumOfCreditMulSGPA = 0, sumOfCredit = 0;
    double cgpa = 0.0;
    var fields = <Widget>[];
    bool insertedValue = true;

    list.forEach((i) {
      fields.add(
         Row(
            children: [
              //subject er text
               Text(
                "Course ${i+1}:",
                style:  TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
               Padding(
                padding:  EdgeInsets.all(10.0),
              ),

              //sgpa er textField
              SizedBox(
                width: 80.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Grade"),
                  onChanged: (value) {
                    setState(() {
                      _sgpaController[i] = value;
                    });
                  },
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(35.0),
              ),

              //credit er textField
              SizedBox(
                width: 80.0,
                child: TextField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(hintText: "Credit Load"),
                  onChanged: (s) {
                    setState(() {
                      _creditController[i] = s;
                    });
                  },
                ),
              ),
            ]),
      );
    });



    return Scaffold(
      appBar: AppBar(
        title: Text("GPA calculator"),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
        Row(
        children: [
         Padding(
        padding: EdgeInsets.only(left: 120.0,top: 20.0),
      ),
         Text(
          "Grade",
          overflow: TextOverflow.ellipsis,
          style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 17.0),
        ),
         Padding(
          padding: EdgeInsets.only(left: 80.0),
        ),
         Text(
          "Credits",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.0),
        ),
         Padding(
          padding: EdgeInsets.only(bottom:5.0),
        ),
        ]
    ),
            Container(
              decoration: BoxDecoration(
                  border:  Border.all(color: Colors.transparent, width: 30.0)),
              child: Column(
                children: fields,
              ),
            ),

            RaisedButton(
              padding: EdgeInsets.all(10.0),
              color: Colors.green,
              child: Text("Calculate CGPA",
              style: TextStyle(fontSize: 30.0,color: Colors.white),),
              onPressed: () {

                for (int i = 0; i < widget.n; i++) {
                  if(_creditController[i]==null){

                    insertedValue = false;
                    continue;
                  }

                  if(_sgpaController[i]==null){
                    insertedValue = false;
                    continue;
                  }

                  int sgpa = int.parse(_sgpaController[i]);
                  double credit = double.parse(_creditController[i]);


                  double creditMulSGPA = credit * sgpa;
                  sumOfCreditMulSGPA += creditMulSGPA; //sumOfCreditMulSGPA = sumOfCreditMulSGPA+creditMulSGPA
                  sumOfCredit += credit; //sumOfCredit = sumOfCredit+credit
                }
                cgpa = sumOfCreditMulSGPA / sumOfCredit;

                if(insertedValue==true)
                  Navigator.of(context).push(
                     MaterialPageRoute(
                      builder: (BuildContext context) =>  ResultPage(cgpa),
                    ),
                  );
                else{
                  showAlertBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  showAlertBox() {
    return showDialog<Null>(
      context: context,
     barrierDismissible: false,
      builder: (BuildContext context) {
        return  AlertDialog(
          title:  Text('Please enter some value to calculate'),
          actions: <Widget>[
             FlatButton(
              child: Icon(Icons.clear),
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
