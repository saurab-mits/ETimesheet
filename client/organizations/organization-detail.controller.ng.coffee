'use strict'

angular.module 'etimesheetApp'
.controller 'OrganizationDetailCtrl', ($scope, $stateParams, $meteor) ->
  $scope.organization = $scope.$meteorObject Organizations, $stateParams.organizationId
  $scope.$meteorSubscribe('organizations')
  
  $scope.save = () ->
    $scope.organization.save().then(
      (numberOfDocs) ->
        console.log 'save successful, docs affected ', numberOfDocs
      (error) ->
        console.log 'save error ', error
    )
        
  $scope.reset = () ->
    $scope.organization.reset()
