import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<String> _reminders = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 31, 29, 29),
        appBar : AppBar(
          title: const Text('PopNow'),
          backgroundColor: Colors.red,
        ),
        
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _reminders.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(_reminders[index]),
                      trailing: IconButton(
                        icon : Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _reminders.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter a reminder',
                  filled: true,
                  fillColor: Colors.white,
                ),
                onSubmitted: (value) {
                  setState(() {
                    _reminders.add(value);
                  });
                },
              ),
            )
          ]
          ),
      ),
      // backgroundColor: Color.fromARGB(97, 54, 54, 54),

      
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: Colors.white,
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
