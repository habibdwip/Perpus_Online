import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:perpus_online/app/data/dbHelper.dart';
import 'package:perpus_online/app/modules/staff/views/staff_model.dart';

import '../controllers/staff_controller.dart';

class StaffView extends GetView<StaffController> {
  @override
  Widget build(BuildContext context) {
    return StaffPage();
  }
}

class StaffPage extends StatefulWidget {
  StaffPage({Key? key}) : super(key: key);

  @override
  _StaffPageState createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    BukuView(),
    PinjamView(),
    ProfiView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StaffView'),
        centerTitle: true,
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Daftar Buku',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Daftar Pinjam',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class BukuView extends StatefulWidget {
  const BukuView({super.key});

  @override
  State<BukuView> createState() => _BukuViewState();
}

class _BukuViewState extends State<BukuView> {
  TextEditingController bukuController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  DbHelper dbHelper = DbHelper();

  @override
  void initState() {
    dbHelper.database;
    super.initState();
    bukuController.text = "";
    jumlahController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Daftar Buku',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Nama Buku',
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Jumlah Buku',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder<List<BukuModel>>(
                  future: dbHelper.allBuku(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.length == 0) {
                        return Center(
                          child: Text('Data masih kosong'),
                        );
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                                child: ListTile(
                                    title: Row(children: [
                              Expanded(
                                  child: Text(
                                      snapshot.data![index].namaBuku ?? '')),
                              Expanded(
                                  child: Text(snapshot.data![index].jumlahBuku
                                      .toString())),
                            ])));
                          });
                    } else {
                      return Center(
                        child: Text("Data Masih Kosong"),
                      );
                    }
                  }),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Future openDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            scrollable: true,
            insetPadding: EdgeInsets.symmetric(vertical: 100),
            title: Text("Masukkan Buku"),
            content: Column(
              children: [
                TextField(
                    controller: bukuController,
                    decoration: InputDecoration(hintText: "Nama buku")),
                TextField(
                    controller: jumlahController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Jumlah buku")),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: (() async {
                      await dbHelper.insertBuku({
                        'namaBuku': bukuController.text,
                        'jumlahBuku': jumlahController.text,
                      });
                      navigator!.pop(context);
                      setState(() {});
                    }),
                    child: Text("Submit"))
              ],
            ),
          ));
}

class PinjamView extends StatefulWidget {
  const PinjamView({super.key});

  @override
  State<PinjamView> createState() => _PinjamViewState();
}

class _PinjamViewState extends State<PinjamView> {
  TextEditingController bukupController = TextEditingController();
  TextEditingController namapController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  DbHelper dbHelper = DbHelper();

  @override
  void initState() {
    dbHelper.database;
    super.initState();
    bukupController.text = "";
    namapController.text = "";
    tanggalController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Daftar Peminjam Buku',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Nama Buku',
                  ),
                ),
                Expanded(
                  child: Text(
                    'Nama peminjam',
                  ),
                ),
                Expanded(
                  child: Text(
                    'Tanggal pinjam',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder<List<PinjamModel>>(
                future: dbHelper.allPinjam(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.length == 0) {
                      return Center(
                        child: Text('Data masih kosong'),
                      );
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                              child: ListTile(
                                  title: Row(children: [
                            Expanded(
                                child: Text(
                                    snapshot.data![index].namaBukup ?? '')),
                            Expanded(
                                child: Text(
                                    snapshot.data![index].namaPeminjam ?? '')),
                            Expanded(
                                child: Text(snapshot.data![index].tanggalPinjam
                                    .toString())),
                          ])));
                        });
                  } else {
                    return Center(
                      child: Text("Data Masih Kosong"),
                    );
                  }
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Future openDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            scrollable: true,
            insetPadding: EdgeInsets.symmetric(vertical: 100),
            title: Text("Masukkan Peminjam Buku"),
            content: Column(
              children: [
                TextField(
                    controller: bukupController,
                    decoration: InputDecoration(hintText: "Nama buku")),
                TextField(
                    controller: namapController,
                    decoration:
                        InputDecoration(hintText: "Nama peminjam buku")),
                TextField(
                    controller: tanggalController,
                    decoration: InputDecoration(hintText: "Tanggal pinjam"),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat("dd-MM-yyy").format(pickedDate);

                        setState(() {
                          tanggalController.text = formattedDate.toString();
                        });
                      } else {
                        print("Not selected");
                      }
                    }),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: (() async {
                      await dbHelper.insertPinjam({
                        'namaBukup': bukupController.text,
                        'namaPeminjam': namapController.text,
                        'tanggalPinjam': tanggalController.text,
                      });
                      navigator!.pop(context);
                      setState(() {});
                    }),
                    child: Text("Submit"))
              ],
            ),
          ));
}

class ProfiView extends StatefulWidget {
  const ProfiView({super.key});

  @override
  State<ProfiView> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfiView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Profil")),
    );
  }
}
