import 'package:apod/pages/apod.dart';
import 'package:apod/pages/apod_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int? count;
  DateTime selectedDate = DateTime.now();
  bool date = false;

  final DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900, 1),
      lastDate: DateTime(2100, 12),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        date = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            'Astronomy Picture of the Day',
            style: TextStyle(color: Colors.deepOrange),
          )),
        ),
        body: Column(children: [
          Row(
            children: [
              const SizedBox(
                height: 100,
                width: 20,
              ),
              const Text(
                "Enter a date to see images:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                    fontSize: 20),
              ),
              const SizedBox(
                width: 10,
              ),
              TextButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Text(
                      date == false
                          ? " Select Date"
                          : "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange))),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                height: 100,
                width: 20,
              ),
              const Text(
                "Enter the amount of images:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                    fontSize: 20),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Max:50",
                    border: InputBorder.none,
                  ),
                  onChanged: (val) {
                    setState(() {
                      count = int.parse(val);
                    });
                  },
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                date = false;
              });
            },
            child: Container(
              width: 200,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
              ),
              child: const Text('Clear Date',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              onPressed: () {
                if (date) {
                  String dateString =
                      "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ApodDate(date: dateString)),
                  );
                } else {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Please select a date'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ));
                }
              },
              child: const Text("Search Via Date")),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              onPressed: () {
                if (count == null) {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Please enter a number'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ));
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Apod(
                              cnt: count.toString(),
                            )),
                  );
                }
              },
              child: const Text(
                "Todays Picture of the Day(Enter count)",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Disclaimer: This app is not affiliated with NASA",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Note:You can only search for 50 images at once",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Note:You will get fixed amount of images if you search by date",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
            ),
          ),
        ]));
  }
}
