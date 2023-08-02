import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_page.dart';
import 'user_details_page.dart';
import 'user_items.dart';
import 'package:flutter/services.dart';
import 'favorite_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> _tabs = [];
  List<Map<String, dynamic>> favoriteContacts = [];

  @override
  void initState() {
    super.initState();
    // `profileData` değişkenini burada dolduruyoruz
    Map<String, dynamic> profileData = {
      "id": "user1",
      "username": "Büşra Yılmaz",
      "imageURL": "assets/images/anonim.jpg",
      "phonenumber": "0533 569 00 41",
      "email": "busra@example.com",
      "birthDate": "1998-12-20",
    };

    // _tabs listesini burada tanımlıyoruz ve içeriğini dolduruyoruz
    _tabs = [
      HomePageContent(
        favoriteContacts: favoriteContacts,
        addToFavorites: addToFavorites,
      ),
      ProfilePage(profileData: profileData),
      FavoritePage(favoriteContacts: favoriteContacts),
    ];
  }

  void addToFavorites(Map<String, dynamic> user) {
    setState(() {
      favoriteContacts.add(user);
    });
  }

  void onTabTapped(int index) {
    setState(() {
      // _tabs listesinde geçerli bir sayfa indeksi mi kontrol ediyoruz
      if (index >= 0 && index < _tabs.length) {
        _currentIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color.fromARGB(255, 242, 152, 212),
            ),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Color.fromARGB(255, 242, 152, 212),
            ),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Color.fromARGB(255, 242, 152, 212),
            ),
            label: 'Favoriler',
          ),
        ],
      ),
      body: _tabs[_currentIndex], // Seçilen sayfayı göstermek için
    );
  }
}

