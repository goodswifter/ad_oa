///
/// Author       : zhongaidong
/// Date         : 2021-07-23 15:00:21
/// Description  :
///

part of "app_pages.dart";

abstract class AppRoutes {
  // ------------------- Main -------------------
  static const initial = '/';
  static const main = "/main";

  // ------------------- Message -------------------
  static const message = '/message';
  static const conversation = "/message/conversation";
  static const calling = "/message/conversation/call";
  static const systemMessage = "/message/system";
  // ------------------- Workspace -------------------
  static const work = '/work';
  static const approve = '/approve';
  static const contract = '/contract';
  static const noBusinessRecordPage = '/no_business_record_page';
  static const invoiceDetail = '/invoice_detail';
  static const paymentDetail = '/payment_detail';
  static const approveOpinion = '/approve_opinion';
  static const contractInvoiceFlow = '/contractInvoiceFlow';
  static const contractPaymentFlow = '/contractPaymentFlow';
  static const contractPaymentHistory = '/contractPaymentHistory';
  static const contractInvoiceHistory = '/contractInvoiceHistory';
  // ------------------- Contacts -------------------
  static const contacts = '/contacts';
  static const contactsDetail = "/contacts/detail";
  static const contactsSearch = "/contacts/search";

  // ------------------- Mine -------------------
  static const mine = '/mine';
  static const personInfo = '/mine/person_info';
  static const pwdChange = '/mine/pwd_change';
  static const pwdPhoneChange = '/mine/pwd_phone_change';
  static const pwdPhoneChangeSetting = '/mine/pwd_phone_change_setting';
  static const phoneChange = '/mine/phone_change';
  static const phoneVerification = '/mine/phone_verification';
  static const bindMail = '/mine/bind_mail';
  static const changeName = '/mine/change_name';

  // ------------------- Login -------------------
  static const loginAccount = '/login/login_account';
  static const forgetPwd = '/login/forget_pwd';
  static const forgetPwdModify = '/login/forget_pwd_modify';
  static const userProtocol = '/login/user_protocol';
  static const privacyPolicy = '/login/privacy_policy';

  // ------------------- Common -------------------
  static const noAccessPhotos = '/no_access_photos';

  // ------------------- Unknown -------------------
  static const unknown = '/unknown';

  // ------------------- Test -------------------
  static const test = '/test';
}
