import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:blog_frontend/bloc/findUserBloc.dart';
import 'package:blog_frontend/bloc/globalBloc.dart';
import 'package:blog_frontend/bloc/newsFeedBloc.dart';
import 'package:blog_frontend/bloc/startAppBloc.dart';
import 'package:blog_frontend/events/loginEvents.dart';
import 'package:blog_frontend/repository/internalRepository.dart';
import 'bloc/authBloc.dart';
import 'ui/screens/loadScreen.dart';
import 'package:flutter/material.dart';
import 'ui/screens/signin/signInScreen.dart';
import 'ui/screens/mainAppScreen.dart';

main() => runApp(SetupBlocProvider());

class SetupBlocProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
        theme: ThemeData(
//            primaryColorLight: const Color.fromARGB(255, 120, 0, 80),
            primaryColorLight: Colors.deepPurple,
            primaryColorDark: Colors.deepPurple,
//            buttonColor: Colors.pink[800],
            buttonColor: Colors.deepPurple[400],
            primaryColor: Colors.deepPurple,
            appBarTheme: AppBarTheme(
//              color: const Color.fromARGB(255, 120, 0, 80),
                color: Colors.teal[600])),
      ),
      blocs: [
        Bloc((inject) => AuthBloc()),
        Bloc((inject) => GlobalBloc()),
        Bloc((inject) => NewsFeedBloc()),
        Bloc((inject) => FindUserBloc())
      ],
      dependencies: [
        Dependency((i) => InternalRepository()),
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthBloc>(
      builder: (context, bloc) {
        return StreamBuilder<UiEventLogin>(
          stream: StartAppBloc(bloc).uiEvents,
          builder: (context, userSnapshot) {
            if (!userSnapshot.hasData)
              return LoadScreen();
            else {
              if (userSnapshot.data.runtimeType == UiEventNeedRegister)
                return SignInScreen();
              else if (userSnapshot.data.runtimeType ==
                  UiEventUserIsAuthenticated)
                return MainAppScreen();
              else
                return LoadScreen();
            }
          },
        );
      },
    );
  }
}

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoadScreen();
  }
}
