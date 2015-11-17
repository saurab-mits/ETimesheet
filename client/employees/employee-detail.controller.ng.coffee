'use strict'

angular.module 'etimesheetApp'
.controller 'EmployeeDetailCtrl', ($scope, $stateParams, $meteor, $state, $mdToast) ->
  $scope.employee = $scope.$meteorObject Employees, $stateParams.employeeId
  $scope.$meteorSubscribe('employees')
  $scope.designations = $scope.$meteorCollection () ->
    Designations.find {}, {sort:$scope.getReactively('sort')}
  $scope.$meteorSubscribe('designations')
 
  #$scope.set=(name)->
  #  $scope.employee.designation=name
   # console.log($scope.employee.designation)
  
  $scope.save = () ->
    
      $scope.employee.save().then(
        (numberOfDocs) ->
          console.log 'save successful, docs affected ', numberOfDocs
          $mdToast.show($mdToast.simple().content('Data Saved Sucessfully'))
          $state.go('emplst')

        (error) ->
          console.log 'save error ', error
      )
        
  $scope.reset = () ->
    $scope.employee.reset()
    $mdToast.show($mdToast.simple().content('Form reset Sucessfully'))
