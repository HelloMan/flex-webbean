package com.googlecode.flexwebbeans.core.events
{
	import flash.events.Event;

	public class LoadXmlCompleteEvent extends Event
	{
		public static const COMPLETE:String ="complete";
		
		public function LoadXmlCompleteEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}