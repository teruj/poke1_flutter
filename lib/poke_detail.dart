import 'package:flutter/material.dart';
import 'package:poke/const/pokeapi.dart';
import 'package:provider/provider.dart';
import './models/pokemon.dart';

import './models/favorite.dart';

class PokeDetail extends StatelessWidget {
  const PokeDetail({Key? key, required this.poke}) : super(key: key);

  final Pokemon poke;

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteNotifier>(builder: (context, favs, childe) {
      return Scaffold(
        body: Container(
          color: (pokeTypeColors[poke.types.first] ?? Colors.grey[100])
              ?.withOpacity(0.5),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  trailing: IconButton(
                    icon: favs.isExist(poke.id)
                        ? const Icon(
                            Icons.star,
                            color: Colors.orangeAccent,
                          )
                        : const Icon(Icons.star_outline),
                    onPressed: () => {
                      favs.toggle(Favorite(pokeId: poke.id)),
                    },
                  ),
                ),
                const Spacer(),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Container(
                        height: 280,
                        width: 280,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(180),
                          color: Colors.white.withOpacity(.5),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Hero(
                        tag: poke.name,
                        child: Image.network(
                          poke.imageUrl,
                          height: 250,
                          width: 250,
                          // color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 15),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    color: Colors.white.withOpacity(.5),
                  ),
                  child: Text(
                    '#${poke.id.toString().padLeft(3, "0")}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${poke.name.substring(0,1).toUpperCase()}${poke.name.substring(1)}',
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
                        (type) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Chip(
                            backgroundColor:
                                pokeTypeColors[type] ?? Colors.grey,
                            label: Text(
                              type,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: (pokeTypeColors[type] ?? Colors.grey)
                                              .computeLuminance() >
                                          0.5
                                      ? Colors.black
                                      : Colors.white),
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
        ),
      );
    });
  }
}
