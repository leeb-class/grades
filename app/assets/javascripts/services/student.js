'use strict';
var serviceModule = angular.module('myApp.services.students',[]);

serviceModule.
  factory('studentService', ['$http',function($http){
  	
  	var studentService = {
  		loadStudents: function(callback){
				var students=[];
				$http({
					"method": "GET",
					"url": config.base+'/students.json',
				}).success(function(data){
						for(var i=0;i<data.length;i++){
							data[i]=new Student(data[i]);
						}
						callback(true,data);
				}).error(function(data){
					callback(false,data);
				});
			},
      removeStudents: function(students, callback){
				$http({
					"method": "POST",
					"url": config.base+'/students/bulk_remove.json',
					"headers": {'X-CSRF-Token': $("meta[name=csrf-token]").first().attr("content")},
					"data": {"students": students}
				}).success(function(data){
            for(var i=0;i<data.length;i++){
              data[i]=new Student(data[i]);
            }
            callback(true, data);
				}).error(function(data){
					callback(false, data);
				});
      },
      addStudents: function(students, callback){
				$http({
					"method": "POST",
					"url": config.base+'/students/bulk_add.json',
					"headers": {'X-CSRF-Token': $("meta[name=csrf-token]").first().attr("content")},
					"data": {"students": students}
				}).success(function(data){
            for(var i=0;i<data.length;i++){
              data[i]=new Student(data[i]);
            }
            callback(true, data);
				}).error(function(data){
					callback(false, data);
				});
      }
		};
		return studentService;
  }]);
  