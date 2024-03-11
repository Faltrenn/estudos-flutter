import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Rcp1 extends StatelessWidget {
  const Rcp1({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          fontFamily: "Whisper",
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
          ),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Meu app"),
          ),
          body: const Center(
            child: Column(
              children: [
                Text(
                  "Boa",
                  style: TextStyle(
                    fontFamily: "Minecraft",
                    fontStyle: FontStyle.italic,
                    fontSize: 40
                  ),
                ),
                Text("noite"),
                Text("meu"),
                Text("amigo"),
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
                icon: const Icon(Icons.tv),
              )),
            ],
          ),
        ));
  }
}
