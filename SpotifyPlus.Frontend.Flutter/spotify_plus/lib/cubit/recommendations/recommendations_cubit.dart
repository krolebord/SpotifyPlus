import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'recommendations_state.dart';

class RecommendationsCubit extends Cubit<RecommendationsState> {
  RecommendationsCubit() : super(RecommendationsInitial());
}
