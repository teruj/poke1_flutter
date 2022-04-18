import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './settings.dart';
import './poke_list_item.dart';
import 'poke_list.dart';

import './models/theme_mode.dart';
import './models/pokemon.dart';

import './models/favorite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences pref = await SharedPreferences.getInstance();
  final themeModeNotifier = ThemeModeNotifier(pref);
  final pokemonNotifier = PokemonNotifier();
  final favoriteNotifier = FavoriteNotifier();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeModeNotifier>(
            create: (context) => themeModeNotifier),
        ChangeNotifierProvider<PokemonNotifier>(
            create: (context) => pokemonNotifier),
        ChangeNotifierProvider<FavoriteNotifier>(
            create: (context) => favoriteNotifier),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ThemeMode themeMode = ThemeMode.system;

  // @override
  // void initState() {
  //   super.initState();
  //   loadThemeMode().then((val) => setState(() => themeMode = val));
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeNotifier>(builder: (context, mode, child) {
      return MaterialApp(
        title: 'Pokemon Flutter',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: mode.mode,
        home: const TopPage(),
      );
    });
  }
}

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  int currentbnb = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: currentbnb == 0 ? const PokeList() : const Settings(),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => {
                setState(
                  () => currentbnb = index,
                )
              },
          currentIndex: currentbnb,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'setting'),
          ]),
    );
  }
}
