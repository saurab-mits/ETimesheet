'use strict'

angular.module 'etimesheetApp'
.controller 'OrganizationDetailCtrl', ($scope, $stateParams,$state, $meteor, $mdToast) ->
  $scope.organization = $scope.$meteorObject Organizations, $stateParams.organizationId
  $scope.$meteorSubscribe('organizations')
  
  $scope.save = () ->
    $scope.organization.save().then(
      (numberOfDocs) ->
        console.log 'save successful, docs affected ', numberOfDocs
        $mdToast.show($mdToast.simple().content('Data Saved Sucessfully'))
        $state.go('organizations-list')
      (error) ->
        console.log 'save error ', error
    )
        
  $scope.reset = () ->
    $scope.organization.reset()
    $mdToast.show($mdToast.simple().content('form reset Sucessfully'))
