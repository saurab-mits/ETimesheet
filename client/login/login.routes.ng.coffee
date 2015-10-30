'use strict'

angular.module 'etimesheetApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'login',
    url: '/login'
    templateUrl: 'client/login/login-list.view.html'
    controller: 'LoginListCtrl'
  .state 'login-detail',
    url: '/login/:loginId'
    templateUrl: 'client/login/login-detail.view.html'
    controller: 'LoginDetailCtrl'
  
