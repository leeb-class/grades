'use strict';

//var appControllers = angular.module('appControllers', []);

appControllers.controller('GradeCtrl', ['$scope', function($scope){
  //stub function to sum existing grade with text field edit
  $scope.sum = function(a,b){
    var x= a+parseFloat(b);
    if(isNaN(x)) //if the text field is empty or has invalid characters
      return a;
    //round to 1 decimal place
    x = Math.round( x * 100) / 100
    return x;
  }
}]);