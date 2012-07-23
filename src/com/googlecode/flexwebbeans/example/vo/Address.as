package com.googlecode.flexwebbeans.example.vo
{
	public class Address
	{
		
		private var _name:String;
		
		private var _detail:String;
		
		public function Address()
		{
		}

		public function get detail():String
		{
			return _detail;
		}

		public function set detail(value:String):void
		{
			_detail = value;
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