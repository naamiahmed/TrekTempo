import 'package:travel_app/Pages/HomePage_Featurs/Event/Components/Support.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Container(
  
  margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center ,
     children: [
  GestureDetector(
      
      onTap: () {
                    Navigator.pop(context);

      },
      child:  Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black,)),
     Image.asset("images/CSF-Cover.png", width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/3, 
      fit: BoxFit.fill,
      ),
     
      Text("COLOMBO SHOPPING FESTIVAL – CSF", style: AppWidget.boldTextFieldStyle(),),
      Text("Ultimate Shoppers Paradise", style: AppWidget.semiBooldTextFieldStyle(),
      ),
       
       SizedBox(height: 20.0,),
      Text("The “Colombo Shopping Festival” the ultimate shopper paradise, has been held for 36 successive times and we are now gearing up for the 37th edition of the “Colombo Shopping Festival” to be held between the 5th – 11th April 2024 at the BMICH.", style: AppWidget.LightTextFeildStyle(),
      
      ),
           SizedBox(height: 20.0,),
          

                   Text("Aitken Spence Conventions & Exhibitions the event management arm of Aitken Spence Travels, the leading Inbound Tour Operator of Sri Lanka, has been the event management company organizing this premier event for 36 successive sessions. The team, has lived up to the unit’s motto of ‘getting bigger and better by annually attracting more and more visitors to the CSF and benefiting the Sponsors, Exhibitors, trade stall holders as well as the loyal shoppers who turn up at this annual event year after year. ", style: AppWidget.LightTextFeildStyle(),),
           


],
),
),


    );
  }
}