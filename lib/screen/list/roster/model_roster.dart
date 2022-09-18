import 'package:budget/model/roster.dart';

class ModelRoster {
  ModelRoster(this._roster);
  final Roster _roster;

  String get title => _roster.name;
  Roster get roster => _roster;
}
