'use strict';

//var appControllers = angular.module('appControllers', []);

appControllers.controller('LockerCtrl', ['$scope', 'lockerService','$window',
 function($scope, lockerService,$window){
	$scope.editorOptions = {
		lineNumbers: true,
		readOnly: false,
		autofocus: true,
		mode: 'javascript'
	};
  $scope.bulk_input = "";
  $scope.lockers = [];
  $scope.error_msg = "";
  
  $scope.init=function(){
    lockerService.loadLockers(function(success,data){
      if(success){
        $scope.lockers = data;
        $scope.buildLockerText();
      } else {
        console.log("error getting lockers from server");
      }
    });
  };
  /************************
  Create lockers based off this text
  *************************/
  $scope.saveLockers = function(){
    lockerService.saveLockers($scope.lockers, function(success,data){
      if(success){
    		$window.location.href = config.base+"/lockers/";
      } else {
        $scope.error_msg = "Locker "+data["locker"]["number"]+" error: "+data["errors"] ;
        console.log("Error adding lockers");
      }
    });
  };
  /*************************
  Create the input text based off the existing locker setup
  **************************/
  $scope.buildLockerText = function(){
    var bulk_txt = "";
    for(var i=0;i<$scope.lockers.length;i++){
      bulk_txt += $scope.lockers[i].to_string()
      if(i!=$scope.lockers.length-1)
        bulk_txt+="\n";
    }
    $scope.bulk_input=bulk_txt;
  };
  
  /************************
  Parse the input text to extract locker information
  ************************/
  $scope.parseInput = function(){
    var lockers = [];
    
    $scope.error_msg = "";
    //iterate over input to build list of lockers
    var lines = $scope.bulk_input.split('\n');
    for (var i=0; i<lines.length;i++){
      var elems = lines[i].split(',');
      if(elems.length!=5 || elems[2]==''){
        $scope.error_msg = "Syntax error on line "+(i+1);
        return;
      }
      var locker = new Locker();
      locker.number = elems[0];
      locker.serial = elems[1];
      locker.combo = elems[2];
      locker.kit = elems[3];
      locker.notes = elems[4];
      lockers.push(locker);
    }
    $scope.lockers = lockers;
  };
  
}]);