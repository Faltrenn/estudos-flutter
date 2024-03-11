import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

class Rcp1 extends StatelessWidget {
  const Rcp1({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          fontFamily: "Minecraft",
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
          ),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Meu app"),
          ),
          body: Center(
            child: Column(
              children: [
                const Text(
                  "Boa",
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 40),
                ),
                const Text("noite"),
                const Text("meu"),
                const Text("amigo"),
                FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image:
                      "https://cdn.pensador.com/img/imagens/qu/es/que_sua_noite_seja_iluminada_pelos_mais_lindos_sonhos_boa_noite_c.jpg?auto_optimize=low&width=655",
                ),
              ],
            ),
          ),
          bottomNavigationBar: Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                onPressed: () {},
                child: const Text("É"),
              )),
              Expanded(
                  child: ElevatedButton(
                onPressed: () {},
                child: const Text("bom"),
              )),
              Expanded(
                  child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.sunny),
              )),
            ],
          ),
        ));
  }
}
