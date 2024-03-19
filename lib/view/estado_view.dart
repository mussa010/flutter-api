// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../model/estado.dart';
import '../service/ibge_service.dart';

class EstadoView extends StatefulWidget {
  const EstadoView({super.key});

  @override
  State<EstadoView> createState() => _EstadoViewState();
}

class _EstadoViewState extends State<EstadoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        //
        // Requisição da API
        //
        child: FutureBuilder(
          future: IbgeService().listarEstados(),
          builder: (context, snapshot) {
            //Requisição finalizada
            if (snapshot.connectionState == ConnectionState.done) {
              var lista = snapshot.data as List<Estado>;
              return ListView.builder(
                itemCount: lista.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.location_city),
                      title:
                          Text('${lista[index].nome} (${lista[index].sigla})'),
                      subtitle: Text('Região ${lista[index].regiao}'),
                    ),
                  );
                },
              );
            }

            //Aguardando a requisição
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
