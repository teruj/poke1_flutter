import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'const/pokeapi.dart';
import 'poke_list_item.dart';
import './models/pokemon.dart';

import './models/favorite.dart';
import 'poke_grid_item.dart';

class PokeList extends StatefulWidget {
  const PokeList({Key? key}) : super(key: key);

  @override
  State<PokeList> createState() => _PokeListState();
}

class _PokeListState extends State<PokeList> {
  static const int pageSize = 30;

  bool isFavoriteMode = false;
  // bool isFavoriteMode = true;

  bool isGridMode = true;

  int _currentPage = 1;

  int itemCount(int favsCount, int page) {
    int ret = page * pageSize;
    if (isFavoriteMode && ret > favsCount) {
      // ret = pokeMaxId;
      ret = favsCount;
    }
    if (ret > pokeMaxId) {
      ret = pokeMaxId;
    }

    return ret;
  }

  int itemId(List<Favorite> favs, int index) {
    int ret = index + 1; //通常モード
    if (isFavoriteMode && index < favs.length) {
      ret = favs[index].pokeId;
    }
    return ret;
  }

  bool isLastPage(int favsCount, int page) {
    if (isFavoriteMode) {
      if (_currentPage * pageSize < favsCount) {
        return false;
      }
      return true;
    } else {
      if (_currentPage * pageSize < pokeMaxId) {
        return false;
      }
      return true;
    }
  }

  void changeFavMode(bool currentMode) {
    setState(() {
      isFavoriteMode = !currentMode;
    });
  }

  void changeGridMode(bool currentMode) {
    setState(() {
      isGridMode = !currentMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteNotifier>(builder: (context, favs, child) {
      return Column(
        children: [
          Container(
            height: 24,
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () async {
                // var ret = await showModalBottomSheet<bool>(
                await showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return ViewModeBottomSheet(
                        favMode: isFavoriteMode,
                        gridMode: isGridMode,
                        changeFavMode: changeFavMode,
                        changeGridMode: changeGridMode,
                      );
                    });
                // if (ret != null && ret) {
                //   changeMode(isFavoriteMode);
                // }
              },
              icon: const Icon(Icons.auto_awesome_outlined),
            ),
          ),
          Expanded(
            child: Consumer<PokemonNotifier>(builder: (context, pokes, child) {
              if (itemCount(favs.favs.length, _currentPage) == 0) {
                return const Text('no data');
              } else {
                if (isGridMode) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: itemCount(favs.favs.length, _currentPage) + 1,
                    itemBuilder: (context, index) {
                      if (index == itemCount(favs.favs.length, _currentPage)) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: OutlinedButton(
                            child: const Text('more'),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed:
                                isLastPage(favs.favs.length, _currentPage)
                                    ? null
                                    : () => {
                                          setState(() => _currentPage++),
                                        },
                          ),
                        );
                      } else {
                        return PokeGridItem(
                          poke: pokes.byId(itemId(favs.favs, index)),
                        );
                      }
                      ;
                    },
                  );
                } else {
                  return ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    // itemCount: 898,
                    itemCount: itemCount(favs.favs.length, _currentPage) + 1,
                    itemBuilder: (context, index) {
                      if (index == itemCount(favs.favs.length, _currentPage)) {
                        return OutlinedButton(
                          onPressed: isLastPage(favs.favs.length, _currentPage)
                              ? null
                              : () => {
                                    setState(() {
                                      _currentPage++;
                                    })
                                  },
                          child: const Text('more'),
                        );
                      }
                      return PokeListItem(
                        poke: pokes.byId(itemId(favs.favs, index)),
                      );
                    },
                  );
                }
              }
            }),
          )
        ],
      );
    });
  }
}

class ViewModeBottomSheet extends StatelessWidget {
  const ViewModeBottomSheet({
    Key? key,
    required this.favMode,
    required this.changeFavMode,
    required this.gridMode,
    required this.changeGridMode,
  }) : super(key: key);
  final bool favMode;
  final Function(bool) changeFavMode;
  final bool gridMode;
  final Function(bool) changeGridMode;

  String mainText(bool fav) {
    return '表示設定';
  }

  String menuFavTitle(bool fav) {
    if (fav) {
      return '「すべて」表示に切り替え';
    } else {
      return '「お気に入り」表示に切り替え';
    }
  }

  String menuFavSubtitle(bool fav) {
    if (fav) {
      return 'すべてのポケモンが表示されます';
    } else {
      return 'お気に入りに登録したポケモンのみが表示されます';
    }
  }

  String menuGridTitle(bool grid) {
    if (grid) {
      return 'リスト表示に切り替え';
    } else {
      return 'グリッド表示に切り替え';
    }
  }

  String menuGridSubtitle(bool grid) {
    if (grid) {
      return 'ポケモンをグリッド表示します';
    } else {
      return 'ポケモンをリスト表示します';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Center(
          child: Column(
            children: [
              Container(
                height: 5,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).backgroundColor,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Text(
                  mainText(favMode),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.swap_horiz),
                title: Text(
                  menuFavTitle(favMode),
                ),
                subtitle: Text(
                  menuFavSubtitle(favMode),
                ),
                onTap: () {
                  changeFavMode(favMode);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.grid_3x3),
                title: Text(
                  menuGridTitle(gridMode),
                ),
                subtitle: Text(
                  menuGridSubtitle(gridMode),
                ),
                onTap: () {
                  changeGridMode(gridMode);
                  Navigator.pop(context);
                },
              ),
              OutlinedButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('キャンセル'),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
