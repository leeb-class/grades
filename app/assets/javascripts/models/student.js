'use strict';
/**************
 * Student
 * 
 * Encapsulates the student server model on the client
 * Server populated parameters:
 * 	--local to the object--
 * 	id
 * 	first_name
 * 	last_name
 *  athena
 * 	--dynamically inserted by the server--
 *  none
 * 
 * Client populated parameters:
 * none
 *
 */
function Student(obj){

	obj = typeof obj == "undefined"?{}:obj;
	if(obj==null)
		obj = {}
		
	this.id = obj.id;
	this.first_name = obj.first_name;
	this.last_name = obj.last_name;
	this.athena = obj.athena;
}
