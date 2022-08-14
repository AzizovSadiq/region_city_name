import 'package:flutter/material.dart';

import 'my_list.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>>? searchList = [];

  @override
  void initState() {
    searchList = regionList;
    super.initState();
  }

  void changeFilter(String enteredKeyword) {
    List<Map<String, dynamic>> resultList = [];
    if (enteredKeyword.isEmpty) {
      resultList = regionList;
    } else {
      resultList = regionList
          .where(
            (element) => element['name'].toLowerCase().contains(
                  enteredKeyword.toLowerCase(),
                ),
          )
          .toList();
    }
    setState(() {
      searchList = resultList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(widget.title)),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color.fromARGB(255, 87, 186, 224),
              ),
              child: TextField(
                onChanged: (value) => changeFilter(value),
                cursorHeight: 24,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 20,
                    )),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: searchList!.length,
                itemBuilder: ((context, index) {
                  return CardRegionList(index);
                })),
          ),
        ],
      ),
    );
  }

  Card CardRegionList(int index) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      key: ValueKey(regionList[index]['id']),
      color: Colors.blue,
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Center(
            child: Text(
              searchList![index]['id'].toString(),
              style: const TextStyle(
                  fontSize: 24,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        title: Text(
          searchList![index]['name'].toString(),
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        subtitle: Text(
          'Population: ${searchList![index]['Əhalisi'].toString()}',
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        trailing: Text(
          'Area\n${searchList![index]['Ərazisi'].toString()}',
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
