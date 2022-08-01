import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physio_app2/model/user_model.dart';
import 'package:physio_app2/screens/login_screen.dart';
import 'package:physio_app2/screens/video_info.dart';
import 'package:physio_app2/screens/colors.dart' as color;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //User? user = FirebaseAuth.instance.currentUser;
  //UserModel loggedInUser = UserModel();

  List info = [];

  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/info.json")
        .then((value) {
      setState(() {
        info = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    // ToDo: implement initState
    super.initState();
    _initData();

    //FirebaseFirestore.instance
    //  .collection("users")
    //.doc(user!.uid)
    // .get()
    // .then((value) {
    // this.loggedInUser = UserModel.fromMap(value.data());
    // setState(() {});
    //};
    //);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: _appBar(),
      backgroundColor: color.AppColor.homePageBackground,
      body: Container(
        padding: const EdgeInsets.only(
          top: 50,
          left: 30,
          right: 30,
        ),
        child: Column(children: [
          Row(
            children: [
              Text(
                "Training",
                style: TextStyle(
                    fontSize: 30,
                    color: color.AppColor.homePageTitle,
                    fontWeight: FontWeight.w700),
              ),
              Expanded(child: Container()),
              Icon(Icons.arrow_back_ios,
                  size: 20, color: color.AppColor.homePageIcons),
              const SizedBox(
                width: 10,
              ),
              Icon(
                Icons.calendar_today_outlined,
                size: 20,
                color: color.AppColor.homePageIcons,
              ),
              const SizedBox(
                width: 15,
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: color.AppColor.homePageIcons,
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Your program",
                style: TextStyle(
                    fontSize: 20,
                    color: color.AppColor.homePageSubtitle,
                    fontWeight: FontWeight.w700),
              ),
              Expanded(child: Container()),
              Text(
                "Details",
                style: TextStyle(
                  fontSize: 20,
                  color: color.AppColor.homePageDetail,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const VideoInfo());
                },
                child: Icon(
                  Icons.arrow_forward,
                  size: 20,
                  color: color.AppColor.homePageIcons,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.AppColor.gradientFirst.withOpacity(0.8),
                    color.AppColor.gradientSecond.withOpacity(0.9),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(80),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(5, 10),
                    blurRadius: 20,
                    color: color.AppColor.gradientSecond.withOpacity(0.2),
                  )
                ]),
            child: Container(
              padding: const EdgeInsets.only(
                left: 20,
                top: 25,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Next workout',
                    style: TextStyle(
                        fontSize: 16,
                        color: color.AppColor.homePageContainerTextSmall),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Legs Toning',
                    style: TextStyle(
                        fontSize: 25,
                        color: color.AppColor.homePageContainerTextSmall),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'and Glutes Workout ',
                    style: TextStyle(
                        fontSize: 25,
                        color: color.AppColor.homePageContainerTextSmall),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            size: 20,
                            color: color.AppColor.homePageContainerTextSmall,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '60 min',
                            style: TextStyle(
                                fontSize: 10,
                                color:
                                    color.AppColor.homePageContainerTextSmall),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            boxShadow: [
                              BoxShadow(
                                  color: color.AppColor.gradientFirst,
                                  blurRadius: 10,
                                  offset: const Offset(4, 8))
                            ]),
                        child: const Icon(
                          Icons.play_circle_fill,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                "Area of focus",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: color.AppColor.homePageTitle,
                ),
              ),
            ],
          ),
          Expanded(
              child: OverflowBox(
            maxWidth: MediaQuery.of(context).size.width,
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView.builder(
                  itemCount: (info.length.toDouble() / 2).toInt(),
                  itemBuilder: (_, i) {
                    int a = 2 * i; //0,2
                    int b = 2 * i + 1; //1,3

                    return Row(
                      children: [
                        Container(
                          width: (MediaQuery.of(context).size.width - 90) / 2,
                          height: 170,
                          margin: const EdgeInsets.only(
                            left: 30,
                            bottom: 15,
                            top: 15,
                          ),
                          padding: const EdgeInsets.only(
                            bottom: 5,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: AssetImage(info[a]['img'])),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: const Offset(5, 5),
                                  color: color.AppColor.gradientSecond
                                      .withOpacity(0.1),
                                ),
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: const Offset(-5, -5),
                                  color: color.AppColor.gradientSecond
                                      .withOpacity(0.1),
                                )
                              ]),
                          child: Center(
                              child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              info[a]["title"],
                              style: TextStyle(
                                  fontSize: 20,
                                  color: color.AppColor.homePageDetail),
                            ),
                          )),
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width - 90) / 2,
                          height: 170,
                          margin: const EdgeInsets.only(
                            left: 30,
                            bottom: 15,
                            top: 15,
                          ),
                          padding: const EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: AssetImage(info[b]['img'])),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: const Offset(5, 5),
                                  color: color.AppColor.gradientSecond
                                      .withOpacity(0.1),
                                ),
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: const Offset(-5, -5),
                                  color: color.AppColor.gradientSecond
                                      .withOpacity(0.1),
                                )
                              ]),
                          child: Center(
                              child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              info[b]["title"],
                              style: TextStyle(
                                  fontSize: 20,
                                  color: color.AppColor.homePageDetail),
                            ),
                          )),
                        ),
                      ],
                    );
                  }),
            ),
          )),
        ]),
      ),
    );
  }

  //Future<void> logout(BuildContext context) async {
  //  await FirebaseAuth.instance.signOut();
  //  Navigator.of(context).pushReplacement(
  //    MaterialPageRoute(builder: (context) => LoginScreen()));
  //}

  // _appBar() {
  // getting the size of our app bar
  // we will get the height
  //final appBarHeight = AppBar().preferredSize.height;
  //return PreferredSize(
  // preferredSize: Size.fromHeight(appBarHeight),
  // child: AppBar(
  //  title: const Text("Profile"),
  // actions: [
  //  IconButton(
  //  onPressed: () {
  //  logout(context);
  // },
  // icon: const Icon(Icons.logout),
  // )
  // ],
  // ),
  // );
  // }
}
