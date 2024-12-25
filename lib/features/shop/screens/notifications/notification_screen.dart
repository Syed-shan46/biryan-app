// ignore: depend_on_referenced_packages
// ignore_for_file: await_only_futures, avoid_single_cascade_in_expression_statements, avoid_print

import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  final RemoteMessage? message;
  const NotificationScreen({super.key, this.message});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  User? frUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      // body: widget.message != null
      //     ? Card(
      //         elevation: 5,
      //         child: ListTile(
      //           leading: const Icon(Icons.notifications_active),
      //           title:
      //               Text(widget.message!.notification!.title.toString() ?? ''),
      //           subtitle: Text(widget.message!.notification!.body.toString()),
      //           trailing: Text(widget.message!.data['screen'].toString()),
      //         ),
      //       )
      //     : const Center(
      //         child: Text("no Notifications"),
      //       ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .doc(frUser!.uid)
            .collection('notifications')
            // .where('isSale', isEqualTo: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No notifications found!"),
            );
          }

          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                String docId = snapshot.data!.docs[index].id;
                return GestureDetector(
                  onTap: () async {
                    print("Docid => $docId");
                    await FirebaseFirestore.instance
                        .collection('notifications')
                        .doc(frUser!.uid)
                        .collection('notifications')
                        .doc(docId);
                  },
                  child: Card(
                    elevation: 3,
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: AppColors.accentColor,
                        child: Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        snapshot.data!.docs[index]['title'],
                        style: TextStyle(
                            color: ThemeUtils.dynamicTextColor(context)),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
