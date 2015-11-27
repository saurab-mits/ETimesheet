'use strict'

angular.module 'etimesheetApp'
.controller 'DailyLogDetailCtrl', ($scope, $stateParams, $meteor, $state, $mdToast) ->
  $scope.page = 1
  $scope.perPage = 10
  $scope.sort = name : 1
  $scope.orderProperty = '1'

  $scope.dailyLogs = $scope.$meteorCollection () ->
    DailyLogs.find {}, {sort:$scope.getReactively('sort')}
  $scope.employees = $scope.$meteorCollection () ->
    Employees.find {'deleted':'0'}
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('dailyLogs', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('search')).then () ->
      $scope.dailyLogsCount = $scope.$meteorObject Counts, 'numberOfDailyLogs', false
  $scope.projects = $scope.$meteorCollection () ->
    Projects.find {}, {sort:$scope.getReactively('sort')}
  $scope.$meteorSubscribe('projects')
  $scope.$meteorSubscribe('employees')
  $scope.users = $scope.$meteorCollection () ->
    Meteor.users.find {}

  $scope.set=(name)->
    $scope.pname=name
    console.log($scope.pname)
  $scope.find=(use,project,from,to)->
    $scope.dailyLogs = $scope.$meteorCollection () ->
      DailyLogs.find {'pname':project, 'user':use, 'createdDate':{$gt:from, $lt:to}}, {sort:$scope.getReactively('sort')}
    console.log($scope.dailyLogs)
  
  $scope.save = () ->
    $scope.dailyLog.pname=$scope.pname
    $scope.dailyLog.save().then(
      (numberOfDocs) ->
        console.log 'save successful, docs affected ', numberOfDocs
        $mdToast.show($mdToast.simple().content('Data Saved Sucessfully'))
        $state.go 'addTimesheet'
      (error) ->
        console.log 'save error ', error
    )
        
  $scope.reset = () ->
    $scope.dailyLog.reset()
    $mdToast.show($mdToast.simple().content('form reset Sucessfully'))
