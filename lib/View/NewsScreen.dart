import 'package:Motivation/components/button.dart';
import 'package:Motivation/components/colorSelect.dart';
import 'package:Motivation/components/motivationComponent.dart';
import 'package:Motivation/model/data/PublicationModel.dart';
import 'package:Motivation/styles/colorApp.dart';
import 'package:Motivation/utils/Services/requestServices.dart';
import 'package:Motivation/utils/functions/showToast.dart';
import 'package:Motivation/viewmodels/publications_list_view_model.dart';
import 'package:Motivation/viewmodels/users_list_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class NewsScreenScreen extends StatefulWidget {
  NewsScreenScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenScreenState createState() => _NewsScreenScreenState();
}

class _NewsScreenScreenState extends State<NewsScreenScreen> {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("TEXT"), value: "/api/type_publications/1"),
      DropdownMenuItem(child: Text("IMAGE"), value: "/api/type_publications/2"),
      DropdownMenuItem(child: Text("VIDEO"), value: "/api/type_publications/3"),
    ];
    return menuItems;
  }

  List _listColor = [
    0xFF16E986,
    0xff011d10,
    0xFFC419EE,
    0xFF8519B8,
    0xFF433F3C,
    0xFFC2A91C,
    0xFF871DCE,
    0xFF2A0A74,
    0xFFE4E6EE,
    0xFF069B56,
    0xFF373D3A,
    0xFFCEA972,
    0xFF03112B,
  ];
  bool validator = false;

  TextEditingController newPub = TextEditingController();

  String selectedValue = "/api/type_publications/1";

  addMotivation(context) {
    return showModalBottomSheet(
        barrierColor: Colors.grey,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) => SafeArea(
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter mystate) =>
                      Container(
                        height: MediaQuery.of(context).size.height / 1.04,
                        child: SafeArea(
                            child: Column(children: [
                          Container(
                              padding: EdgeInsets.only(left: 15, right: 10),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Nouv. Motivation ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextButton(
                                        child: Text(
                                          "Annuler",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: ColorsApp.skyBlue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        }),
                                  ])),
                          Expanded(
                            child: Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Categorie"),
                                      DropdownButton(
                                          value: selectedValue,
                                          onChanged: (String? newValue) {
                                            mystate(() {
                                              selectedValue = newValue!;
                                            });
                                          },
                                          items: dropdownItems)
                                    ],
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        (selectedValue ==
                                                "/api/type_publications/1")
                                            ? Column(children: [
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          "Select The font Color of your motivation"),
                                                      InkWell(
                                                          child: Text("Select"),
                                                          onTap: () {
                                                            print(
                                                                "Ici on doit afficher un carre qui continet des couleur");
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext context) => StatefulBuilder(
                                                                    builder: (BuildContext context, StateSetter setState) => Dialog(
                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), //this right here
                                                                        child: Container(
                                                                            // height: 180,
                                                                            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                                                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                children: [
                                                                                  InkWell(
                                                                                      child: Icon(Icons.close),
                                                                                      onTap: () {
                                                                                        Navigator.pop(context);
                                                                                      })
                                                                                ],
                                                                              ),
                                                                              Container(
                                                                                child: Text(
                                                                                  'Choisissez une Couleur',
                                                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                                                ),
                                                                                margin: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 8),
                                                                              ),
                                                                              Container(
                                                                                  width: double.infinity,
                                                                                  height: MediaQuery.of(context).size.height * .60,
                                                                                  child: GridView.builder(
                                                                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
                                                                                      itemBuilder: (_, index) {
                                                                                        return ColorSelect(
                                                                                          currentColor: 0xff10ff10,
                                                                                        );
                                                                                      }))
                                                                            ])))));
                                                          })
                                                    ]),
                                                TextFormField(
                                                  // enabled: enableMail,
                                                  // textCapitalization: TextCapitalization.words,
                                                  maxLength: 1000,
                                                  onChanged: (value) {},
                                                  controller: newPub,
                                                  validator: (value) {
                                                    if (value == "") {
                                                      return "veillez remplir se champs";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                          color: Colors.grey,
                                                          // width: 10
                                                        )),
                                                    fillColor: Colors.grey,
                                                    hintText: "Message",
                                                    hintStyle: TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                )
                                              ])
                                            : (selectedValue ==
                                                    "/api/type_publications/2")
                                                ? Text("Not implement Image")
                                                : Text("Not implement Video"),
                                        Container(
                                            padding: EdgeInsets.only(top: 7),
                                            child: Button(
                                                height: 45,
                                                width: 120,
                                                title: "Add",
                                                textColor: Colors.white,
                                                itemColor: ColorsApp.skyBlue,
                                                loaderColor: Colors.white,
                                                enabled: newPub.text.isNotEmpty
                                                    ? true
                                                    : false,
                                                state: validator,
                                                onTap: () async {
                                                  var data = {
                                                    "content": newPub.text,
                                                    "user": "/api/users/1",
                                                    "typePublication":
                                                        selectedValue
                                                  };
                                                  mystate(() {
                                                    validator = true;
                                                  });
                                                  try {
                                                    // newPub.clear();
                                                    var postResponse =
                                                        await ApiService().postData(
                                                            "/api/publications",
                                                            data);
                                                    print(
                                                        "voila dat -------------------------$postResponse ");
                                                    Navigator.pop(context);
                                                    toastShow(
                                                        "Publication Reusssit",
                                                        Colors.blueGrey,
                                                        context);
                                                    mystate(() {
                                                      validator = false;
                                                    });
                                                  } catch (e) {
                                                    toastShow(
                                                        "Erreur de publication",
                                                        Colors.blueGrey,
                                                        context);
                                                    mystate(() {
                                                      validator = false;
                                                    });
                                                  }
                                                }))
                                      ],
                                    ),
                                  )
                                ])),
                          )
                        ])),
                      )),
            ));
  }

  @override
  void initState() {
    Provider.of<PublicationListViewModel>(context, listen: false).getAllPub();
    Provider.of<UserListViewModel>(context, listen: false).getAllUser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _listPublication = Provider.of<PublicationListViewModel>(context);

    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Container(
        padding: EdgeInsets.only(top: 18, bottom: 18),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            padding: EdgeInsets.only(left: 18),
            child: Text(
              "Home",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(right: 20),
                child: InkWell(
                    child: Icon(Icons.add),
                    onTap: () {
                      addMotivation(context);
                    }),
              ),
              Container(
                padding: EdgeInsets.only(right: 20),
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.010),
                child: CachedNetworkImage(
                  imageUrl: "" /*   ApiUrl.baseUrl + this.user.img */,
                  imageBuilder: (context, imageProvider) {
                    return CircleAvatar(
                        radius: 20, backgroundImage: imageProvider);
                  },
                  placeholder: (context, url) {
                    return CircleAvatar(
                        /*  backgroundColor: ColorsApp.skyBlue, */
                        radius: 15,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: ColorsApp.skyBlue,
                          ),
                        ));
                  },
                  errorWidget: (context, url, error) {
                    return CircleAvatar(
                        /*  backgroundColor: ColorsApp.skyBlue, */
                        radius: 15,
                        backgroundImage: AssetImage("Img/happy.png"));
                  },
                ),
              ),
            ],
          )
        ]),
      ),
      Expanded(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .2,
                    width: MediaQuery.of(context).size.width * .45,
                    margin: EdgeInsets.only(left: 10),
                    padding: EdgeInsets.all(
                      30,
                    ),
                    alignment: Alignment.center,
                    child: Column(children: [
                      Container(child: Icon(Icons.add)),
                      Text(
                        "Creer une motivation",
                        textAlign: TextAlign.center,
                      )
                    ]),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onTap: () {
                    addMotivation(context);
                  },
                ),
                InkWell(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .2,
                    width: MediaQuery.of(context).size.width * .45,
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.all(
                      30,
                    ),
                    alignment: Alignment.center,
                    child: Column(children: [
                      Container(child: Icon(Icons.favorite)),
                      Text(
                        "Motivations Populaires",
                        textAlign: TextAlign.center,
                      )
                    ]),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onTap: () {
                    /*     Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PublicationsByCategory())); */
                  },
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 8),
              child: _listPublication.loadingStatus == LoadingStatus.comppleted
                  ? Column(
                      children: [
                        StreamBuilder(
                            initialData: _listPublication.listPub,
                            stream: Stream.periodic(Duration(seconds: 5))
                                .asBroadcastStream()
                                .asyncMap((i) => _listPublication.listPub),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (BuildContext context, index) {
                                    print(
                                        "*******************************${snapshot.data[index].content}");
                                    return GestureDetector(
                                        onLongPress: () {},
                                        onTap: () async {},
                                        child: MotivationComponent(
                                          motivation: snapshot.data[index],
                                        ));
                                  });
                            })
                      ],
                    )
                  : _listPublication.loadingStatus == LoadingStatus.searching
                      ? Center(
                          child: SpinKitCircle(
                          color: Colors.blue,
                          size: 40,
                        ))
                      : Container(
                          padding: EdgeInsets.only(
                              top: 7, left: 10, right: 10, bottom: 7),
                          child: Text("rien a afficher")),
            )
          ],
        )),
      ),
    ])));
  }
}
