
import 'package:rxdart/rxdart.dart';

class DriverBehavourClass {
  // by default the state = 1 for first enter
  BehaviorSubject<int> _state = BehaviorSubject<int>()..value = 1;

  BehaviorSubject<int> get state => _state;

  void setState(int newState) {
    _state.value = newState;
  }


/*
States
0 => hide everything
1 => normal (no requests)
2 => ready to make request (the request is not applied yet (user dose not determine the destination yet))
3 => the user determinate the destination
4 => user canceled the request
5 => user waiting for response
6 => show ride options
7 => user got no responses
8 => show responses
9 => start trip and enable chatting with driver
10 => trip ended and start to rate driver
20 => trip started
21 => trip ended
*/
}

final driverStateBloc = DriverBehavourClass();