import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'providers/index_provider.dart';
import 'reuseable.dart';
import 'food_tracker.dart';

class DataSorted extends StatefulWidget {
  const DataSorted({Key? key}) : super(key: key);

  @override
  State<DataSorted> createState() => _DataSortedState();
}

class _DataSortedState extends State<DataSorted> {
  Icon returnIcon(int index) {
    //on tap feature to display sized box
    //maybe subtitle feature for allergy level 3(moderate)
    if (index == 0) {
      return Icon(CupertinoIcons.sun_max, size: 30);
    }
    if (index == 1) {
      return Icon(CupertinoIcons.cloud_sun, size: 30);
    }
    if (index == 2) {
      return Icon(CupertinoIcons.cloud_sun_rain, size: 30);
    }
    if (index == 3) {
      return Icon(CupertinoIcons.cloud_drizzle, size: 30);
    }
    if (index == 4) {
      return Icon(CupertinoIcons.cloud_bolt, size: 30);
    }
    if (index == 5) {
      return Icon(CupertinoIcons.cloud_bolt_rain, size: 30);
    }
    return Icon(CupertinoIcons.multiply_circle, size: 30);
  }
  String returnReactionLevel(index) {
    String answer = '';
    if (index == 0) {
      return answer = 'No Reaction';
    }
    if (index == 1) {
      return answer = 'Mild Reaction';
    }
    if (index == 2) {
      return answer = 'Moderate Reaction';
    }
    if (index == 3) {
      return answer = 'Severe Reaction';
    }
    if (index == 4) {
      return answer = 'Very Severe Reaction';
    }
    if (index == 5) {
      return answer = 'Worst Possible Reaction';
    }
      return answer = 'Error Occurred';
  }
    @override
    Widget build(BuildContext context) {
      return CupertinoPageScaffold(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 6,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          context.read<IndexToSave>().setIndex(index);
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                              barrierDismissible: true,
                              opaque: false,
                              pageBuilder: (_, anim1, anim2) => SlideTransition(
                            position: Tween<Offset>(
                                begin: Offset(0.0, 1.0), end: Offset.zero)
                                .animate(anim1),
                            child: FoodsConsumed(),
                          ),
                              ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.all(20.0),
                          height: 100,
                          width: 350,
                          decoration: BoxDecoration(
                            color: CupertinoColors.tertiaryLabel,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Row(
                            children: <Widget>[
                              headingForData(returnReactionLevel(index), 16, true),
                              Spacer(),
                              returnIcon(index),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      );
    }
  }

  class FoodsConsumed extends StatefulWidget {
    const FoodsConsumed({Key? key}) : super(key: key);

    @override
    State<FoodsConsumed> createState() => _FoodsConsumedState();
  }

  class _FoodsConsumedState extends State<FoodsConsumed> {
    Icon returnIcon(int index) {
      //on tap feature to display sized box
      //maybe subtitle feature for allergy level 3(moderate)
      if (index == 0) {
        return Icon(CupertinoIcons.sun_max, size: 30);
      }
      if (index == 1) {
        return Icon(CupertinoIcons.cloud_sun, size: 30);
      }
      if (index == 2) {
        return Icon(CupertinoIcons.cloud_sun_rain, size: 30);
      }
      if (index == 3) {
        return Icon(CupertinoIcons.cloud_drizzle, size: 30);
      }
      if (index == 4) {
        return Icon(CupertinoIcons.cloud_bolt, size: 30);
      }
      if (index == 5) {
        return Icon(CupertinoIcons.cloud_bolt_rain, size: 30);
      }
      return Icon(CupertinoIcons.multiply_circle, size: 30);
    }
    @override
    Widget build(BuildContext context) {
      return Center (
        child: Container(
        padding: EdgeInsets.all(20.0),
        height: 500,
        width: 400,
        decoration: BoxDecoration(
          color: CupertinoColors.opaqueSeparator,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(context.read<UserToSave>().user)
                  .collection('foodData').where('allergy', isEqualTo: context.read<IndexToSave>().indexNew.toString()).snapshots(),
              //write this as method add to an array, then search for values to add
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Align(
                  alignment: Alignment.center,
                  child: CupertinoActivityIndicator(),
                );
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final data = snapshot.requireData;
                      if(data.docs[index]['allergy'] == context.read<IndexToSave>().indexNew.toString()) {
                        return CupertinoListTile(
                          trailing: returnIcon(context
                              .read<IndexToSave>()
                              .indexNew),
                          title: Text('${data.docs[index]['food']}'),
                          subtitle: Text('${data.docs[index]['allergy']}'),
                        );
                      }
                      return Align(
                        alignment: Alignment.center,
                        child: Text('No Data to Display', style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),),
                      );
                    });
              }),
        ),

      );
    }
  }
