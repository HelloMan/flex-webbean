package com.googlecode.flexwebbeans.core.model
{
	import com.googlecode.flexwebbeans.core.model.api.BeanMetaData;
	import com.googlecode.flexwebbeans.core.model.api.ListBeanMetaData;
	
	import mx.core.UIComponent;

	public class BeanMetaDataFactory
	{
		public static function createBeanMetaDataByXML(model:Object,beanXml:XML ,componentRegistry:ComponentRegistry = null,parent:BeanMetaData=null,uiComponent:UIComponent = null):BeanMetaData
		{
			var beanMetaData:BeanMetaData =  new BeanMetaData(model,componentRegistry);
			beanMetaData.parent = parent;
			beanMetaData.viewOnly = parent.viewOnly;
			beanMetaData.component = uiComponent;
			beanMetaData.parseBeanXml(beanXml);
			return beanMetaData;
		}
		

		
		public static function createListBeanMetaDataByXML(model:Object,beanXml:XML ,parent:BeanMetaData,uiComponent:UIComponent = null):ListBeanMetaData
		{
			var listBeanMetaData:ListBeanMetaData =  new ListBeanMetaData(model);
			listBeanMetaData.parent = parent;
			listBeanMetaData.component = uiComponent;
			listBeanMetaData.parseBeanXml(beanXml);
			return listBeanMetaData;
		}
		
		public static function createBeanMetaDataByXMLFile(model:Object,beanXmlFile:String,componentRegistry:ComponentRegistry = null):BeanMetaData
		{
			var beanMetaData:BeanMetaData = new BeanMetaData(model,componentRegistry);
			beanMetaData.loadBeanXml(beanXmlFile);
			return beanMetaData;
		}
		
		
		public static function createListBeanMetaDataByXMLFile(bean:Object,beanXmlFile:String):ListBeanMetaData
		{
			var listBeanMetaData:ListBeanMetaData = new ListBeanMetaData(bean);
			listBeanMetaData.loadBeanXml(beanXmlFile);
			return listBeanMetaData;
		}
		
		
	}
}