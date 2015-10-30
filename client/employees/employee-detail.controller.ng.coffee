'use strict'

angular.module 'etimesheetApp'
.controller 'EmployeeDetailCtrl', ($scope, $stateParams, $meteor, $state) ->
  $scope.employee = $scope.$meteorObject Employees, $stateParams.employeeId
  $scope.$meteorSubscribe('employees')
  
  $scope.save = () ->
    
      $scope.employee.save().then(
        (numberOfDocs) ->
          console.log 'save successful, docs affected ', numberOfDocs
          $state.go('emplst')

        (error) ->
          console.log 'save error ', error
      )
        
  $scope.reset = () ->
    $scope.employee.reset()
