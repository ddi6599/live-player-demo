/**
 * 最简单的基于ActionScript的RTMP播放器
 * Simplest AS3 RTMP Player
 *
 * 雷霄骅 Lei Xiaohua
 * leixiaohua1020@126.com
 * 中国传媒大学/数字电视技术
 * Communication University of China / Digital TV Technology
 * http://blog.csdn.net/leixiaohua1020
 *
 * 本程序使用ActionScript3语言完成，播放RTMP服务器上的流媒体
 * 是最简单的基于ActionScript3的播放器。
 *
 * This software is written in Actionscript3, it plays stream
 * on RTMP server
 * It's the simplest RTMP player based on ActionScript3.
 *
 */
package {
  import flash.display.Sprite;
  import flash.net.NetConnection;
  import flash.events.NetStatusEvent;
  import flash.events.AsyncErrorEvent;
  import flash.net.NetStream;
  import flash.media.Video;

  public class simplest_as3_rtmp_player extends Sprite {
    var nc: NetConnection;
    var ns: NetStream;
    var video: Video;

    public function simplest_as3_rtmp_player() {
      nc = new NetConnection();
      nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
      nc.connect("rtmp://47.75.41.87/live");
    }

    private function netStatusHandler(event: NetStatusEvent): void {
      trace("event.info.level: " + event.info.level + "\n", "event.info.code: " + event.info.code);
      switch (event.info.code) {
        case "NetConnection.Connect.Success":
          doVideo(nc);
          break;
        case "NetConnection.Connect.Failed":
          break;
        case "NetConnection.Connect.Rejected":
          break;
        case "NetStream.Play.Stop":
          break;
        case "NetStream.Play.StreamNotFound":
          break;
      }
    }

    // play a recorded stream on the server
    private function doVideo(nc: NetConnection): void {
      ns = new NetStream(nc);
      ns.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);

      video = new Video(640, 480);
      video.attachNetStream(ns);

      ns.play("slot01");
      addChild(video);
    }
  }
}
