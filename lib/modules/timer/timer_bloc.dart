import 'dart:async';
import 'package:minesweeper/utilities/string_helpers.dart';
import 'package:rxdart/rxdart.dart';

class TimerBloc {
  static String _emptyTime = '00:00';

  Stopwatch _watch = new Stopwatch();
  Timer _timer;

  startWatch() {
    if (!_watch.isRunning) {
      _watch.start();
      _timer =
          new Timer.periodic(new Duration(milliseconds: 1000), _updateTime);
    }
  }

  _updateTime(Timer timer) {
    if (_watch.isRunning) {
      final duration = Duration(milliseconds: _watch.elapsedMilliseconds);
      final String timeString = StringHelpers.durationToMMSS(duration);
      _timeController.sink.add(timeString);
    }
  }

  //Controllers
  final _timeController = BehaviorSubject<String>();

  //Streams
  Stream<String> get elapsedTime => _timeController.stream;

  dispose() {
    _timeController.close();
    _timer.cancel();
  }

  resetTimer() {
    _watch.reset();
    _timeController.add(_emptyTime);
  }

  stopTimer() {
    _watch?.stop();
    _timer?.cancel();
  }
}
