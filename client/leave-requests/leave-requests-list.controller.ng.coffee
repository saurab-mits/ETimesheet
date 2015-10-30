'use strict'

angular.module 'etimesheetApp'
.controller 'LeaveRequestsListCtrl', ($scope, $meteor) ->
  #$scope.myDate= new Date()
  $scope.page = 1
  $scope.perPage = 3
  $scope.sort = name_sort : 1
  $scope.orderProperty = '1'
  
  $scope.leaveRequests = $scope.$meteorCollection () ->
    LeaveRequests.find {}, {sort:$scope.getReactively('sort')}
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('leaveRequests', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('search')).then () ->
      $scope.leaveRequestsCount = $scope.$meteorObject Counts, 'numberOfLeaveRequests', false

  $meteor.session 'leaveRequestsCounter'
  .bind $scope, 'page'
    
  $scope.save = () ->
      $scope.newLeaveRequest.askDate=new Date()
      $scope.newLeaveRequest.startDate= $scope.startDate
      $scope.newLeaveRequest.endDate= $scope.endDate
      $scope.newLeaveRequest.user= $scope.currentUser.emails[0].address
      $scope.leaveRequests.save $scope.newLeaveRequest
      $scope.newLeaveRequest = undefined
      console.log($scope.currentUser.emails[0].address)
      console.log($scope.startDate)
      console.log($scope.endDate)


      
  $scope.remove = (leaveRequest) ->
    $scope.leaveRequests.remove leaveRequest
    
  $scope.pageChanged = (newPage) ->
    $scope.page = newPage
    
  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name_sort: parseInt($scope.orderProperty)
