'use strict'

angular.module 'etimesheetApp'
.controller 'ProjectDetailCtrl', ($scope, $stateParams, $meteor) ->
  $scope.project = $scope.$meteorObject Projects, $stateParams.projectId
  $scope.$meteorSubscribe('projects')
  
  $scope.save = () ->
    if $scope.form.$valid
      $scope.project.save().then(
        (numberOfDocs) ->
          console.log 'save successful, docs affected ', numberOfDocs
        (error) ->
          console.log 'save error ', error
      )
        
  $scope.reset = () ->
    $scope.project.reset()
