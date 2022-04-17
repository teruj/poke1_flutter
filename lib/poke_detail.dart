import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:poke/const/pokeapi.dart';
import './models/pokemon.dart';

// class MyHomePage extends StatelessWidget {
class PokeDetail extends StatelessWidget {
  const PokeDetail({Key? key,required this.poke}) : super(key: key);

  final Pokemon poke;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: ()=>Navigator.pop(context),
                ),
            ),
            const Spacer(),
            Stack(
              children: [
                Container(
                  // color: Colors.lightGreen,
                  padding: const EdgeInsets.all(32),
                  child: Image.network(
                    poke.imageUrl,
                    height: 100,
                    width: 100,
                    // color: Colors.green,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'No.${poke.id}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
             Text(
              poke.name,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                // backgroundColor:Colors.yellow
              ),
            ),



            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: poke.types
                .map(
                  (type)=>Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    backgroundColor:pokeTypeColors[type] ?? Colors.grey,
                    label: Text(
                      type,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: (pokeTypeColors[type] 
                              ?? Colors.grey)
                              .computeLuminance() > 0.5
                              ? Colors.black
                              : Colors.white 
                              
                          ),
                    ),
                  ),
                ),
                
                )
                .toList(),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
