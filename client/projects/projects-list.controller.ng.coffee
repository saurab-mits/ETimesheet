'use strict'

angular.module 'etimesheetApp'
.controller 'ProjectsListCtrl', ($scope, $meteor) ->
  $scope.page = 1
  $scope.perPage = 10
  $scope.sort = name_sort : 1
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

  $scope.shouldBeDisabled= (employee)->
   # console.log(employee+" "+"Here at disabled function ")
    if(employee== '1')
      return true
    else
      return false
  
    
  $scope.exist=(empid,list)->
    return list.indexOf(empid) > -1
  $scope.toggle =  (empid, list)->
    $scope.idx = list.indexOf(empid)
    if($scope.idx > -1)
     list.splice($scope.idx, 1)
    else
     list.push(empid)

    
  $scope.save = () ->
    console.log($scope.member)
    $scope.newProject.deleted='0'
    $scope.newProject.isActive='1'
    $scope.newProject.member=$scope.member
    $scope.projects.save $scope.newProject
    $scope.newProject = undefined
    document.getElementById("form").reset()
      
  $scope.remove = (project) ->
    $scope.projects.remove project
    
  $scope.pageChanged = (newPage) ->
    $scope.page = newPage
    
  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name_sort: parseInt($scope.orderProperty)
