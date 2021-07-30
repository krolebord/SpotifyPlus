import 'package:spotify_plus/services/service_exception.dart';

class PlaybackServiceException extends ServiceException {
  const PlaybackServiceException(String errorMessage) : super(errorMessage);
}
