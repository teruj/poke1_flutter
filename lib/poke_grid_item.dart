import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poke/const/pokeapi.dart';
import 'package:poke/models/pokemon.dart';
import 'package:poke/poke_detail.dart';

import 'const/pokeapi.dart';

class PokeGridItem extends StatelessWidget {
  const PokeGridItem({Key? key, required this.poke}) : super(key: key);
  final Pokemon? poke;

  @override
  Widget build(BuildContext context) {
    if (poke != null) {
      return Column(
        children: [
          InkWell(
            onTap: () => {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return PokeDetail(poke: poke!);
              }))
            },
            child: Hero(
              tag: poke!.name,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: (pokeTypeColors[poke!.types.first] ?? Colors.grey[100])!
                      .withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: NetworkImage(poke!.imageUrl),
                  ),
                ),
              ),
            ),
          ),
          Text(
            poke!.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      );
    } else {
      return const SizedBox(
        width: 100,
        height: 100,
        child: Center(
          child: Text('...'),
        ),
      );
    }
  }
}
