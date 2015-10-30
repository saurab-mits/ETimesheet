'use strict'

angular.module 'etimesheetApp'
.controller 'LeaveRequestDetailCtrl', ($scope, $stateParams, $meteor) ->
  $scope.leaveRequest = $scope.$meteorObject LeaveRequests, $stateParams.leaveRequestId
  $scope.$meteorSubscribe('leaveRequests')
  
  $scope.save = () ->
    if $scope.form.$valid
      $scope.leaveRequest.save().then(
        (numberOfDocs) ->
          console.log 'save successful, docs affected ', numberOfDocs
        (error) ->
          console.log 'save error ', error
      )
        
  $scope.reset = () ->
    $scope.leaveRequest.reset()
