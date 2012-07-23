package com.googlecode.flexwebbeans.core.fields
{
	import com.googlecode.flexwebbeans.core.utils.XmlLoadUtil;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	
	import mx.collections.ICollectionView;
	import mx.controls.ComboBox;
	import mx.core.UIComponent;
	import mx.events.ListEvent;
	 
	
	
	/**
	 * 
	 * @author Jason Zhang
	 * 
	 */	
	public class ComboboxField extends BaseField
	{
		private static const PROP_KEYFIELD:String = "keyField";
		private static const PROP_LABELFIELD:String = "labelField";
		private static const PROP_DATAPROVIDER_XML_FILE:String = "dataProviderXmlFile";
		private static const PROP_DATAPROVIDER_KEY:String = "dataProviderKey";
		
		private var combobox:ComboBox;
		
		
		private var _dataProviderXmlFile:String;
		
		public function ComboboxField()
		{
			super();
		}
	 



		public function get dataProviderXmlFile():String
		{
			return _dataProviderXmlFile;
		}

		public function set dataProviderXmlFile(value:String):void
		{
			_dataProviderXmlFile = value;
			
			var loadBeanXmlSuccessFunc:Function = function parseDataProviderXml(event:Event):void
			{
				var loader:URLLoader = event.target as URLLoader;              
				if (loader != null)            
				{              
					var xml:XML = new XML(loader.data);
					combobox.dataProvider = xml.children();
					locateCombobox();
					
				}       
				
			};
			
			XmlLoadUtil.loadXML(value,loadBeanXmlSuccessFunc);
			
		}
		

		/**
		 * 
		 * 
		 */
		public function locateCombobox():void
		{
			var dataProvider:ICollectionView = combobox.dataProvider as ICollectionView;
			if (dataProvider)
			{
				var model:Object = getModel();
				for(var i:int =0; i<dataProvider.length-1; i++)
				{
					var curValue:Object =  dataProvider[i][elementMetaData[PROP_KEYFIELD]];
					if (model == curValue)
					{
						combobox.selectedIndex = i;
						return;
					}
				}
			}
		
		}

		
		override protected function createUIComponent():UIComponent
		{
			
		    combobox = new ComboBox();
			if (elementMetaData.viewOnly){
				combobox.enabled = false;
			}else{
				combobox.addEventListener(ListEvent.CHANGE,changeCombobox);
			}
			
			if (elementMetaData[PROP_DATAPROVIDER_KEY])
			{
				combobox.dataProvider = elementMetaData.getDataProvider(elementMetaData[PROP_DATAPROVIDER_KEY]);
				locateCombobox();
			}
			
			if (elementMetaData[PROP_DATAPROVIDER_XML_FILE]){
				dataProviderXmlFile = elementMetaData[PROP_DATAPROVIDER_XML_FILE];
			}
	
			return combobox;
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		private function changeCombobox(event:ListEvent):void{
			if (combobox.selectedItem!=null)
			{
				setModel(combobox.selectedItem[elementMetaData[PROP_KEYFIELD]]);
			}
			
		}

	}
}