'use strict'

angular.module('etimesheetApp')
.controller 'ResetCtrl', ($scope, $meteor,$stateParams, $state, $mdToast) ->
    $scope.employee = $scope.$meteorObject Employees, $stateParams.employeeId
    $scope.$meteorSubscribe('employees')
    $scope.error = ''
    console.log($scope.employee.emailAddress.primary)

    $scope.reset = () ->
      Accounts.forgotPassword({email:$scope.employee.emailAddress.primary}, (error)->
        if(error)
          console.log(error)
        else
          console.log('success')
          $mdToast.show($mdToast.simple().content('Notification has been sent to users email....!'))
          $state.go 'emplst'
          
     )