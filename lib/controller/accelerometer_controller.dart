import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';

/// Manages a subscription to accelerometer events.
///
/// [AccelSubscription] encapsulates the functionality for [start], [pause],
/// [resume], and [cancel] a subscription to accelerometer events, and
/// [getTargetXAxis] from these events.
class AccelSubscription {
  double _targetXAxis = 0;
  late StreamSubscription<AccelerometerEvent> _accelSubscription;

  void start() {
    var stream = accelerometerEventStream();
    _accelSubscription = stream.listen(
      (AccelerometerEvent event) {
        _targetXAxis = -event.x / 1;
      },
      onError: (error) {
        // Logic to handle error
        // Needed for Android in case sensor is not available
      },
      cancelOnError: true,
    );
  }

  void pause() {
    _accelSubscription.pause();
  }

  void resume() {
    _accelSubscription.resume();
  }

  void cancel() {
    _accelSubscription.cancel();
  }

  double get getTargetXAxis => _targetXAxis;
}
