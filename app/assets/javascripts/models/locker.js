'use strict';
/**************
 * Locker
 * 
 * Encapsulates the locker server model on the client
 * Server populated parameters:
 * 	--local to the object--
 * 	id
 * 	number
 * 	serial
 *  combo
 *  notes
 *  kit
 * 	--dynamically inserted by the server--
 *  none
 * 
 * Client populated parameters:
 * none
 *
 */
function Locker(obj){

	obj = typeof obj == "undefined"?{}:obj;
	if(obj==null)
		obj = {}
		
	this.id = obj.id;
	this.serial = obj.serial;
	this.combo = obj.combo;
	this.number = obj.number;
  this.notes = obj.notes;
  this.kit = obj.kit;
  
}

Locker.prototype.to_string=function(){
  return this.number+", "+this.serial+", "+this.combo+", "+this.kit+", "+this.notes;
};