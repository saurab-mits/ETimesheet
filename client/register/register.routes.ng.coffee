'use strict'

angular.module 'etimesheetApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'register',
    url: '/register'
    templateUrl: 'client/register/register.view.html'
    controller: 'RegisterCtrl'
  .state 'reset',
    url: '/reset/:employeeAdd'
    templateUrl: 'client/register/reset.view.html'
    controller: 'ResetCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireUser()
      ]
