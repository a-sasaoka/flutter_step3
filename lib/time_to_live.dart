// ignore_for_file: constant_identifier_names

enum TimeToLive {
  TEN_MINUTES,
  ONE_HOUR,
  ONE_DAY,
  ONE_WEEK,
  ONE_MONTH,
  ONE_YEAR,
}

extension TimeToLiveExt on TimeToLive {
  String get name {
    switch (this) {
      case TimeToLive.TEN_MINUTES:
        return '10分';
      case TimeToLive.ONE_HOUR:
        return '1時間';
      case TimeToLive.ONE_DAY:
        return '1日';
      case TimeToLive.ONE_WEEK:
        return '1週';
      case TimeToLive.ONE_MONTH:
        return '1ヶ月';
      case TimeToLive.ONE_YEAR:
        return '1年';
    }
  }
}
