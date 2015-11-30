'use strict'

angular.module('etimesheetApp')
.controller 'ResetCtrl', ($scope, $meteor,$stateParams, $state, $mdToast) ->
  $scope.email=$stateParams.employeeAdd
  $scope.user=$scope.$meteorCollection () ->
    Meteor.users.find({'emails.address':$scope.email})
  
  $scope.error = ''
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('users')
  
  
  console.log($scope.user)
  

  $scope.reset = () ->
    console.log($scope.user[0]._id)
    Meteor.call('resetpas',$scope.user[0]._id,$scope.newPlaintextPassword)
    console.log('success')
    $mdToast.show($mdToast.simple().content('Password has been reset for the user Successfully...!'))
    $state.go 'emplst'
        
  $scope.cancel=()->
    $state.go 'emplst'