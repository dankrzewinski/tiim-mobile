import 'package:app/model/CarDetails.dart';
import 'package:app/services/connector.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class UpdateCarPage extends StatefulWidget {
  const UpdateCarPage({Key? key}) : super(key: key);

  @override
  State<UpdateCarPage> createState() => _UpdateCarPageState();
}

class _UpdateCarPageState extends State<UpdateCarPage> {
  final TextEditingController makeController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController engineSizeController = TextEditingController();
  final TextEditingController horsePowerController = TextEditingController();

  @override
  void dispose() {
    makeController.dispose();
    modelController.dispose();
    colorController.dispose();
    engineSizeController.dispose();
    horsePowerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final carDetails = ModalRoute.of(context)!.settings.arguments as CarDetails;
    makeController.text = carDetails.make;
    modelController.text = carDetails.model;
    colorController.text = carDetails.color;
    engineSizeController.text = carDetails.engineSize.toString();
    horsePowerController.text = carDetails.horsePower.toString();
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                getLogoutButton(context),
              ],
            )
          ],
        ),
        appBar: AppBar(title: const Text("Edit car")),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                  controller: makeController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Make',
                      fillColor: Colors.grey.shade200,
                      filled: true),
                ),
              ),
              Padding(
                padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: modelController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Model',
                      fillColor: Colors.grey.shade200,
                      filled: true),
                ),
              ),
              Padding(
                padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: colorController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Color',
                      fillColor: Colors.grey.shade200,
                      filled: true),
                ),
              ),
              Padding(
                padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: engineSizeController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Engine size in cm3',
                      fillColor: Colors.grey.shade200,
                      filled: true),
                ),
              ),
              Padding(
                padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: horsePowerController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Horse power',
                      fillColor: Colors.grey.shade200,
                      filled: true),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    var makeText = makeController.value.text;
                    var modelText = modelController.value.text;
                    var colorText = colorController.value.text;
                    var engineSizeText = engineSizeController.value.text;
                    var horsePowerText = horsePowerController.value.text;

                    updateCar(
                        carDetails.id,
                        makeText,
                        modelText,
                        colorText,
                        engineSizeText,
                        horsePowerText
                    ).then((value) => {
                      setState(() {
                        Navigator.pushReplacementNamed(context, 'car_details', arguments: carDetails.id);
                      })
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
                  child: Text(
                    'Update car',
                    style: getTextStyleButton25(),
                  ),
                ),
              ),
              const SizedBox(
                height: 130,
              ),
            ],
          ),
        ));
  }
}
