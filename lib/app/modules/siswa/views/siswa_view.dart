import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpus_online/app/data/dbHelper.dart';
import '../../staff/views/staff_model.dart';
import '../controllers/siswa_controller.dart';

class SiswaView extends GetView<SiswaController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SiswaView'),
          centerTitle: true,
        ),
        body: SearchSiswaView());
  }
}

class SearchSiswaView extends StatefulWidget {
  const SearchSiswaView({super.key});

  @override
  State<SearchSiswaView> createState() => _SearchSiswaViewState();
}

class _SearchSiswaViewState extends State<SearchSiswaView> {
  DbHelper dbHelper = DbHelper();

  @override
  void initState() {
    dbHelper.database;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                              child:
                                  Text(snapshot.data![index].namaBukup ?? '')),
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
    );
  }
}
