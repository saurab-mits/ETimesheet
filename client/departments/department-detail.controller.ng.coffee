'use strict'

angular.module 'etimesheetApp'
.controller 'DepartmentDetailCtrl', ($scope, $stateParams, $meteor) ->
  $scope.department = $scope.$meteorObject Departments, $stateParams.departmentId
  $scope.$meteorSubscribe('departments')
  
  $scope.save = () ->
    if $scope.form.$valid
      $scope.department.save().then(
        (numberOfDocs) ->
          console.log 'save successful, docs affected ', numberOfDocs
        (error) ->
          console.log 'save error ', error
      )
        
  $scope.reset = () ->
    $scope.department.reset()
