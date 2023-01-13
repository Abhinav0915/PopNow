import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> with WidgetsBindingObserver {
  List<String> _reminders = [];
  final TextEditingController _controller = TextEditingController();

  late Database _db;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initDb();
  }

  void _initDb() async {
    _db =
        await openDatabase('reminders.db', version: 1, onCreate: (db, version) {
      db.execute(
          "CREATE TABLE reminders (id INTEGER PRIMARY KEY, reminder TEXT)");
    });
    _loadReminders();
  }

  void _loadReminders() async {
    final reminders = await _db.query('reminders');
    setState(() {
      _reminders = reminders.map((r) => r['reminder'].toString()).toList();
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _db.close();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 31, 29, 29),
        appBar: AppBar(
          title: const Text('PopNow'),
          backgroundColor: Colors.red,
        ),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: _reminders.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    width: 380.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      title: Text(_reminders[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _db.delete('reminders',
                                where: 'reminder = ?',
                                whereArgs: [_reminders[index]]);
                          });
                          _controller.clear();
                          _loadReminders();
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: 380.0,
              child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    hintText: 'Enter a reminder',
                    hintStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onSubmitted: (value) async {
                    await _db.transaction((txn) async {
                      await txn.rawInsert(
                          'INSERT INTO reminders(reminder) VALUES(?)', [value]);
                    });
                    _controller.clear();
                    _loadReminders();
                  }),
            ),
          )
        ]),
      ),
    );
  }
}
