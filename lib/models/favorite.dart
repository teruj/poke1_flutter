import 'package:flutter/material.dart';
import '../db/favorites.dart';

class Favorite {
  final int pokeId;

  Favorite({
    required this.pokeId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': pokeId,
    };
  }
}

class FavoriteNotifier extends ChangeNotifier {
  final List<Favorite> _favs = [];
  List<Favorite> get favs => _favs;

  FavoriteNotifier() {
    syncDb();
  }

  void toggle(Favorite fav) {
    if (isExist(fav.pokeId)) {
      delete(fav.pokeId);
    } else {
      add(fav);
    }
  }

  bool isExist(int id) {
    if (_favs.indexWhere((fav) => fav.pokeId == id) < 0) {
      return false;
    } else {
      return true;
    }
  }

  void syncDb() async {
    FavoritesDb.read().then(
        // (val) => _favs
        //   ..clear()
        //   ..addAll(val),

        (val) {
      _favs.clear();
      _favs.addAll(val);
    });
    notifyListeners();
  }

  void add(Favorite fav) async {
    // favs.add(fav); //syncDb追加によりローカルのみのaddは実装せず
    await FavoritesDb.create(fav);
    syncDb();
  }

  void delete(int id) async {
    // favs.removeWhere((fav) => fav.pokeId == id); //syncDb追加により削除
    await FavoritesDb.delete(id);
    syncDb();
  }
}
