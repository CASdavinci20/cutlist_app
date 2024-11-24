import 'package:flutter/cupertino.dart';

import '../models/data_models.dart';

class AppBloc extends ChangeNotifier {
  String? _errorMsg, _successMsg;
  List _resources = [],
      _categories = [],
      _resourceTypes = [],
      _categoryResources = [],
      _searchResources = [],
      _myMesssages=[],
      _sentMessages=[],
      _publicResources=[],
      _createMessage =[],
      _allInstitute =[],
      _instituteFiles = [],
      _partners = [],
      _durations = [],
      _currencies = [],
      _withdrawalMethods = [],
      _cutCategories =[],
       _cutProject = [],
       _cutAllTask = [],
       _cutlistData = [],
       _cutList = [],
       
     
      
      _messages = DataModels.messages;
  bool _hasProjects = false,
      _hasTasks = false,
      _hasInvoices = false,
      _hasSearch = false,
      _hasPartners = false,
      _hasWithdrawMethods = false,
      _hasWithdrawals = false,
      _hasCategories = false;
  var _mapSuccess,
      _regIndividual = {},
       _resourcesOne={},
      _regBusiness = {},
      _cutCredit = {},
      _cutCreditPackage = {},
      _cutNotifications = {},
      
       
      _userDetails = {},
      _createResources ={},
      _appVersion = {};
     

  get myMessages => _myMesssages;
  get cutCategories => _cutCategories;
  get cutAllTask=> _cutAllTask;
  get cutlistData => _cutlistData;
  get cutNotifications => _cutNotifications;
  get cutList => _cutList;
  get cutCredit => _cutCredit;
  get cutCreditPackage => _cutCreditPackage;
  get cutProject => _cutProject;
  get mycreatedResources => _createResources;
  get sentMessages => _sentMessages;
  get publicResources => _publicResources;
  get resourcesOne => _resourcesOne;
  get allInstitute => _allInstitute;
  get instituteFiles => _instituteFiles;
  get createMessage => _createMessage;
  get appVersion => _appVersion;
  get messages => _messages;
  get durations => _durations;
  get currencies => _currencies;
  get hasProjects => _hasProjects;
  get hasTasks => _hasTasks;
  get hasInvoices => _hasInvoices;
  get hasSearch => _hasSearch;
  get hasPartners => _hasPartners;
  get hasWithdrawMethods => _hasWithdrawMethods;
  get hasWithdrawals => _hasWithdrawals;
  get hasCategories => _hasCategories;

  get regBusiness => _regBusiness;
  get regIndividual => _regIndividual;
  get errorMsg => _errorMsg;
  get successMsg => _successMsg;
  get mapSuccess => _mapSuccess;
  get userDetails => _userDetails;
  get resources => _resources;
  get categories => _categories;
  get resourceTypes => _resourceTypes;
  get categoryResources => _categoryResources;
  get searchResources => _searchResources;
  get partners => _partners;
  get withdrawalMethods => _withdrawalMethods;

  set myMessages(value) {
    _myMesssages = value;
    notifyListeners();
  }

  set cutNotifications(value){
    _cutNotifications = value;
    notifyListeners();
  }

  set cutCategories(value) {
    _cutCategories = value;
    notifyListeners();
  }

  set cutlistData(value){
    _cutlistData = value;
    notifyListeners();
  }

  set cutCreditPackage(value) {
    _cutCreditPackage = value;
    notifyListeners();
  }

  
  set cutCredit(value) {
    _cutCredit = value;
    notifyListeners();
  }

  set cutProject(value){
    _cutProject = value;
    notifyListeners();
  }

  set cutAllTask(value){
    _cutAllTask = value;
    notifyListeners();
  }

  set cutList(value){
    _cutList = value;
    notifyListeners();
  }

  set createMessage(value) {
    _createMessage = value;
    notifyListeners();
  }

   set mycreatedResources(value) {
    _createResources = value;
    notifyListeners();
  }

  set publicResources(value) {
    _publicResources = value;
    notifyListeners();
  }

   set instituteFiles(value) {
    _instituteFiles = value;
    notifyListeners();
  }

  set allInstitute(value) {
    _allInstitute = value;
    notifyListeners();
  }

  
  set resourcesOne(value) {
    _resourcesOne = value;
    notifyListeners();
  }

  set sentMessages(value) {
    _sentMessages = value;
    notifyListeners();
  }

  set appVersion(value) {
    _appVersion = value;
    notifyListeners();
  }

  set messages(value) {
    _messages = value;
    notifyListeners();
  }

  set durations(value) {
    _durations = value;
    notifyListeners();
  }

  set currencies(value) {
    _currencies = value;
    notifyListeners();
  }

  set hasCategories(value) {
    _hasCategories = value;
    notifyListeners();
  }

  set resources(value) {
    _resources = value;
    notifyListeners();
  }

  set hasProjects(value) {
    _hasProjects = value;
    notifyListeners();
  }

  set hasTasks(value) {
    _hasTasks = value;
    notifyListeners();
  }

  set hasInvoices(value) {
    _hasInvoices = value;
    notifyListeners();
  }

  set hasSearch(value) {
    _hasSearch = value;
    notifyListeners();
  }

  set hasPartners(value) {
    _hasPartners = value;
    notifyListeners();
  }

  set hasWithdrawMethods(value) {
    _hasWithdrawMethods = value;
    notifyListeners();
  }

  set hasWithdrawals(value) {
    _hasWithdrawals = value;
    notifyListeners();
  }

  set regBusiness(value) {
    _regBusiness = value;
    notifyListeners();
  }

  set regIndividual(value) {
    _regIndividual = value;
    notifyListeners();
  }

  set searchResources(value) {
    _searchResources = value;
    notifyListeners();
  }

  set partners(value) {
    _partners = value;
    notifyListeners();
  }

  set withdrawalMethods(value) {
    _withdrawalMethods = value;
    notifyListeners();
  }

  set categoryResources(value) {
    _categoryResources = value;
    notifyListeners();
  }

  set categories(value) {
    _categories = value;
    notifyListeners();
  }

  set resourceTypes(value) {
    _resourceTypes = value;
    notifyListeners();
  }

  set errorMsg(value) {
    _errorMsg = value;
    notifyListeners();
  }

  set successMsg(value) {
    _successMsg = value;
    notifyListeners();
  }

  set mapSuccess(value) {
    _mapSuccess = value;
    notifyListeners();
  }

  set userDetails(value) {
    _userDetails = value;
    notifyListeners();
  }
}
