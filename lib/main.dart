import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class MyButton extends StatelessWidget{
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;
  MyButton({this.color,this.textColor, this.buttonText, this.buttonTapped });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(),
          child:Container(
            color: color,
            child: Center(child: Text(buttonText, style: TextStyle(color: textColor, fontSize: 30),),),
          ),
        ),
      ),
    );
  }

}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  var userQuestion = '';
  var userAnswer = ' ';

final List<String> buttons =
  [
    'C' , 'AC', '%' , '/',
    '9' , '8', '7' , 'x',
    '6' , '5', '4' , '-',
    '3' , '2', '1' , '+',
    '0' , '.', '-' , '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children:<Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 50,),
                  Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Text(userQuestion, style: TextStyle(fontSize: 20,color: Colors.white) , ),
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(userAnswer, style: TextStyle(fontSize: 20,color: Colors.white),),)
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
              child: Container(
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                    itemBuilder: (BuildContext context , int index){
                      if (index == 0 ) {
                       return MyButton(
                         buttonTapped: (){
                           setState(() {
                             userQuestion = '';
                           });
                         },
                      buttonText: buttons[index],
                      color: Colors.amber,
                      textColor: Colors.white,
                      );
                      }else if (index  ==  1 ){
                      return MyButton(
                        buttonTapped: (){
                          setState(() {
                            userQuestion = userQuestion.substring(0,userQuestion.length-1);
                          });
                        },
                      buttonText: buttons[index],
                      color: Colors.amber,
                      textColor: Colors.white,
                      );
                      }else if (index  == buttons.length-1 ){
                        return MyButton(
                          buttonTapped: (){
                            setState(() {
                              equalPressed();
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.amber,
                          textColor: Colors.white,
                        );
                      } else {
                        return MyButton(
                          buttonTapped: (){
                            setState(() {
                              userQuestion += buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: isOperator(buttons[index]) ? Colors.amber : Colors.grey[850],
                          textColor: isOperator(buttons[index]) ? Colors.white : Colors.white,
                        );
                      }
                      }),
              ),
          )
        ]
      ),
    );
  }


  bool isOperator(String x){
    if(x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '='  ) {
      return true;
    }
      return false;
    }

   void equalPressed(){
      String finalQuestion = userQuestion;
      finalQuestion = finalQuestion.replaceAll('x', '*');
      Parser  p = Parser();
      Expression exp = p.parse(finalQuestion);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      userAnswer = eval.toString();

   }
  }