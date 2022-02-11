/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-01 17:37:47
 * @Description: IM 相关账号ID 密钥的信息
 * @FilePath: \js_oa\lib\im\tpns_config.dart
 * @LastEditTime: 2021-12-02 15:13:17
 */

class TpnsConfig {
  ///IM即时通讯 SDK ID和key
  static const int sdkappid = 1400589149;
  static const String key =
      '0b958fcac5233891a8537486d5dd62bf43521f486b6c106f1b604c8c24dd5227';

  ///上海服务器集群配置名
  static const String TPNS_DomainName = "tpns.sh.tencent.com";

  ///android端 tpns推送id和key
  static const String TPNS_Android_AccessID = "1580007867";
  static const String TPNS_Adnroid_AccessKey = "A85T3JSPF2SP";

  ///ios端 tpns推送id和key
  static const String TPNS_iOS_AccessID = "1680007866";
  static const String TPNS_iOS_AccessKey = "IU22723N9A2J";

  ///各手机厂商离线推送 IM ID
  static const double xiao_mi = 20682;
  static const double huawei = 20683;
  static const double vivo = 20685;
  static const double oppo = 20686;

  //*****************小米平台配置*******************/
  static const String xiaomiPushAppId = "2882303761520105631";
  static const String xiaomiPushAppKey = "5162010592631";
  //**************************************************** */

  //*****************oppo平台配置*******************/
  static const String oppoPushAppId = "30635951";
  static const String oppoPushAppkey = "27214b1983f34f7a8c699e7f5b85cb97";
  //**************************************************** */

  ///ios离线推送 dev和生产环境 推送ID
  static const double ios_dev = 30394;
  static const double ios_pr = 30395;
}
