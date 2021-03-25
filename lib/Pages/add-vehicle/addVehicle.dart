import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pool_rides/utils/lists.dart';

class AddVehiclePage extends StatefulWidget {
  AddVehiclePage({Key key}) : super(key: key);

  @override
  _AddVehiclePageState createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  // List<ListItem> _dropdownItems = [];

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems();
    _selectedItem = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems() {
    List<DropdownMenuItem<ListItem>> items = [];

    var marcas = json.decode(marcasCoches);

    for (int i = 0; i < marcas.length; i++) {
      items.add(
        DropdownMenuItem(
          child: Container(
            // height: 100,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(marcas["$i"]),
              ],
            ),
          ),
          value: ListItem(i, marcas["$i"]),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10,
            ),
            child: Text(
              "¿Cuál es la marca de tu vehículo?",
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: DropdownButton<ListItem>(
                      value: _selectedItem,
                      items: _dropdownMenuItems,
                      // itemHeight: 2,
                      onChanged: (value) {
                        setState(() {
                          _selectedItem = value;
                        });
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}
