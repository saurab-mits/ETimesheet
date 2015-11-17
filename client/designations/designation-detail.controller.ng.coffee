'use strict'

angular.module 'etimesheetApp'
.controller 'DesignationDetailCtrl', ($scope, $stateParams, $meteor,$state , $mdToast) ->
  $scope.designation = $scope.$meteorObject Designations, $stateParams.designationId
  $scope.$meteorSubscribe('designations')
  
  $scope.save = () ->
    if $scope.form.$valid
      $scope.designation.save().then(
        (numberOfDocs) ->
          console.log 'save successful, docs affected ', numberOfDocs
          $mdToast.show($mdToast.simple().content('Data Saved Sucessfully'))
          $state.go('designations-list')
        (error) ->
          console.log 'save error ', error
      )
        
  $scope.reset = () ->
    $scope.designation.reset()
    $mdToast.show($mdToast.simple().content('Form reset Sucessfully'))
