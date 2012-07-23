package com.googlecode.flexwebbeans.core.containers
{
	import mx.validators.Validator;

	public interface IBeanValidator
	{
	
		function registerValidator(value:Validator):void;
	}
}