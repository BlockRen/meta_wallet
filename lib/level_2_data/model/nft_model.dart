
class NftModel {
  String? _url;
  String? _title;
  String? _time;

  NftModel(Map nftInfo) {
    _parseNftInfo(nftInfo);
  }

  String get url => _url ?? "unknown";
  String get title => _title ?? "unknown";
  String get time => _time ?? "unknown";

  void _parseNftInfo(Map nftInfo) {
    _url = nftInfo['imgurl'];
    _title = nftInfo['title'];
    _time = nftInfo['time'].toString();
  }
}