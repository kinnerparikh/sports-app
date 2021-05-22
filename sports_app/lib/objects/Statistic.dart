class Statistic
{
  String _statistic;
  String _abbrev;
  String _name;

  Statistic(String name, String abbrev, String statistic)
  {
    this._name = name;
    this._statistic = statistic;
    this._abbrev = abbrev;
  }

  String get abbrev
  {
    return _abbrev;
  }
  String get statistic
  {
    return _statistic;
  }

  String get name
  {
    return _name;
  }
}