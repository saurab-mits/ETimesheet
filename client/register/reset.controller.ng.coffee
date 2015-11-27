'use strict'

angular.module('etimesheetApp')
.controller 'ResetCtrl', ($scope, $meteor,$stateParams, $state, $mdToast) ->
  $scope.email=$stateParams.employeeAdd
  console.log($scope.email)
  #$scope.user=Meteor.users.find({'emails.address':$scope.email}).fetch()
  #console.log($scope.user[0]._id)
  $scope.user=$scope.$meteorCollection () ->
    Meteor.users.find({'emails.address':$scope.email})
  #$scope.employee = $scope.$meteorObject Employees, $stateParams.employeeId
  #$scope.$meteorSubscribe('employees')
  #console.log($scope.employee)

  $scope.error = ''
  #console.log($scope.employee.emailAddress.primary)
  #$scope.users=$scope.$meteorCollection () ->
  # Meteor.users.find({'emails.address':$scope.employee.emailAddress.primary})
  #  Meteor.users.find({ 'emails': { $elemMatch: { 'address': $scope.employee.emailAddress.primary } } })
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('users')
  
  
   # $scope.users = Meteor.users.find({'emails.address':$scope.employee.emailAddress.primary});
  console.log($scope.user)
  #$scope.new = Meteor.users.find({'emails.address':$scope.email}).fetch()
  #console.log($scope.new[0])
  #console.log($scope.new[0]._id) 
  
  #console.log($scope.user[0]._id)
  #console.log($scope.users._id)
  #console.log($scope.users.emails.address)
  

  $scope.reset = () ->
    console.log($scope.user[0]._id)
    Meteor.call('resetpas',$scope.user[0]._id,$scope.newPlaintextPassword)
    console.log('success')
    $mdToast.show($mdToast.simple().content('Password has been reset for the user Successfully...!'))
    $state.go 'emplst'
        
  $scope.cancel=()->
    $state.go 'emplst'