import 'package:flutter/material.dart';
import './poke_detail.dart';

class PokeListItem extends StatelessWidget {
  const PokeListItem({Key? key,required this.index}):super (key :key);
  final int index;

  @override
  Widget build (BuildContext context){
    return ListTile(
      // tileColor: Colors.green,
      
      leading:  Container(
        decoration: BoxDecoration(
          color: Colors.yellow.withOpacity(.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.network(
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
          height: 50,
          width: 80,
          fit: BoxFit.fitWidth,
        ),
      ),
      title: const Text(
        'Pikachu',
        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
        ),
      subtitle: const Text(
        '⚡️electric',
      ),
      onTap: ()=>{
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => const PokeDetail()
          ),
        ),
      },
    );
  }
}