import 'package:sprint/features/home/domain/entities/home_content.dart';
import 'package:sprint/features/home/domain/home_session.dart';

/// Source of Home content. Implementations live in the data layer.
abstract interface class HomeRepository {
  Future<HomeContent> load(HomeSession session);
}
