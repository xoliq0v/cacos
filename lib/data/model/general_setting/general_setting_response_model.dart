class GeneralSettingResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  GeneralSettingResponseModel(
      {this.remark, this.status, this.message, this.data});

  GeneralSettingResponseModel.fromJson(Map<String, dynamic> json) {
    remark = json['remark'];
    status = json['status'];
    message =
    json['message'] != null ?  Message.fromJson(json['message']) : null;
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['remark'] = remark;
    data['status'] = status;
    if (message != null) {
      data['message'] = message!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Message {
  String? success;

  Message({this.success});

  Message.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['success'] = success;
    return data;
  }
}

class Data {
  GeneralSetting? generalSetting;
  String? logo;
  String? favicon;

  Data({this.generalSetting, this.logo, this.favicon});

  Data.fromJson(Map<String, dynamic> json) {
    generalSetting = json['general_setting'] != null
        ?  GeneralSetting.fromJson(json['general_setting'])
        : null;
    logo = json['logo'];
    favicon = json['favicon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (generalSetting != null) {
      data['general_setting'] = generalSetting!.toJson();
    }
    data['logo'] = logo;
    data['favicon'] = favicon;
    return data;
  }
}

class GeneralSetting {
  int? id;
  String? siteName;
  String? emailFrom;
  String? baseColor;
  String? secondaryColor;
  GlobalShortcodes? globalShortcodes;
  String? securePassword;
  String? multiLanguage;
  String? systemCustomized;
  String? webUrl;
  String? pn;
  PushConfig? pushConfig;
  String? onBoardScreen;
  String? activeOnBoardScreen;
  String? activeLoader;
  String? qrCode;
  String? rating;
  String? ba_ads;
  String? intAds;
  String? popAds;
  String? link;
  String? linkShareStatus;
  String? aboutDescription;
  String? navStatus;
  String? dwStatus;
  String? createdAt;
  String? updatedAt;

  GeneralSetting(
      {this.id,
        this.siteName,
        this.emailFrom,
        this.baseColor,
        this.secondaryColor,
        this.globalShortcodes,
        this.securePassword,
        this.multiLanguage,
        this.systemCustomized,
        this.webUrl,
        this.pn,
        this.pushConfig,
        this.onBoardScreen,
        this.activeOnBoardScreen,
        this.activeLoader,
        this.qrCode,
        this.rating,
        this.ba_ads,
        this.intAds,
        this.popAds,
        this.link,
        this.linkShareStatus,
        this.aboutDescription,
        this.navStatus,
        this.dwStatus,
        this.createdAt,
        this.updatedAt});

  GeneralSetting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteName = json['site_name'] != null? json['site_name'].toString(): "";
    emailFrom = json['email_from'] != null? json['email_from'].toString(): "";
    baseColor = json['base_color'] != null? json['base_color'].toString(): "";
    secondaryColor = json['secondary_color'] != null? json['secondary_color'].toString(): "";
    securePassword = json['secure_password'] != null? json['secure_password'].toString(): "";
    multiLanguage = json['multi_language'] != null? json['multi_language'].toString(): "";
    systemCustomized = json['system_customized'] != null? json['system_customized'].toString(): "";
    webUrl = json['web_url'] != null? json['web_url'].toString(): "";
    pn = json['pn'] != null? json['pn'].toString(): "";
    onBoardScreen = json['on_board_screen'] != null? json['on_board_screen'].toString(): "";
    activeOnBoardScreen = json['active_on_board_screen'] != null? json['active_on_board_screen'].toString(): "";
    activeLoader = json['active_loader'] != null? json['active_loader'].toString(): "";
    qrCode = json['qr_code'] != null? json['qr_code'].toString(): "";
    rating = json['rating'] != null? json['rating'].toString(): "";
    ba_ads = json['ba_ads'] != null? json['ba_ads'].toString(): "";
    intAds = json['int_ads'] != null? json['int_ads'].toString(): "";
    popAds = json['pop_ads'] != null? json['pop_ads'].toString(): "";
    link = json['link'] != null? json['link'].toString(): "";
    linkShareStatus = json['link_share_status'] != null? json['link_share_status'].toString(): "";
    aboutDescription = json['about_description'] != null? json['about_description'].toString(): "";
    navStatus = json['nav_status'] != null? json['nav_status'].toString(): "";
    dwStatus = json['dw_status'] != null? json['dw_status'].toString(): "";
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['site_name'] = siteName;
    data['email_from'] = emailFrom;
    data['base_color'] = baseColor;
    data['secondary_color'] = secondaryColor;
    if (globalShortcodes != null) {
      data['global_shortcodes'] = globalShortcodes!.toJson();
    }
    data['secure_password'] = securePassword;
    data['multi_language'] = multiLanguage;
    data['system_customized'] = systemCustomized;
    data['web_url'] = webUrl;
    data['pn'] = pn;
    if (pushConfig != null) {
      data['push_config'] = pushConfig!.toJson();
    }
    data['on_board_screen'] = onBoardScreen;
    data['active_on_board_screen'] = activeOnBoardScreen;
    data['active_loader'] = activeLoader;
    data['qr_code'] = qrCode;
    data['rating'] = rating;
    data['ba_ads'] = ba_ads;
    data['int_ads'] = intAds;
    data['pop_ads'] = popAds;
    data['link'] = link;
    data['link_share_status'] = linkShareStatus;
    data['about_description'] = aboutDescription;
    data['nav_status'] = navStatus;
    data['dw_status'] = dwStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class GlobalShortcodes {
  String? siteName;

  GlobalShortcodes({this.siteName});

  GlobalShortcodes.fromJson(Map<String, dynamic> json) {
    siteName = json['site_name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['site_name'] = siteName;
    return data;
  }
}

class PushConfig {
  String? serverKey;
  String? apiKey;
  String? authDomain;
  String? projectId;
  String? storageBucket;
  String? messagingSenderId;
  String? appId;
  String? measurementId;

  PushConfig(
      {this.serverKey,
        this.apiKey,
        this.authDomain,
        this.projectId,
        this.storageBucket,
        this.messagingSenderId,
        this.appId,
        this.measurementId});

  PushConfig.fromJson(Map<String, dynamic> json) {
    serverKey = json['serverKey'] != null? json['serverKey'].toString(): "";
    apiKey = json['apiKey'] != null? json['apiKey'].toString(): "";
    authDomain = json['authDomain'] != null? json['authDomain'].toString(): "";
    projectId = json['projectId'] != null? json['projectId'].toString(): "";
    storageBucket = json['storageBucket'] != null? json['storageBucket'].toString(): "";
    messagingSenderId = json['messagingSenderId'] != null? json['messagingSenderId'].toString(): "";
    appId = json['appId'] != null? json['appId'].toString(): "";
    measurementId = json['measurementId'] != null? json['measurementId'].toString(): "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serverKey'] = serverKey;
    data['apiKey'] = apiKey;
    data['authDomain'] = authDomain;
    data['projectId'] = projectId;
    data['storageBucket'] = storageBucket;
    data['messagingSenderId'] =messagingSenderId;
    data['appId'] =appId;
    data['measurementId'] = measurementId;
    return data;
  }
}
