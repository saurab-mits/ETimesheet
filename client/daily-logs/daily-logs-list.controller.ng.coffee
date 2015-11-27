'use strict'

angular.module 'etimesheetApp'
.controller 'DailyLogsListCtrl', ($scope, $meteor, $stateParams, $rootScope, $mdToast,$state) ->
  $scope.page = 1
  $scope.perPage = 10
  $scope.pname=""
  $scope.sort = name : 1
  $scope.orderProperty = '1'
  $scope.Times=[
  #   {pname:'Etimesheet', Timetaken:2, description:'Task1'}
  ]

  
  
  
  $scope.dailyLogs = $scope.$meteorCollection () ->
    DailyLogs.find {}, {sort:$scope.getReactively('sort')}
  $scope.projects = $scope.$meteorCollection () ->
    Projects.find {'member':$rootScope.currentUser.emails[0].address}, {sort:$scope.getReactively('sort')}
  $scope.employee= $scope.$meteorCollection () ->
    Employees.find {'emailAddress.primary':$scope.currentUser.emails[0].address}, {sort:$scope.getReactively('sort')}

  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('employees')
    $scope.$meteorSubscribe('dailyLogs', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('search')).then () ->
      $scope.dailyLogsCount = $scope.$meteorObject Counts, 'numberOfDailyLogs', false
    $scope.$meteorSubscribe('projects')

  $meteor.session 'dailyLogsCounter'
  .bind $scope, 'page'

  
  $scope.set=(name)->
    $scope.pname=name
    console.log($scope.pname)
  $scope.addRow=()->
    $scope.Times.push({pname:$scope.newDailyLog.name,Timetaken:$scope.newDailyLog.Timetaken,description:$scope.newDailyLog.Description,user:$scope.employee[0].name,createdDate:new Date()})
    $scope.newDailyLog = ''
    
  
  

    
  $scope.save = () ->
    #$scope.Times.push({user:$rootScope.currentUser._id,createdDate:new Date()})
    $scope.newDailyLog=$scope.Times
    #$scope.newDailyLog.user=$rootScope.currentUser._id
    #$scope.newDailyLog.createdDate=new Date()
    $scope.dailyLogs.save $scope.newDailyLog
    $scope.newDailyLog = ''
    $scope.Times= ''
    $mdToast.show($mdToast.simple().content('Datas Saved succesfully...!'))
    #$window.location.reload()
    $scope.Times=[]
    $scope.newDailyLog= undefined
    $state.go 'udashboard'
      
  #$scope.remove = (time) ->
  #  $scope.Times.remove time
    
  $scope.pageChanged = (newPage) ->
    $scope.page = newPage
    
  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name: parseInt($scope.orderProperty)
