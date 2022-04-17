import 'dart:convert';

import 'package:poke/models/pokemon.dart';
import 'package:http/http.dart' as http;
import '../const/pokeapi.dart';

Future<Pokemon> fetchPokemon(int id) async {
  final res = await http.get(Uri.parse('$pokeApiRoute/pokemon/$id'));
  // final res = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));
  if (res.statusCode == 200) {
    return Pokemon.fromJson(jsonDecode(res.body));
  } else {
    throw Exception('Failed to Load Pokemon');
  }
}
