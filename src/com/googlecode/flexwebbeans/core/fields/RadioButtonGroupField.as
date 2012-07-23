package com.googlecode.flexwebbeans.core.fields
{
	import com.googlecode.flexwebbeans.core.model.api.ElementMetaData;
	import com.googlecode.flexwebbeans.core.utils.XmlLoadUtil;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	
	import mx.collections.ICollectionView;
	import mx.collections.XMLListCollection;
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.core.UIComponent;
	import mx.events.ItemClickEvent;
	
	import spark.components.RadioButton;
	import spark.components.RadioButtonGroup;
	
	
	/**
	 * 
	 * @author Administrator
	 * 
	 */
	public class RadioButtonGroupField extends BaseField
	{
		private var radioBtnGroup:RadioButtonGroup ;
		
		private static const PROP_DATAPROVIDER_KEY:String = "dataProviderKey";
		private static const PROP_DATAPROVIDER_XML:String = "dataProviderXML";
		private static const PROP_LABELFIELD:String = "labelField";
		private static const PROP_VALUEFIELD:String = "valueField";
		
		public function RadioButtonGroupField()
		{
			super();
			populateUIProp = false;
		}
		
		private function createRadioButton(dataProvider:ICollectionView,hbox:HBox):void
		{
			for each(var obj:Object in dataProvider)
			{
				var radioBtn:RadioButton = new RadioButton();
				radioBtn.enabled = !elementMetaData.viewOnly;
				radioBtn.group = radioBtnGroup;
				radioBtn.label = obj[elementMetaData[PROP_LABELFIELD]];
				radioBtn.value = obj[elementMetaData[PROP_VALUEFIELD]];
				hbox.addElement(radioBtn);
			}
		}
		
		private function loadDataProvider(hbox:HBox):void
		{
			if (elementMetaData[PROP_DATAPROVIDER_KEY]){
				var dataProvider:ICollectionView = elementMetaData.getDataProvider(elementMetaData[PROP_DATAPROVIDER_KEY]);
				createRadioButton(dataProvider,hbox);
			}
			if (elementMetaData[PROP_DATAPROVIDER_XML]){
				
				var loadBeanXmlSuccessFunc:Function = function parseDataProviderXml(event:Event):void
				{
					var loader:URLLoader = event.target as URLLoader;              
					if (loader != null)            
					{              
						var xml:XML = new XML(loader.data);
						createRadioButton(new XMLListCollection(xml.children()),hbox);
					}       
					
				};
				
				XmlLoadUtil.loadXML(elementMetaData[PROP_DATAPROVIDER_XML],loadBeanXmlSuccessFunc);
				
			}
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		override protected function createUIComponent():UIComponent
		{
			radioBtnGroup = new RadioButtonGroup();
			var hbox:HBox = new HBox();
			loadDataProvider(hbox);
			radioBtnGroup.addEventListener(ItemClickEvent.ITEM_CLICK,itemClick);
			radioBtnGroup.selectedValue = getModel();
			
			return hbox;
		}
		
		private function itemClick(event:ItemClickEvent):void
		{
			setModel(radioBtnGroup.selectedValue);
		}
	}
}