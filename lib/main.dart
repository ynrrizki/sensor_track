import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sensor_track/presentation/blocs/item/item_bloc.dart';
import 'package:sensor_track/data/repositories/item_repository.dart';
import 'package:sensor_track/routes/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting("id_ID", null).then(
    (onValue) => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ItemRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ItemBloc(
              itemRepository: context.read<ItemRepository>(),
            )..add(LoadItem()),
          ),
        ],
        child: MaterialApp(
          title: 'Sensor Track',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: router.onRoute,
        ),
      ),
    );
  }
}
