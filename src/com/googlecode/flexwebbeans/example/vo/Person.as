package com.googlecode.flexwebbeans.example.vo
{
	import mx.collections.ArrayCollection;
	import mx.collections.IList;

	[Inject]
	public class Person
	{
		
		private var _sex:Boolean;
		
		private var _name:String;
		
		private var _birthDay:Date;
		
		private var _age:int;
		
		private var _address:Address;
		
		private var _grilFriends:ArrayCollection;
		
		private var _childs:ArrayCollection ;
		
		private var _dogs:IList;
		
		private var _country:int;
		
		
		public function Person()
		{
		}

		public function get country():int
		{
			return _country;
		}

		public function set country(value:int):void
		{
			_country = value;
		}

		public function get dogs():IList
		{
			return _dogs;
		}

		public function set dogs(value:IList):void
		{
			_dogs = value;
		}

		public function get childs():ArrayCollection
		{
			return _childs;
		}

		public function set childs(value:ArrayCollection):void
		{
			_childs = value;
		}

		public function get grilFriends():ArrayCollection
		{
			return _grilFriends;
		}

		public function set grilFriends(value:ArrayCollection):void
		{
			_grilFriends = value;
		}

		public function get address():Address
		{
			return _address;
		}

		public function set address(value:Address):void
		{
			_address = value;
		}

		public function get age():int
		{
			return _age;
		}

		public function set age(value:int):void
		{
			_age = value;
		}

		public function get birthDay():Date
		{
			return _birthDay;
		}

		public function set birthDay(value:Date):void
		{
			_birthDay = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get sex():Boolean
		{
			return _sex;
		}

		public function set sex(value:Boolean):void
		{
			_sex = value;
		}

	}
}