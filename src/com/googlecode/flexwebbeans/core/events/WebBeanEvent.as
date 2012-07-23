package com.googlecode.flexwebbeans.core.events
{
	import flash.events.Event;
	
	public class WebBeanEvent extends Event
	{
		private var _model:Object;
		
		public function WebBeanEvent(type:String,model:Object =null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this._model = model;
		}

		public function get model():Object
		{
			return _model;
		}

		public function set model(value:Object):void
		{
			_model = value;
		}

	}
}