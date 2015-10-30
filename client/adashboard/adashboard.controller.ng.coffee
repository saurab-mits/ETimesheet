'use strict'

angular.module 'etimesheetApp'
.controller 'adashboardctrl', ($scope, $meteor, $state) ->


  $scope.manEmp = () ->
    $state.go('emplst')

  $scope.manOrg = () ->
    $state.go('organizations-list')
    
  $scope.manDep = () ->
    $state.go('departments-list')

  $scope.manDes = () ->
    $state.go('designations-list')
  $scope.view=()->
    $state.go('dailyLog-detail')