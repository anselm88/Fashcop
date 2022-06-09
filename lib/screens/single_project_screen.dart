import 'package:fashcop/variables/constants.dart';
import 'package:fashcop/widgets/project_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SingleProjectScreen extends StatefulWidget {
  static const String id = 'single_project_screen';
  const SingleProjectScreen({Key? key}) : super(key: key);

  @override
  State<SingleProjectScreen> createState() => _SingleProjectScreenState();
}

class _SingleProjectScreenState extends State<SingleProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
          shape: const RoundedRectangleBorder(
              // borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(30),
              //     bottomRight: Radius.circular(30)),
              ),
          brightness: Brightness.light,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              //borderRadius: const BorderRadius.only(
              //bottomLeft: Radius.circular(30),
              //bottomRight: Radius.circular(30)),
              gradient: LinearGradient(
                colors: [
                  Colors.white30,
                  Colors.white,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: const Text(
            "FaSHcoP",
            style: kHeadingStyle,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(color: Colors.grey[200]),
          child: Column(
            children: [
              Container(
                  child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 20.0,
                          backgroundImage: AssetImage('assets/profile1.png'),
                        ),
                        title: Text(
                          'John Doe',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text('Northwest, Bamenda'),
                        trailing: Icon(Icons.more_horiz),
                        contentPadding: EdgeInsets.all(0),
                        onTap: () {},
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/corn.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            SizedBox(height: 10),
                            Text(
                              'Project Name: Corn Project',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Location: Corn Project',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Budget Rnage: Corn Project',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Estimated Profits: Corn Project',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Sector: Corn Project',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Time Frame: Corn Project',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Project Description: Corn Project',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ]),
                      const Divider(
                        color: Colors.black54,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite_border,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                '0 Likes',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.comment_outlined,
                                    color: Colors.black54),
                              ),
                              Text(
                                '0 Comments',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black54),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: const Text('1 hour ago',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                            )),
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
