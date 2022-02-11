/*
 * 工作台api
 */
final String apiWorkSpaceGetMyLayout = "/api/WorkSpace/GetMyLayout"; //获取工作台主页数据

final String apiOldContractGetPagedList =
    "/api/OldContract/GetPagedList"; //分页获取当前登录用户的合同列表

final String apiWorkflowGetPagedList =
    "/api/Workflow/GetPagedList"; //获取工作台待处理信息、已处理、已发起、退款

final String apiWorkflowGetById = "/api/Workflow/GetById"; //根据workflowId获取详情

final String apiInvoiceGetPagedList = "/api/Invoice/GetPagedList"; //获取用户开票记录

final String apiPaymentGetPagedList = "/api/Payment/GetPagedList"; //获取用户缴费记录

final String apiWorkflowApproveWork = "/api/Workflow/ApproveWork"; //审批一个工作

final String apiWorkflowGetWorkflowDefinition =
    "/api/Workflow/GetWorkflowDefinition"; //获取工作流模板

final String apiInvoiceCreate = "/api/Invoice/Create"; //创建开票流程

final String apiPaymentCreate = "/api/Payment/Create"; //创建缴费流程

final String apiPaymentChannelGetList = "/api/PaymentChannel/GetList"; //获取缴费方式

final String apiOldContractGetContractIntro =
    "/api/OldContract/GetContractIntro"; //获取指定id的合同概要

final String apiPaymentGetPagedListForContract =
    "/api/Payment/GetPagedListForContract"; //获取合同的缴费历史

final String apiInvoiceGetPagedListForContract =
    "/api/Invoice/GetPagedListForContract"; //获取合同的开票历史

final String apiClientGetOldClientById =
    "/api/Client/GetOldClientById"; //获取用户发票信息
// final String apiClientGetOldClientById =
//     "/api/Client/GetInvoiceById"; //获取用户发票信息

final String apiInvoiceTypeGetList = "/api/InvoiceType/GetList"; //获取发票类型

final String apiWorkflowRevokeWork = "/api/Workflow/RevokeWork"; //撤销一个工作流

final String apiNonBusinessContractCreate =
    "/api/NonBusinessContract/Create"; //新增非业务合同备案

 