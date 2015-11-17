'use strict'

angular.module 'etimesheetApp'
.controller 'DepartmentDetailCtrl', ($state,$scope, $stateParams, $meteor, $mdToast) ->
  $scope.department = $scope.$meteorObject Departments, $stateParams.departmentId
  $scope.$meteorSubscribe('departments')
  
  $scope.save = () ->
    if $scope.form.$valid
      $scope.department.save().then(
        (numberOfDocs) ->
          console.log 'save successful, docs affected ', numberOfDocs
          $mdToast.show($mdToast.simple().content('Data Saved Sucessfully'))
          $state.go('departments-list')
        (error) ->
          console.log 'save error ', error
      )
        
  $scope.reset = () ->
    $scope.department.reset()
    $mdToast.show($mdToast.simple().content('Form reset Sucessfully'))
