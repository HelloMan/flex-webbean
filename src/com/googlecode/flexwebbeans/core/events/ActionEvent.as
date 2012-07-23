package com.googlecode.flexwebbeans.core.events
{
	import flash.events.Event;
	
	public class ActionEvent extends WebBeanEvent
	{
		public function ActionEvent(type:String,model:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, model,bubbles, cancelable);
		}
	}
}