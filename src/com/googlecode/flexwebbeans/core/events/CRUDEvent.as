package com.googlecode.flexwebbeans.core.events
{
	
	public class CRUDEvent extends ActionEvent
	{
		public static const DELETE:String ="onDelete";
		public static const UPDATE:String ="onUpdate";
		public static const CREATE:String ="onCreate";
		
		public function CRUDEvent(type:String, data:Object ,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data,bubbles, cancelable);
		}


	}
}