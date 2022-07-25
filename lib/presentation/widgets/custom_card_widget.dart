import 'package:flutter/material.dart';
import 'package:login_api_bloc/presentation/screens/user_detail_screen/Detail_user_ui.dart';

class CustomCardWidget extends StatelessWidget {
  final String name;
  final String email;
  final String imgUrl;
  final String location;
  final String serialNo;
  final String date;
  final String iD;


const CustomCardWidget(this.name, this.email, this.imgUrl, this.location,
      this.serialNo, this.date, this.iD,
  {Key? key})
  :super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  DetailUserScreen(id:iD)));
      },
      child: Card(
    color: Colors.blue.withOpacity(0.1),
        child: Column(
          children: [
            Row(
              children: [
                Image.network(imgUrl,height: 100,),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Serial No : $date",style: const TextStyle(fontWeight: FontWeight.bold),),
                      Text("Name : $name"),
                      Text(("Location : $location")),
                      Text(("Email : $email")),
                      Text("iD: $iD",style: const TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                )
              ],
            )

          ],
        ),
      ),
    );
  }
}
