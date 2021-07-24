import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('TABLE'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Container(
                child: TablePopulator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TablePopulator extends StatefulWidget {
  @override
  _TablePopulatorState createState() => _TablePopulatorState();
}

class _TablePopulatorState extends State<TablePopulator> {
  List category = [];
  List categoryForGender = [];
  List createdAt = [];
  List description = [];
  List discount = [];
  List freeDelivery = [];
  List images = [];
  List markup = [];
  List price = [];
  List productName = [];
  List id = [];
  List specifications = [];
  List displayPrice = [];
  int lengthOfData = 0;
  List<String> static_category;
  List<String> static_categoryForGender;
  List<String> static_createdAt;
  List<String> static_description;
  List<String> static_discount;
  List<String> static_freeDelivery;
  List<String> static_images;
  List<String> static_markup;
  List<String> static_price;
  List<String> static_productName;
  List<String> static_id;
  List<String> static_specifications;
  List<String> static_displayPrice;

  Future readJson() async {
    var dataOne = await rootBundle.loadString('resources/data.json');
    lengthOfData = 199;
    List data = jsonDecode(dataOne);
    log("lengthOfData: $lengthOfData");
    int i = 0;
    double priceP = 0, displayPriceP = 0;
    int markupP = 0, discountP = 0;
    setState(() {
      for (i = 0; i < lengthOfData; ++i) {
        category.add(data[i]["category"].toString());
        categoryForGender.add(data[i]["categoryForGender"].toString());
        discount.add(data[i]["discount"].toString());
        freeDelivery.add(data[i]["freeDelivery"].toString());
        images.add(data[i]["images"].toString());
        markup.add(data[i]["markup"].toString());
        price.add(data[i]["price"].toString());
        productName.add(data[i]["productName"].toString());
        id.add(data[i]["id"].toString());
        priceP = double.parse(data[i]["price"]);
        markupP = data[i]["markup"];
        discountP = data[i]["discount"];
        displayPriceP = priceP * ((1 + markupP / 100) - discountP / 100);
        displayPrice.add(displayPriceP.toStringAsFixed(2));
      }
      static_category = category.cast<String>();
      static_categoryForGender = categoryForGender.cast<String>();
      static_createdAt = createdAt.cast<String>();
      static_description = description.cast<String>();
      static_discount = discount.cast<String>();
      static_freeDelivery = freeDelivery.cast<String>();
      static_images = images.cast<String>();
      static_markup = markup.cast<String>();
      static_price = price.cast<String>();
      static_productName = productName.cast<String>();
      static_id = id.cast<String>();
      static_displayPrice = displayPrice.cast<String>();
    });
  }

  @override
  void initState() {
    readJson();
    super.initState();
  }

  Widget createTable() {
    List<TableRow> rows = [];
    int i = 0;

    rows.add(TableRow(children: [
      Text(
        "Name",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      Text(
        "Image",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      Text(
        "Category",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      Text(
        "Gender",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      Text(
        "Price",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      Text(
        "Markup",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      Text(
        "Discount",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      Text(
        "Display Price",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      Text(
        "Free Delivery",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ]));
    for (i = 0; i < lengthOfData; ++i) {
      rows.add(TableRow(children: [
        Text(
          static_productName[i],
          textAlign: TextAlign.center,
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: Image.network(
            static_images[i],
            height: 60.0,
            fit: BoxFit.fitHeight,
          ),
        ),
        Text(
          static_category[i],
          textAlign: TextAlign.center,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: (static_categoryForGender[i] == 'Male') ? 1 : 0,
                fillColor:
                    MaterialStateColor.resolveWith((states) => Colors.blue),
              ),
              new Text(
                'M',
                style: new TextStyle(fontSize: 16.0),
              ),
              new Radio(
                value: 1,
                groupValue: static_categoryForGender[i] == 'Female' ? 1 : 0,
                fillColor:
                    MaterialStateColor.resolveWith((states) => Colors.blue),
              ),
              new Text(
                'F',
                style: new TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        // Text(
        //   static_categoryForGender[i],
        //   textAlign: TextAlign.center,
        // ),
        Text(
          static_price[i],
          textAlign: TextAlign.center,
        ),
        Text(
          static_markup[i],
          textAlign: TextAlign.center,
        ),
        Text(
          static_discount[i],
          textAlign: TextAlign.center,
        ),
        Text(
          static_displayPrice[i],
          textAlign: TextAlign.center,
        ),
        Container(
          child: Checkbox(
            value: static_freeDelivery[1] == 'false' ? false : true,
          ),
        ),
        // Text(
        //   static_freeDelivery[i],
        //   textAlign: TextAlign.center,
        // ),
      ]));
    }
    return Container(
      margin: EdgeInsets.all(10),
      child: Table(
        children: rows,
        textDirection: TextDirection.ltr,
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(
          width: 1.5,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return createTable();
  }
}
