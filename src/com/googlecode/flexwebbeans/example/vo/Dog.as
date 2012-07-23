package com.googlecode.flexwebbeans.example.vo
{
	public class Dog
	{
		private var _name:String;
		
		public function Dog()
		{
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

	}
}