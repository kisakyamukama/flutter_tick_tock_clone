import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_video_stream_tiktok_clone/ui/screens/tick_tock_video_gesture.dart';
import 'package:flutter_video_stream_tiktok_clone/ui/utility/styles/style.dart';


class TikTokVideoPage extends StatelessWidget {
  final Widget video;
  final double aspectRatio;
  final String tag;
  final double bottomPadding;

  final Widget rightButtonColumn;
  final Widget userInfoWidget;

  final bool hidePauseIcon;

  final Function onAddFavorite;
  final Function onSingleTap;

  const TikTokVideoPage({
    Key key,
    this.bottomPadding: 16,
    this.tag,
    this.rightButtonColumn,
    this.userInfoWidget,
    this.onAddFavorite,
    this.onSingleTap,
    this.video,
    this.aspectRatio: 9 / 16.0,
    this.hidePauseIcon: false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // 右边的按钮列表
    Widget rightButtons = rightButtonColumn ?? Container();
    // 用户信息
    Widget userInfo = userInfoWidget ??
        VideoUserInfo(
          bottomPadding: bottomPadding,
        );
    // 视频加载的动画
    // Widget videoLoading = VideoLoadingPlaceHolder(tag: tag);
    // 视频播放页
    Widget videoContainer = TikTokVideoGesture(
      onAddFavorite: onAddFavorite,
      onSingleTap: onSingleTap,
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black,
            alignment: Alignment.center,
            child: Container(
              child: AspectRatio(
                aspectRatio: aspectRatio,
                child: video,
              ),
            ),
          ),
         
        ],
      ),
    );
    Widget body = Container(
      child: Stack(
        children: <Widget>[
          videoContainer,
          Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.bottomRight,
            child: rightButtons,
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.bottomLeft,
            child: userInfo,
          ),
        ],
      ),
    );
    return body;
  }
}

class VideoLoadingPlaceHolder extends StatelessWidget {
  const VideoLoadingPlaceHolder({
    Key key,
    @required this.tag,
  }) : super(key: key);

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: <Color>[
            Colors.blue,
            Colors.green,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SpinKitWave(
            size: 36,
            color: Colors.white.withOpacity(0.3),
          ),
          Container(
            padding: EdgeInsets.all(50),
            child: Text(
              tag ?? 'Unknown Tag',
              style: StandardTextStyle.normalWithOpacity,
            ),
          ),
        ],
      ),
    );
  }
}

class VideoUserInfo extends StatelessWidget {
  final String desc;
  // final Function onGoodGift;
  const VideoUserInfo({
    Key key,
    @required this.bottomPadding,
    // @required this.onGoodGift,
    this.desc,
  }) : super(key: key);

  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12,
        bottom: bottomPadding,
      ),
      margin: EdgeInsets.only(right: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Boring life',
            style: StandardTextStyle.big,
          ),
          Container(height: 6),
          Text(
            desc ?? 'The life of the rich is so unpretentious and boring',
            style: StandardTextStyle.normal,
          ),
          Container(height: 6),
          Row(
            children: <Widget>[
              Icon(Icons.music_note, size: 14),
              Expanded(
                child: Text(
                  'Original sound',
                  maxLines: 9,
                  style: StandardTextStyle.normal,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
