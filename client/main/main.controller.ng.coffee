'use strict'

angular.module('etimesheetApp').controller 'LoginCtrl', ['$scope', '$meteor','$stateParams', '$state', ($scope, $meteor, $stateParams, $state) ->
  $scope.credentials =
    email: ''
    password: ''
  $scope.error = ''
  $scope.adminEmail="admin@etimesheet.com"
  $scope.adminPassword="admin123"
  $scope.user = $scope.$meteorCollection () ->
    Meteor.users.find {}
  
  $scope.login =() ->
    $meteor.loginWithPassword($scope.credentials.email, $scope.credentials.password).then (->
      #$scope.loginRole=$scope.user[0].Role
      $scope.emailToVerify = $scope.user[0].emails[0].address
      #console.log($scope.loginRole)
      console.log($scope.user[0].emails[0].address)
      console.log($scope.user[0].emails[0].verified)
      if($scope.credentials.email==$scope.adminEmail && $scope.credentials.password==$scope.adminPassword)
        $state.go 'adashboard'
      else
        $scope.verificationState = $scope.user[0].emails[0].verified
        if($scope.verificationState==false)
          Meteor.call('chkEmailVerify',Meteor.userId(),$scope.emailToVerify)
          $state.go('not-verified',{userId: Meteor.userId()})
        else
          $state.go 'udashboard'
    ), (err) ->
      $scope.error = 'Login error - ' + err
]