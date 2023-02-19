import 'package:flutter/material.dart';
import 'package:app/services/connector.dart';
import 'package:app/widgets/widgets.dart';

import '../model/Car.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: "floatRefresh",
                  onPressed: () {
                    setState(() {});
                  },
                  child: const Icon(Icons.refresh),
                ),
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                getAddButton(context),
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                getLogoutButton(context),
              ],
            )
          ],
        ),

        appBar: AppBar(title: const Text("Home Page")),
        body: FutureBuilder<List<Car>>(
          future: getCars(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.grey,
                      child: Row(children: [
                        Padding(padding: EdgeInsets.only(top: 20.0)),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Make: ${snapshot.data![index].make}'),
                              Text('Model: ${snapshot.data![index].model}'),
                            ],
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Column(
                            children: [
                              Text(
                                  'Engine size: ${snapshot.data![index].engineSize}'),
                              Text(
                                  'Horse power: ${snapshot.data![index].horsePower}'),
                            ],
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Column(
                            children: [
                              TextButton(
                                child: Text('Details'),
                                onPressed: () {
                                  Navigator.pushNamed(context, 'car_details', arguments: snapshot.data![index].id);
                                },
                              )
                            ],
                          ),
                        )
                      ]),
                    );
                  });
            } else if (snapshot.hasError) {
              Navigator.pushReplacementNamed(context, 'home');
            }
            return const CircularProgressIndicator();
          },
        ));
  }
}
