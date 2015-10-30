'use strict'

angular.module 'etimesheetApp'
.controller 'udashboardctrl', ($scope, $meteor, $state) ->


  $scope.addTime = () ->
    $state.go('addTimesheet')

  $scope.addLeave = () ->
    $state.go('leaveRequests-list')