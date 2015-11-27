'use strict'

angular.module 'etimesheetApp'
.controller 'EmployeeDetailCtrl', ($scope, $stateParams, $meteor, $state, $mdToast) ->
  $scope.employee = $scope.$meteorObject Employees, $stateParams.employeeId
  $scope.$meteorSubscribe('employees')
  $scope.designations = $scope.$meteorCollection () ->
    Designations.find {}, {sort:$scope.getReactively('sort')}
  $scope.$meteorSubscribe('designations')
  $scope.departments = $scope.$meteorCollection () ->
    Departments.find {}, {sort:$scope.getReactively('sort')}
  $scope.$meteorSubscribe('departments')
 
  
  
  $scope.save = () ->
    console.log($scope.employee.department)
    $scope.employee.save().then(
      (numberOfDocs) ->
        console.log 'save successful, docs affected ', numberOfDocs
        $mdToast.show($mdToast.simple().content('Data Saved Sucessfully'))
        $state.go('emplst')

      (error) ->
        console.log 'save error ', error
        $state.go('emplst')
    )
        
  $scope.reset = () ->
    $scope.employee.reset()
    $mdToast.show($mdToast.simple().content('Form reset Sucessfully'))
