import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Widget List',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List widgetText = [
    'Container',
    'Text',
    'Column',
    'Row',
    'Replace',
    'Delete',
  ];
  List<Widget> adds = [];
  ScrollController _scrollController = ScrollController();

  scrollToBottom() async{
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget rowWidget = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        styleText("I'm"),
        styleText("Row"),
        styleText("Widget"),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Widget List",
          style: TextStyle(color: Colors.grey.shade50),
        ),
        brightness: Brightness.dark,
        backgroundColor: Colors.indigo.shade600,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              if (adds.length > 0) {
                adds.clear();
                setState(() {});
              }
            },
            child: Text(
              "Clear",
              style: TextStyle(color: Colors.grey.shade50),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 85,
            child: Container(
              child: RawScrollbar(
                thickness: 4,
                thumbColor: Colors.indigo,
                radius: Radius.circular(15),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: adds,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 15,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              width: double.infinity,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Chip(
                      backgroundColor: Colors.grey.shade100,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      label: Text(
                        widgetText[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.indigo.shade600,
                        ),
                      ),
                      elevation: 1,
                      side: BorderSide(color: Colors.indigo.shade600),
                    ),
                    onTap: () {
                      switch (index) {
                        case 0:
                          adds.add(containerWidget);
                          scrollToBottom();
                          setState(() {});
                          break;
                        case 1:
                          adds.add(textWidget);
                          scrollToBottom();
                          setState(() {});
                          break;
                        case 2:
                          adds.add(columnWidget);
                          scrollToBottom();
                          setState(() {});
                          break;
                        case 3:
                          adds.add(rowWidget);
                          scrollToBottom();
                          setState(() {});
                          break;
                        case 4:
                          if (adds.length > 0) {
                            adds[0] = rowWidget;
                            scrollToBottom();
                            setState(() {});
                          }
                          break;
                        case 5:
                          if (adds.length > 0) {
                            adds.removeAt(0);
                            scrollToBottom();
                            setState(() {});
                          }
                          break;
                      }
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: 10);
                },
                itemCount: widgetText.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget containerWidget = Padding(
    padding: EdgeInsets.symmetric(vertical: 20),
    child: Container(
      height: 30,
      width: double.infinity,
      color: Colors.indigoAccent,
    ),
  );

  Widget textWidget = Padding(
    padding: EdgeInsets.symmetric(vertical: 30),
    child: Text(
      "I'm Text Widget",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.indigo.shade600,
      ),
    ),
  );

  Widget columnWidget = Padding(
    padding: EdgeInsets.symmetric(vertical: 30),
    child: Column(
      children: [
        Text(
          "I'm",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.indigo.shade600,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Column",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.indigo.shade600,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Widget",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.indigo.shade600,
          ),
        ),
      ],
    ),
  );

  Widget styleText(text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.indigo.shade600,
      ),
    );
  }
}
