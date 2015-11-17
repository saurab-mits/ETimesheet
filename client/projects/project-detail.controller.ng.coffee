'use strict'

angular.module 'etimesheetApp'
.controller 'ProjectDetailCtrl', ($scope, $stateParams, $meteor, $mdToast, $state) ->
  $scope.projects = $scope.$meteorCollection () ->
    Projects.find {}, {sort:$scope.getReactively('sort')}
  $scope.project = $scope.$meteorObject Projects, $stateParams.projectId
  $scope.$meteorSubscribe('projects')
  $scope.employees = $scope.$meteorCollection () ->
    Employees.find {}, {sort:$scope.getReactively('sort')}
  $scope.$meteorSubscribe('employees')
  $scope.member=$scope.project.member
  $scope.idx=0
  console.log($scope.member)

  $scope.shouldBeDisabled= (employee)->
   # console.log(employee+" "+"Here at disabled function ")
    if(employee== '1')
      return true
    else
      return false

  $scope.exists=(emp,list)->
    return list.indexOf(emp) > -1
    
  $scope.toggle =  (emp, list)->
    $scope.idx = list.indexOf(emp)
    if($scope.idx > -1)
     list.splice($scope.idx, 1)
    else
     list.push(emp)
  
  $scope.save = () ->
    if $scope.form.$valid
      $scope.project.save().then(
        (numberOfDocs) ->
          console.log 'save successful, docs affected ', numberOfDocs
          $state.go 'projects-list'
          $mdToast.show($mdToast.simple().content('Project Saved Sucessfully'))
        (error) ->
          console.log 'save error ', error
      )
        
  $scope.reset = () ->
    $scope.project.reset()
    $mdToast.show($mdToast.simple().content('Project Reset Sucessfully'))
