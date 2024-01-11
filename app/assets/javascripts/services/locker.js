'use strict';
var serviceModule = angular.module('myApp.services.lockers',[]);

serviceModule.
  factory('lockerService', ['$http',function($http){
  	
  	var lockerService = {
  		loadLockers: function(callback){
				var lockers=[];
				$http({
					"method": "GET",
					"url": config.base+'/lockers.json',
				}).success(function(data){
						for(var i=0;i<data.length;i++){
							data[i]=new Locker(data[i]);
						}
						callback(true,data);
				}).error(function(data){
					callback(false,data);
				});
			},
      saveLockers: function(lockers, callback){
				$http({
					"method": "POST",
					"url": config.base+'/lockers/bulk_update.json',
					"headers": {'X-CSRF-Token': $("meta[name=csrf-token]").first().attr("content")},
					"data": {"lockers": lockers}
				}).success(function(data){
            for(var i=0;i<data.length;i++){
              data[i]=new Locker(data[i]);
            }
            callback(true, data);
				}).error(function(data){
					callback(false, data);
				});
      }
		};
		return lockerService;
  }]);
  