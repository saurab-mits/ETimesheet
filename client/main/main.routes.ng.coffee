'use strict'

angular.module 'etimesheetApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'main',
    url: '/'
    templateUrl: 'client/main/main.view.html'
    controller: 'LoginCtrl'
  .state 'verify',
    url: '/verify-email/:verifyEmailToken'
    templateUrl: 'client/main/verify.view.html'
    controller:($stateParams, $meteor)->
      console.log($stateParams)
      console.log($stateParams.verifyEmailToken)
      Meteor.call('verifyEmail',$stateParams.verifyEmailToken)
