'use strict'

angular.module 'etimesheetApp'
.controller 'LeaveRequestsListCtrl', ($scope, $meteor, $mdToast,$state) ->
  #$scope.myDate= new Date()
  $scope.page = 1
  $scope.perPage = 10
  $scope.sort = name : 1
  $scope.orderProperty = '1'
  $scope.turnon=1
  
  $scope.leaveRequests = $scope.$meteorCollection () ->
    LeaveRequests.find {}, {sort:$scope.getReactively('sort')}
   $scope.employee= $scope.$meteorCollection () ->
    Employees.find {'emailAddress.primary':$scope.currentUser.emails[0].address}, {sort:$scope.getReactively('sort')}

  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('employees')
    $scope.$meteorSubscribe('leaveRequests', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('search')).then () ->
      $scope.leaveRequestsCount = $scope.$meteorObject Counts, 'numberOfLeaveRequests', false
 
    

  $meteor.session 'leaveRequestsCounter'
  .bind $scope, 'page'
  
  console.log($scope.currentUser.emails[0].address)
   
  $scope.save = () ->
      $scope.newLeaveRequest.askDate=new Date()
      $scope.newLeaveRequest.startDate= $scope.startDate
      $scope.newLeaveRequest.endDate= $scope.endDate
      $scope.newLeaveRequest.user= $scope.employee[0].name
      $scope.newLeaveRequest.approvedBy=""
      $scope.newLeaveRequest.approvedDate=""
      $scope.leaveRequests.save $scope.newLeaveRequest
      $mdToast.show($mdToast.simple().content('Data Saved Sucessfully'))
      $scope.newLeaveRequest = undefined
      $state.go 'udashboard'
  $scope.list=(name)->
    $scope.turnon=0
    $scope.leaves = $scope.$meteorCollection () ->
      LeaveRequests.find {'user':name}, {sort:$scope.getReactively('sort')}

    $scope.$meteorSubscribe('leaveRequests')
    

  $scope.cancel=()->
    $scope.turnon=1

      
  $scope.remove = (leaveRequest) ->
    $scope.leaveRequests.remove leaveRequest
    $mdToast.show($mdToast.simple().content('Data removed Sucessfully'))
    
  $scope.pageChanged = (newPage) ->
    $scope.page = newPage
    
  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name: parseInt($scope.orderProperty)
