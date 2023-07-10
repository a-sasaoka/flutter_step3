enum TimeToLive {
  tenMinutes,
  oneHour,
  oneDay,
  oneWeek,
  oneMonth,
  oneYear,
}

extension TimeToLiveExt on TimeToLive {
  String get name {
    switch (this) {
      case TimeToLive.tenMinutes:
        return '10分';
      case TimeToLive.oneHour:
        return '1時間';
      case TimeToLive.oneDay:
        return '1日';
      case TimeToLive.oneWeek:
        return '1週';
      case TimeToLive.oneMonth:
        return '1ヶ月';
      case TimeToLive.oneYear:
        return '1年';
    }
  }
}
