'use strict'

angular.module 'etimesheetApp'
.controller 'ProjectsListCtrl', ($scope, $meteor, $mdToast) ->
  $scope.page = 1
  $scope.perPage = 5
  $scope.IsVisible=false
  $scope.sort = name : 1
  $scope.orderProperty = '1'
  $scope.member=[]
  $scope.idx=0
  
  
  $scope.projects = $scope.$meteorCollection () ->
    Projects.find {}, {sort:$scope.getReactively('sort')}
  $scope.employees = $scope.$meteorCollection () ->
    Employees.find {}, {sort:$scope.getReactively('sort')}
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('projects', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('search')).then () ->
      $scope.projectsCount = $scope.$meteorObject Counts, 'numberOfProjects', false
    $scope.$meteorSubscribe('employees')
  #if ($scope.employees.deleted==1)
   # $scope.member= true 
        
  $meteor.session 'projectsCounter'
  .bind $scope, 'page'
  $scope.cancel=()->
    $scope.IsVisible = false
  $scope.ShowHide=()->
    $scope.IsVisible = true

  $scope.shouldBeDisabled= (employee)->
   # console.log(employee+" "+"Here at disabled function ")
    if(employee== '1')
      return true
    else
      return false
  
    
  $scope.exist=(emp,list)->
    return list.$indexOf(emp) > -1
  $scope.toggle =  (emp, list)->
    $scope.idx = list.indexOf(emp)
    if($scope.idx > -1)
     list.splice($scope.idx, 1)
    else
     list.push(emp)

    
  $scope.save = () ->
    console.log($scope.member)
    $scope.newProject.deleted='0'
    $scope.newProject.isActive='1'
    $scope.newProject.member=$scope.member
    $scope.projects.save $scope.newProject
    $scope.newProject = undefined
    document.getElementById("form").reset()
    $mdToast.show($mdToast.simple().content('Project Saved Sucessfully'))
    $scope.IsVisible = false

      
  $scope.remove = (project) ->
    $scope.projects.remove project
    $mdToast.show($mdToast.simple().content('Project Removed Sucessfully'))
    
  $scope.pageChanged = (newPage) ->
    $scope.page = newPage
    
  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name: parseInt($scope.orderProperty)
