package com.googlecode.flexwebbeans.core.model.api
{ 
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.collections.IList;

	/**
	 * @author jason zhang
	 */
	public  class TabMetaData extends MetaData
	{
		
		private var _caption:String;
		
		private var _columns:int;
		
		private var _beanMetaData:BeanMetaData;
		
		private var _props:IList = new ArrayCollection();
		
		public function TabMetaData()
		{
			this.columns = 3;
		}

		public function get columns():int
		{
			return _columns;
		}

		public function set columns(value:int):void
		{
			_columns = value;
		}

		public function get beanMetaData():BeanMetaData
		{
			return _beanMetaData;
		}

		public function set beanMetaData(value:BeanMetaData):void
		{
			_beanMetaData = value;
		}

		public function get caption():String
		{
			return _caption;
		}

		public function set caption(value:String):void
		{
			_caption = value;
		}

		public function get props():IList
		{
			return _props;
		}

		public function set props(value:IList):void
		{
			_props = value;
		}

		

	}
}