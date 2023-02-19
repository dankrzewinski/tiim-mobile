import 'package:flutter/material.dart';
import 'package:app/services/connector.dart';
import 'package:app/widgets/widgets.dart';
import 'package:like_button/like_button.dart';

import '../model/CarDetails.dart';

class CarDetailsPage extends StatefulWidget {
  const CarDetailsPage({Key? key}) : super(key: key);

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final carId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: getLogoutButton(context),
        appBar: AppBar(title: const Text("Car Details")),
        body: FutureBuilder<CarDetails>(
          future: getCarDetails(carId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 20.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 300,
                          child: Image.network(
                            snapshot.data!.photoUrl
                                .replaceAll(localHost, baseUrl),
                            fit: BoxFit.fill,
                          ),
                        )
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10.0)),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              "",
                              style: getTextStyleBold20(),
                            )
                        ),
                        Expanded(
                            flex: 4,
                            child: Text(
                              "Make",
                              style: getTextStyleBold20(),
                            )
                        ),
                        Expanded(
                            flex: 4,
                            child: Text(
                              snapshot.data!.make,
                              style: getTextStyleBold20(),
                            )
                        )
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10.0)),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              "",
                              style: getTextStyleBold20(),
                            )
                        ),
                        Expanded(
                            flex: 4,
                            child: Text(
                              "Model",
                              style: getTextStyleBold20(),
                            )
                        ),
                        Expanded(
                            flex: 4,
                            child: Text(
                              snapshot.data!.model,
                              style: getTextStyleBold20(),
                            )
                        )
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10.0)),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              "",
                              style: getTextStyleBold20(),
                            )
                        ),
                        Expanded(
                            flex: 4,
                            child: Text(
                              "Color",
                              style: getTextStyleBold20(),
                            )
                        ),
                        Expanded(
                            flex: 4,
                            child: Text(
                              snapshot.data!.color,
                              style: getTextStyleBold20(),
                            )
                        )
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10.0)),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              "",
                              style: getTextStyleBold20(),
                            )
                        ),
                        Expanded(
                            flex: 4,
                            child: Text(
                              "Horse Power",
                              style: getTextStyleBold20(),
                            )
                        ),
                        Expanded(
                            flex: 4,
                            child: Text(
                              snapshot.data!.horsePower.toString(),
                              style: getTextStyleBold20(),
                            )
                        )
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10.0)),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              "",
                              style: getTextStyleBold20(),
                            )
                        ),
                        Expanded(
                            flex: 4,
                            child: Text(
                              "Engine Size",
                              style: getTextStyleBold20(),
                            )
                        ),
                        Expanded(
                            flex: 4,
                            child: Text(
                              "${snapshot.data!.engineSize} cm3",
                              style: getTextStyleBold20(),
                            )
                        )
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LikeButton(
                          key: Key(snapshot.data!.id),
                          isLiked: snapshot.data!.isUserFavourite,
                          onTap: (isLiked) {
                            return handleFavoriteButton(
                                isLiked, snapshot.data!.id);
                          },
                        ),
                      ],
                    ),
                    if (snapshot.data!.isUserOwner) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20)),
                            child: TextButton(
                                onPressed: () {
                                  deleteCar(carId).then((value) => {
                                      Navigator.pop(context)
                                  }).onError((error, stackTrace) =>
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text('Error occurred. Try again'),
                                        action: SnackBarAction(
                                          label: 'Hide',
                                          onPressed: () {
                                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                          },
                                        ),
                                      ),
                                    )
                                  });
                                },
                                child: const Text(
                                  'Delete car',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )),
                          ),
                          const Padding(
                              padding: EdgeInsets.only(left: 10.0)
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20)),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'update_car', arguments: snapshot.data!);
                                },
                                child: const Text(
                                  'Update car',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )),
                          ),
                        ],
                      )
                    ],
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              Navigator.pushReplacementNamed(context, 'home');
            }
            return const CircularProgressIndicator();
          },
        ));
  }
}
