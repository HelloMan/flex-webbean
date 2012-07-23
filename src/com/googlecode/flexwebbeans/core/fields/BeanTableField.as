package com.googlecode.flexwebbeans.core.fields
{
	import com.googlecode.flexwebbeans.core.containers.BeanTableLayout;
	import com.googlecode.flexwebbeans.core.model.api.ElementMetaData;
	
	import mx.core.UIComponent;
	
	public class BeanTableField extends BaseField
	{
		public function BeanTableField()
		{
			super();
			populateUIProp = false;
		}
		
		override protected function createUIComponent():UIComponent
		{
			var beanlist:BeanTableLayout = new BeanTableLayout();
			beanlist.listBeanMetaData = elementMetaData.createListBeanMetaData(beanlist);
			return beanlist;
		}
		
		
	}
}