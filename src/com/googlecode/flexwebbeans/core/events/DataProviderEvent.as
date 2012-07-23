package com.googlecode.flexwebbeans.core.events
{
	import flash.events.Event;
	
	public class DataProviderEvent extends Event
	{
		public function DataProviderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}