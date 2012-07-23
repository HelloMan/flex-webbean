package com.googlecode.flexwebbeans.core.fields
{
	import com.googlecode.flexwebbeans.core.model.api.ElementMetaData;
	import com.googlecode.flexwebbeans.core.utils.XmlLoadUtil;
	import com.hillelcoren.components.AutoComplete;
	import com.hillelcoren.utils.ArrayCollectionUtils;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;
	import mx.collections.XMLListCollection;
	import mx.controls.Label;
	import mx.core.UIComponent;
	
	public class AutoCompleteField extends BaseField
	{
		private static const PROP_DATAPROVIDER_KEY:String = "dataProviderKey";
		private static const PROP_DATAPROVIDER_XML:String = "dataProviderXml";
		
		private 	var autoComplete:AutoComplete ;
		
		public function AutoCompleteField()
		{
			super();
		}
		
		override protected function createUIComponent():UIComponent
		{
			if (elementMetaData.viewOnly){
				var label:Label = new Label();
				if (getModel()){
					label.text = getModel().toString();
				}else{
					label.text = "";
				}
				return label;
			}else{
				
			    autoComplete = new AutoComplete();
				
				setDataProvider();
				
				autoComplete.searchText = getModel().toString();
				autoComplete.search();
			}
		
				
			return new UIComponent();
		}
		
		private function setDataProvider():void
		{
			if (elementMetaData[PROP_DATAPROVIDER_KEY])
			{
				var dataProvider:XMLListCollection = elementMetaData.getDataProvider(elementMetaData[PROP_DATAPROVIDER_KEY]);
				autoComplete.dataProvider = dataProvider;
			}
			
			if (elementMetaData[PROP_DATAPROVIDER_XML])
			{
				
				var loadBeanXmlSuccessFunc:Function = function parseDataProviderXml(event:Event):void
				{
					var loader:URLLoader = event.target as URLLoader;              
					if (loader != null)            
					{              
						var xml:XML = new XML(loader.data);
						autoComplete.dataProvider = new XMLListCollection(xml.children());
						
					}       
					
				};
				
				XmlLoadUtil.loadXML(elementMetaData[PROP_DATAPROVIDER_XML],loadBeanXmlSuccessFunc);
				
			}
		}

		
		
	}
}