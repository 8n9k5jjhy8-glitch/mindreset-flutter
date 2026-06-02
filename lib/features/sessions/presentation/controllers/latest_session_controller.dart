import 'dart:async';

import '../../data/sessions_repository.dart';
import '../../models/mind_session.dart';

class LatestSessionController {
  LatestSessionController({SessionsRepository? repository})
    : _repository = repository ?? SessionsRepository();

  final SessionsRepository _repository;

  final StreamController<MindSession?> _controller =
      StreamController<MindSession?>.broadcast();

  StreamSubscription<MindSession?>? _subscription;

  Stream<MindSession?> get stream => _controller.stream;

  Future<MindSession?> loadOnce() async {
    final latest = await _repository.fetchLatestSession();
    if (!_controller.isClosed) {
      _controller.add(latest);
    }
    return latest;
  }

  void startWatching() {
    _subscription?.cancel();
    _subscription = _repository.watchLatestSession().listen(
      (session) {
        if (!_controller.isClosed) {
          _controller.add(session);
        }
      },
      onError: (Object error, StackTrace stackTrace) {
        if (!_controller.isClosed) {
          _controller.addError(error, stackTrace);
        }
      },
    );
  }

  Future<void> refresh() async {
    await loadOnce();
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
    await _controller.close();
  }
}
