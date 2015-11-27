'use strict'

angular.module 'etimesheetApp'
.controller 'LeaveRequestDetailCtrl', ($scope, $stateParams, $meteor, $rootScope) ->
  $scope.page = 1
  $scope.perPage = 5
  $scope.sort = name : 1
  $scope.orderProperty = '1'

  
  $scope.leaveRequests = $scope.$meteorCollection () ->
    LeaveRequests.find {}, {sort:$scope.getReactively('sort')}
  $scope.employees = $scope.$meteorCollection () ->
    Employees.find {'deleted':'0'}
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('leaveRequests', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('search')).then () ->
      $scope.leaveRequestsCount = $scope.$meteorObject Counts, 'numberOfLeaveRequests', false
  $scope.$meteorSubscribe('employees')

  $meteor.session 'leaveRequestsCounter'
  .bind $scope, 'page'
  $scope.find=(use)->
    $scope.leaveRequests = $scope.$meteorCollection () ->
      LeaveRequests.find {'user':use}, {sort:$scope.getReactively('sort')}

  $scope.check=(leaveId)->
    Meteor.call('update33',leaveId)
    
     
    

  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name: parseInt($scope.orderProperty)