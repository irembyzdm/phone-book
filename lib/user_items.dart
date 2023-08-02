import 'package:flutter/material.dart';
//import 'user_details_page.dart';

class UsersItems extends StatelessWidget {
  UsersItems({
    required this.id,
    required this.username,
    required this.imageURL,
    required this.phonenumber,
    required this.userdelete,
    //required void Function(String phoneNumber) makePhoneCall,
    required this.addToFavorites,
    required this.isFavorite,
  });

  final String id;
  final String username;
  final String imageURL;
  final String phonenumber;
  final Function(String) userdelete;
  final Function(Map<String, dynamic>) addToFavorites;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15.0),
      elevation: 4.0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imageURL) as ImageProvider,
          radius: 30,
        ),
        title: Text(
          username,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          phonenumber,
          style: TextStyle(fontSize: 15),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.call,
                color: Colors.green,
              ),
              onPressed: () {
                //makePhoneCall(phonenumber);
              },
            ),
            IconButton(
              onPressed: () {
                addToFavorites({
                  "id": id,
                  "username": username,
                  "imageURL": imageURL,
                  "phonenumber": phonenumber,
                  "isFavorite": !isFavorite,
                });
                print("Favori eklendi: $username");
              },
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Color.fromARGB(255, 187, 128, 148),
              ),
              onPressed: () {
                userdelete(id);
              },
            ),
          ],
        ),
      ),
    );
  }

//void makePhoneCall(String phoneNumber) async {
  //if (await canLaunch("tel:$phoneNumber")) {
  //await launch("tel:$phoneNumber");
  //} else {
  //print("Telefon araması başlatılamadı.");
  //}
}
//}