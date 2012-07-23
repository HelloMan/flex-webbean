package com.googlecode.flexwebbeans.core.model.api
{
	import com.googlecode.flexwebbeans.core.utils.MyObjectUtil;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;

	
	/**
	 * @author jason zhang
	 */
	public  class ListBeanMetaData extends BaseBeanMetaData
	{
		
		/**
		 * GridColumns which is used when bean is Array or Collection 
		 */ 
		private var _gridColumns:IList = new ArrayCollection();
		
		
		public function ListBeanMetaData(bean:Object)
		{
			super(bean);
			
		
		}


		public function set gridColumns(value:IList):void
		{
			_gridColumns = value;
		}



		public function get gridColumns():IList
		{
			return _gridColumns;
		}

		
		
		/**
		 * parse bean xml and create BeanMetaData
		 * @param beanXML
		 * 
		 */		
		override public function parseBeanXml(beanXML:XML):void
		{
			parseGridColumns(beanXML);
			super.parseBeanXml(beanXML);
		}
		
		
		
		
		private function parseGridColumns(beanXML:XML):void
		{
			var order:int = 0;
			if (beanXML && beanXML.gridcolumns  )
			{
				for each(var propXml:XML in beanXML.gridcolumns.children())
				{
					var elementMetaData:ElementMetaData = new ElementMetaData();
					elementMetaData.order = order++;
					MyObjectUtil.setDynamicPropByXml(elementMetaData,propXml);
					_gridColumns.addItem(elementMetaData);
				}
			}
		}
		

	}
}