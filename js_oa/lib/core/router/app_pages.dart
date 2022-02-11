import 'package:get/get.dart';
import 'package:js_oa/core/router/unknown_page.dart';
import 'package:js_oa/pages/common/no_access_photos_page.dart';
import 'package:js_oa/pages/contacts/contact_detail_page.dart';
import 'package:js_oa/pages/contacts/contact_page.dart';
import 'package:js_oa/pages/contacts/search/search_page.dart';
import 'package:js_oa/pages/login/login_header.dart';
import 'package:js_oa/pages/login/user_protocol/privacy_policy_page.dart';
import 'package:js_oa/pages/login/user_protocol/user_protocol_page.dart';
import 'package:js_oa/pages/main/main_page.dart';
import 'package:js_oa/pages/message/conversation_detail/c2c_conversation/c2c_conversation_page.dart';
import 'package:js_oa/pages/message/conversation_detail/rtc_calling/calling_widget.dart';
import 'package:js_oa/pages/message/message_page.dart';
import 'package:js_oa/pages/message/system_message/sys_msg_detail_widget.dart';
import 'package:js_oa/pages/mine/mine_header.dart';
import 'package:js_oa/pages/mine/mine_person_info/change_name_page.dart';
import 'package:js_oa/pages/workspace/approve/approve_page.dart';
import 'package:js_oa/pages/workspace/approve/comments/approve_opinion_page.dart';
import 'package:js_oa/pages/workspace/approve/invoice_detail/invoice_detail_page.dart';
import 'package:js_oa/pages/workspace/approve/payment_detail/payment_detail_page.dart';
import 'package:js_oa/pages/workspace/finance/contract/contract_page.dart';
import 'package:js_oa/pages/workspace/finance/contract/invoiceFlow/contract_invoice_flow.dart';
import 'package:js_oa/pages/workspace/finance/contract/invoiceFlow/contract_invoice_history.dart';
import 'package:js_oa/pages/workspace/finance/contract/paymentFlow/contract_payment_flow.dart';
import 'package:js_oa/pages/workspace/finance/contract/paymentFlow/contract_payment_history.dart';
import 'package:js_oa/pages/workspace/no_business_record/non_business_record_page.dart';
import 'package:js_oa/pages/workspace/workspace_page.dart';

part "app_routes.dart";

///
/// Author       : zhongaidong
/// Date         : 2021-07-23 15:00:37
/// Description  :
///

abstract class AppPages {
  static final List<GetPage> pages = [
    // ------------------- Main -------------------
    GetPage(name: AppRoutes.initial, page: () => LoginVCPage()),
    // GetPage(name: AppRoutes.initial, page: () => MainPage()),
    GetPage(name: AppRoutes.main, page: () => MainPage()),

    // ------------------- Message -------------------
    GetPage(name: AppRoutes.message, page: () => MessagePage()),
    GetPage(name: AppRoutes.conversation, page: () => C2cConversationPage()),
    GetPage(
        name: AppRoutes.systemMessage, page: () => SystemMessageDetailPage()),
    GetPage(
        name: AppRoutes.calling,
        page: () => CallingPage(),
        transition: Transition.upToDown),
    // ------------------- Workspace -------------------
    GetPage(name: AppRoutes.work, page: () => WorkspacePage()),
    GetPage(name: AppRoutes.approve, page: () => ApprovePage()),
    GetPage(name: AppRoutes.contract, page: () => ContractPage()),
    GetPage(
        name: AppRoutes.noBusinessRecordPage,
        page: () => NonBusinessRecordPage()),
    GetPage(name: AppRoutes.invoiceDetail, page: () => InvoiceDetailPage()),
    GetPage(name: AppRoutes.paymentDetail, page: () => PaymentDetailPage()),
    GetPage(name: AppRoutes.approveOpinion, page: () => ApproveOpinionPage()),
    GetPage(
        name: AppRoutes.contractInvoiceFlow, page: () => ContractInvoiceFlow()),
    GetPage(
        name: AppRoutes.contractPaymentFlow, page: () => ContractPaymentFlow()),
    GetPage(
        name: AppRoutes.contractPaymentHistory,
        page: () => ContractPaymentHistory()),
    GetPage(
        name: AppRoutes.contractInvoiceHistory,
        page: () => ContractInvoiceHistory()),

    // ------------------- Contacts -------------------
    GetPage(name: AppRoutes.contacts, page: () => ContactPage()),
    GetPage(name: AppRoutes.contactsDetail, page: () => ContactDetailPage()),
    GetPage(name: AppRoutes.contactsSearch, page: () => SearchPage()),

    // ------------------- Mine -------------------
    GetPage(name: AppRoutes.mine, page: () => MinePage()),
    GetPage(name: AppRoutes.personInfo, page: () => PersonInfoPage()),
    GetPage(name: AppRoutes.pwdChange, page: () => PwdChangePage()),
    GetPage(name: AppRoutes.pwdPhoneChange, page: () => PwdPhoneChangePage()),
    GetPage(
        name: AppRoutes.pwdPhoneChangeSetting,
        page: () => PwdPhoneChangeSettingPage()),

    GetPage(name: AppRoutes.phoneChange, page: () => PhoneModifyPage()),
    GetPage(
        name: AppRoutes.phoneVerification,
        page: () => CommonVerificationPage()),
    GetPage(name: AppRoutes.bindMail, page: () => BindEmailPage()),
    GetPage(name: AppRoutes.changeName, page: () => ChangeNamePage()),

    // ------------------- Login -------------------
    GetPage(name: AppRoutes.loginAccount, page: () => LoginAccountPage()),
    GetPage(name: AppRoutes.forgetPwd, page: () => ForgetPwdPage()),
    GetPage(name: AppRoutes.forgetPwdModify, page: () => ForgetPwdModifyPage()),
    GetPage(name: AppRoutes.userProtocol, page: () => UserProtocolPage()),
    GetPage(name: AppRoutes.privacyPolicy, page: () => PrivacyPolicyPage()),

    // ------------------- Common -------------------
    GetPage(
      name: AppRoutes.noAccessPhotos,
      page: () => NoAccessPhotosPage(),
      fullscreenDialog: true,
    ),

    // ------------------- Unknown -------------------
    GetPage(name: AppRoutes.unknown, page: () => UnknownPage()),
  ];
}
