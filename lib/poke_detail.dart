import 'package:flutter/material.dart';

// class MyHomePage extends StatelessWidget {
class PokeDetail extends StatelessWidget {
  // const MyHomePage({Key? key}) : super(key: key);
  const PokeDetail({Key? key}) : super(key: key);
    @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: Center(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Stack(
                    children: [
                      Container(
                    // color: Colors.lightGreen,
                    padding: const EdgeInsets.all(32),
                    child: Image.network(
                      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
                      height: 100,
                      width: 100,
                      // color: Colors.green,
                    ),
                  ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text(
                          'No.25',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const Text(
                  'pikachu',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    // backgroundColor:Colors.yellow
                    ),
                  ),
                  const Chip(
                    backgroundColor: Colors.yellow,
                    label: Text(
                      'electric',
                      style: TextStyle(
                        // color: Colors.yellow.computeLuminance() > 0.5
                        // ? Colors.black
                        // : Colors.white
                        color: Colors.blue
                      ),
                    ),
                  ),
              ],),
            ),
          );
      }



}