class HomePageContent extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteContacts;
  final Function(Map<String, dynamic>) addToFavorites;

  HomePageContent({
    required this.favoriteContacts,
    required this.addToFavorites,
  });

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final List<Map<String, dynamic>> userslist = [
    {
      "id": "user1",
      "username": "Ahmet Şahin",
      "imageURL": "assets/images/e1.jpg",
      "phonenumber": "0533 123 89 95",
      "email": "ahmet@example.com",
      "birthDate": "1995-01-01",
    },
    {
      "id": "user2",
      "username": "Buse Yılmaz",
      "imageURL": "assets/images/k3.jpg",
      "phonenumber": "0541 787 66 00",
      "email": "buse@example.com",
      "birthDate": "1990-05-20",
    },
    {
      "id": "user3",
      "username": "Canan Demir",
      "imageURL": "assets/images/k2.png",
      "phonenumber": "0531 544 12 04",
      "email": "canan@example.com",
      "birthDate": "1989-11-09",
    },
    {
      "id": "user4",
      "username": "Hakan Küçük",
      "imageURL": "assets/images/e2.jpg",
      "phonenumber": "0545 988 65 56",
      "email": "hakan@example.com",
      "birthDate": "1994-05-12",
    },
    {
      "id": "user5",
      "username": "Kerem Akın",
      "imageURL": "assets/images/e3.jpg",
      "phonenumber": "0541 409 77 09",
      "email": "kerem@example.com",
      "birthDate": "1975-05-24",
    },
    {
      "id": "user6",
      "username": "Yağmur Kaya",
      "imageURL": "assets/images/k4.jpg",
      "phonenumber": "0506 088 52 00",
      "email": "yagmur@example.com",
      "birthDate": "1989-01-24",
    },
    {
      "id": "user7",
      "username": "Ebru Yıldırım",
      "imageURL": "assets/images/k5.jpeg",
      "phonenumber": "0535 477 32 19",
      "email": "ebru@example.com",
      "birthDate": "1984-09-11",
    },
    {
      "id": "user8",
      "username": "Arda Çelik",
      "imageURL": "assets/images/e4.jpg",
      "phonenumber": "0507 233 77 43",
      "email": "arda@example.com",
      "birthDate": "1998-12-02",
    },
    {
      "id": "user9",
      "username": "Zeynep Aslan",
      "imageURL": "assets/images/k6.jpg",
      "phonenumber": "0539 977 09 12",
      "email": "zeynep@example.com",
      "birthDate": "1988-08-12",
    },
  ];

  List<Map<String, dynamic>> filteredUsers = [];
  String? selectedImagePath;

  List<Map<String, dynamic>> favoriteContacts = [];

  void addToFavorites(Map<String, dynamic> user) {
    setState(() {
      if (favoriteContacts.contains(user)) {
        favoriteContacts.remove(user);
        user["isFavorite"] =
            false; // Set isFavorite to false when removing from favorites
      } else {
        favoriteContacts.add(user);
        user["isFavorite"] =
            true; // Set isFavorite to true when adding to favorites
      }
    });
  }

  void addUser(Map<String, dynamic> user) {
    setState(() {
      String uniqueID = "user${DateTime.now().millisecondsSinceEpoch}";
      user["id"] = uniqueID;
      user["imageURL"] = selectedImagePath ?? "assets/images/anonim.jpg";

      // Telefon numarasını istenilen formata dönüştürüyoruz.
      String formattedPhoneNumber = phoneNumberFormatter(user["phonenumber"]);
      user["phonenumber"] = formattedPhoneNumber;

      userslist.add(user);
    });
  }

  void deleteUser(String userID) {
    setState(() {
      userslist.removeWhere((user) => user["id"] == userID);
      filteredUsers.removeWhere((user) => user["id"] == userID);
    });
  }

  void searchUsers(String query) {
    setState(() {
      filteredUsers = userslist.where((user) {
        return user["username"].toLowerCase().contains(query.toLowerCase()) ||
            user["phonenumber"].contains(query) ||
            user["email"].toLowerCase().contains(query.toLowerCase()) ||
            user["birthDate"].contains(query);
      }).toList();
    });
  }

  void sortUsersByName(bool ascending) {
    setState(() {
      if (ascending) {
        userslist.sort((a, b) => a["username"].compareTo(b["username"]));
      } else {
        userslist.sort((a, b) => b["username"].compareTo(a["username"]));
      }
      filteredUsers = List.from(userslist);
    });
  }

  //void makePhoneCall(String phoneNumber) async {
  //if (await canLaunch("tel:$phoneNumber")) {
  //await launch("tel:$phoneNumber");
  //} else {
  //print("Telefon araması başlatılamadı.");
  //}
  //}

  Future<String?> pickImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      return pickedImage.path;
    } else {
      return null;
    }
  }

  final phoneNumberFomatter = FilteringTextInputFormatter.digitsOnly;

  DateTime? selectedBirthDate;

  Map<String, dynamic> profileData = {
    "id": "user1",
    "username": "Büşra Yılmaz",
    "imageURL": "assets/images/profil.jpg",
    "phonenumber": "0533 569 00 41",
    "email": "busra@example.com",
    "birthDate": "1998-12-20",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.contacts,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      "Telefon Rehberim",
                      style: TextStyle(
                        background: Paint()
                          ..color = Color.fromARGB(255, 241, 231, 231)
                          ..strokeJoin = StrokeJoin.round
                          ..strokeCap = StrokeCap.round
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 30.0,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String newUsername = "";
                          String newPhoneNumber = "";
                          String newEmail = "";
                          String newBirthDate = "";

                          return AlertDialog(
                            title: Text("Kişi Ekle "),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  onChanged: (value) {
                                    newUsername = value;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "İsim-Soyisim",
                                  ),
                                ),
                                TextField(
                                  onChanged: (value) {
                                    newPhoneNumber = value;
                                  },
                                  inputFormatters: [phoneNumberFomatter],
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    labelText: "Telefon Numarası",
                                  ),
                                ),
                                TextField(
                                  onChanged: (value) {
                                    newEmail = value;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "E-posta Adresi",
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    selectedBirthDate =
                                        await _selectBirthDate(context);
                                    if (selectedBirthDate != null) {
                                      newBirthDate =
                                          "${selectedBirthDate?.year}-${selectedBirthDate?.month.toString().padLeft(2, '0')}-${selectedBirthDate?.day.toString().padLeft(2, '0')}";
                                      setState(() {});
                                    }
                                  },
                                  child: AbsorbPointer(
                                    child: TextField(
                                      controller: TextEditingController(
                                          text: newBirthDate),
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        labelText: "Doğum Tarihi (YYYY-AA-GG)",
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                IconButton(
                                  onPressed: () async {
                                    selectedImagePath =
                                        await pickImageFromGallery();
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.photo,
                                    size: 33,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  if (newUsername.isNotEmpty &&
                                      newPhoneNumber.isNotEmpty &&
                                      newEmail.isNotEmpty &&
                                      isValidEmail(newEmail) &&
                                      newBirthDate.isNotEmpty &&
                                      isValidBirthDate(newBirthDate)) {
                                    Map<String, dynamic> newUser = {
                                      "id": "",
                                      "username": newUsername,
                                      "imageURL": selectedImagePath ??
                                          "assets/images/anonim.jpg",
                                      "phonenumber": newPhoneNumber,
                                      "email": newEmail,
                                      "birthDate": newBirthDate,
                                    };
                                    addUser(newUser);
                                    Navigator.pop(context);
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            "UYARI",
                                            textAlign: TextAlign.center,
                                          ),
                                          content: Text(
                                              "Lütfen bütün boş alanları doldurun ve geçerli bir e-posta adresi ve doğum tarihi girin."),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Tamam"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Text(
                                  "Ekle",
                                  style: TextStyle(color: Colors.pink),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "İptal",
                                  style: TextStyle(color: Colors.pink),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 241, 231, 231),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  onChanged: (query) {
                    searchUsers(query);
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Kişi Bul",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    sortUsersByName(true);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 242, 131, 168)),
                  child: Text("A'dan Z'ye Sırala"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    sortUsersByName(false);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 242, 131, 168)),
                  child: Text("Z'den A'ya Sırala"),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredUsers.isNotEmpty
                    ? filteredUsers.length
                    : userslist.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> user = filteredUsers.isNotEmpty
                      ? filteredUsers[index]
                      : userslist[index];
                  //bool isFavorite = widget.favoriteContacts.contains(user);
                  return GestureDetector(
                    onTap: () async {
                      final updatedUser = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UserDetailsPage(userDetails: user),
                        ),
                      );
                      if (updatedUser != null) {
                        setState(() {
                          int userIndex = userslist
                              .indexWhere((u) => u["id"] == user["id"]);
                          if (userIndex != -1) {
                            userslist[userIndex] = updatedUser;
                          }
                        });
                      }
                    },
                    child: UsersItems(
                      id: user["id"],
                      username: user["username"],
                      imageURL: user["imageURL"],
                      phonenumber: user["phonenumber"],
                      userdelete: deleteUser,
                      //makePhoneCall: makePhoneCall,
                      addToFavorites: addToFavorites,
                      isFavorite: favoriteContacts
                          .contains(user), // Pass the isFavorite flag
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> _selectBirthDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    return pickedDate;
  }

  bool isValidEmail(String email) {
    String emailPattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  bool isValidBirthDate(String date) {
    String birthDatePattern = r"^\d{4}-\d{2}-\d{2}$";
    RegExp regExp = RegExp(birthDatePattern);
    return regExp.hasMatch(date);
  }

  String phoneNumberFormatter(String phoneNumber) {
    String formattedPhoneNumber =
        phoneNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
    if (formattedPhoneNumber.length == 11) {
      return '${formattedPhoneNumber.substring(0, 4)} ${formattedPhoneNumber.substring(4, 7)} ${formattedPhoneNumber.substring(7, 9)} ${formattedPhoneNumber.substring(9)}';
    } else {
      return phoneNumber;
    }
  }
}
