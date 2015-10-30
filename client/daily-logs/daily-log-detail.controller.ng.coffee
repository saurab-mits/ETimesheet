'use strict'

angular.module 'etimesheetApp'
.controller 'DailyLogDetailCtrl', ($scope, $stateParams, $meteor, $state) ->
  $scope.page = 1
  $scope.perPage = 5
  $scope.sort = name : 1
  $scope.orderProperty = '1'

  $scope.dailyLogs = $scope.$meteorCollection () ->
    DailyLogs.find {}, {sort:$scope.getReactively('sort')}
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
  $scope.users = $scope.$meteorCollection () ->
    Meteor.users.find {}

  $scope.set=(name)->
    $scope.pname=name
    console.log($scope.pname)
  
  $scope.save = () ->
    $scope.dailyLog.pname=$scope.pname
    $scope.dailyLog.save().then(
      (numberOfDocs) ->
        console.log 'save successful, docs affected ', numberOfDocs
        $state.go 'addTimesheet'
      (error) ->
        console.log 'save error ', error
    )
        
  $scope.reset = () ->
    $scope.dailyLog.reset()
