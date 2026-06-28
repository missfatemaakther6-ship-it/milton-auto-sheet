import 'package:flutter/material.dart';

void main() {
  runApp(MiltonAutoSheetApp());
}

class MiltonAutoSheetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Milton Auto Sheet',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      home: SalarySheetScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Employee {
  String name = '';
  String designation = '';
  double basic = 0;
  double growthPercent = 0;
  int fridayDays = 0;

  double growthAmount(double dailyRate) => basic * growthPercent / 100;
  double fridayAmount(double dailyRate) => fridayDays * dailyRate;
  double grandSalary(double dailyRate) => basic + growthAmount(dailyRate) + fridayAmount(dailyRate);
}

class SalarySheetScreen extends StatefulWidget {
  @override
  _SalarySheetScreenState createState() => _SalarySheetScreenState();
}

class _SalarySheetScreenState extends State<SalarySheetScreen> {
  List<Employee> employees = [Employee()];
  double dailyRate = 600; // এখানে তোমার ডেইলি রেট দাও। 600 এর জায়গায় 700/800 বসাও

  void addRow() {
    setState(() {
      employees.add(Employee());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Milton Auto Sheet - Salary Sheet'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              showDialog(context: context, builder: (ctx) => AlertDialog(
                title: Text('ডেইলি রেট সেট করো'),
                content: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'যেমন: 600'),
                  onChanged: (v) => setState(() => dailyRate = double.tryParse(v)?? 600),
                ),
                actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: Text('OK'))],
              ));
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue[100],
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Row(
              children: [
                Expanded(flex: 1, child: Text('SL', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                Expanded(flex: 3, child: Text('নাম', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                Expanded(flex: 3, child: Text('ডেজিগনেশন', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                Expanded(flex: 2, child: Text('বেসিক', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                Expanded(flex: 2, child: Text('গ্রোথ%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                Expanded(flex: 2, child: Text('শুক্র', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                Expanded(flex: 3, child: Text('গ্র্যান্ড', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (ctx, i) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: Center(child: Text('${i+1}'))),
                      Expanded(flex: 3, child: TextField(decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(5)), onChanged: (v) => employees[i].name = v)),
                      Expanded(flex: 3, child: TextField(decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(5)), onChanged: (v) => employees[i].designation = v)),
                      Expanded(flex: 2, child: TextField(keyboardType: TextInputType.number, decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(5)), onChanged: (v) => setState(() => employees[i].basic = double.tryParse(v)?? 0))),
                      Expanded(flex: 2, child: Slider(value: employees[i].growthPercent, min: 0, max: 100, divisions: 100, label: '${employees[i].growthPercent.round()}%', onChanged: (v) => setState(() => employees[i].growthPercent = v))),
                      Expanded(flex: 2, child: TextField(keyboardType: TextInputType.number, decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(5)), onChanged: (v) => setState(() => employees[i].fridayDays = int.tryParse(v)?? 0))),
                      Expanded(flex: 3, child: Text(employees[i].grandSalary(dailyRate).toStringAsFixed(0), style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: addRow,
        tooltip: 'নতুন লাইন',
      ),
    );
  }
}
