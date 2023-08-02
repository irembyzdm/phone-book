import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteContacts;

  FavoritePage({required this.favoriteContacts, Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  void didUpdateWidget(FavoritePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // widget.favoriteContacts içeriği değiştiğinde sayfayı güncellemek için setState kullanıyoruz
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favori Kişiler",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: widget.favoriteContacts.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> contact = widget.favoriteContacts[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(contact["imageURL"]),
            ),
            title: Text(contact["username"]),
            subtitle: Text(contact["phonenumber"]),
          );
        },
      ),
    );
  }
}
