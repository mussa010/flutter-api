import 'package:flutter/material.dart';

import '../model/estado.dart';
import '../model/municipio.dart';
import '../service/ibge_service.dart';

class MunicipioView extends StatefulWidget {
  //
  // Receber a sigla do Estado como Parâmetro
  //
  final Estado estado;
  const MunicipioView(this.estado, {super.key});

  @override
  State<MunicipioView> createState() => _MunicipioViewState();
}

class _MunicipioViewState extends State<MunicipioView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.estado.nome} (${widget.estado.sigla})'),
      ),
      //
      // Lista os Municípios do Estado selecionado pelo usuário
      //
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          //Chamar o EndPoint da API do IBGE
          future: IbgeService().listarMunicipios(widget.estado.sigla),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var lista = snapshot.data as List<Municipio>;
              return ListView.builder(
                itemCount: lista.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(lista[index].nome),
                  );
                },
              );
            }
            //Aguardando a requisição
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
