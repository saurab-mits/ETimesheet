'use strict'

angular.module 'etimesheetApp'
.controller 'LoginDetailCtrl', ($scope, $stateParams, $meteor) ->
  $scope.login = $scope.$meteorObject Login, $stateParams.loginId
  $scope.$meteorSubscribe('login')
  
  $scope.save = () ->
    if $scope.form.$valid
      $scope.login.save().then(
        (numberOfDocs) ->
          console.log 'save successful, docs affected ', numberOfDocs
        (error) ->
          console.log 'save error ', error
      )
        
  $scope.reset = () ->
    $scope.login.reset()
