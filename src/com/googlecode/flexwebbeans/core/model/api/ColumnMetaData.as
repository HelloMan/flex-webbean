package com.googlecode.flexwebbeans.core.model.api
{
	

	
	/**
	 * @author jason zhang
	 */
	public dynamic class ColumnMetaData extends MetaData
	{
		private var _name:String;
		
		private var _label:String;
		
		
		public function ColumnMetaData()
		{
			super();
		}


		public function get label():String
		{
			if (_label){
				return _label;
			}else{
				return _name;
			}
		}

		public function set label(value:String):void
		{
			_label = value;
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