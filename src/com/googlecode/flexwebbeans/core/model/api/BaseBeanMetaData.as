package com.googlecode.flexwebbeans.core.model.api
{
	import com.googlecode.flexwebbeans.core.containers.IBeanModel;
	import com.googlecode.flexwebbeans.core.events.LoadXmlCompleteEvent;
	import com.googlecode.flexwebbeans.core.model.ComponentRegistry;
	import com.googlecode.flexwebbeans.core.utils.MyClassUtil;
	import com.googlecode.flexwebbeans.core.utils.MyObjectUtil;
	import com.googlecode.flexwebbeans.core.utils.XmlLoadUtil;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.collections.IList;
	import mx.core.UIComponent;
	import mx.utils.ObjectProxy;
	import mx.utils.ObjectUtil;

	
	/**
	 * @author jason zhang
	 */
	public  class BaseBeanMetaData extends MetaData
	{
		
		public static const PARSEXMLCOMPLETE:String = "parseXmlComplete";
		
		private var _title:String;
		
		private var _beanId:String;
		
		private var _beanClass:Class;
		
		private var _parent:BaseBeanMetaData;
		
		
		private var _viewOnly:Boolean;
		
		/**
		 * exclude properties
		 */
		private var _excludeProps:IList = new ArrayList();
		
		
		/**
	     * original object that you want to edit or create; 
		*/
		private var _model:Object;
		
		
		/**
		 * A xml that you can parse bean 
		 */ 
		private var _beanXml:XML;
		
		
		private var _component:UIComponent;
		
		private var _dataProviderMap:Object = new Object();
		

		
		public function set parent(value:BaseBeanMetaData):void
		{
			_parent = value;
		}
		
		public function get parent():BaseBeanMetaData
		{
			return _parent;
		}



		public function get title():String
		{
			return _title;
		}

		public function set title(value:String):void
		{
			_title = value;
		}

		public function get component():UIComponent
		{
			return _component;
		}

		public function set component(value:UIComponent):void
		{
			_component = value;
			
			if (_component)
			{
				if (_component is IBeanModel)
				{
					IBeanModel(_component).setBeanMetaData(this);
				}
			}
		}

		
		public function BaseBeanMetaData(model:Object)
		{
			this._model = model;
		
		}
		

		public function get model():Object
		{
			return _model;
		}
		
		public function set model(value:Object):void
		{
			_model = value;
		}
		
		public function set beanXml(value:XML):void
		{
			this._beanXml = value;	
		}

		public function get beanXml():XML
		{
			return this._beanXml;
		}

		public function getBeanXmlById(id:String):XML
		{
			if (beanXml.beans)
			{
				for each (var childBean:XML in beanXml.beans.children())
				{
					if (childBean.@id == id)
					{
						return childBean;
					}
				}
			}
			return null;
			
		}
		
		

		/**
		 * parse bean from beanXML Uri
		 */ 
		public function loadBeanXml(beanXmlFile:String):void
		{
			var loadBeanXmlSuccessFunc:Function = function parseRootBeanXml(event:Event):void
			{
				var loader:URLLoader = event.target as URLLoader;              
				if (loader != null)            
				{              
					
					parseBeanXml(new XML(loader.data));
					
				}       
				
			};
			
			XmlLoadUtil.loadXML(beanXmlFile,loadBeanXmlSuccessFunc);
			
		}
		
		
		/**
		 * parse bean xml and create BeanMetaData
		 * @param beanXML
		 * 
		 */		
		public function parseBeanXml(beanXML:XML):void
		{
			this.beanXml = beanXML;
			parseBeanProp(beanXML);
			parseExcludeProps(beanXML);
			parseDataProvider(beanXML);
			
			dispatchParseXmlComplete();
		}
		
		
		private function parseDataProvider(beanXML:XML):void
		{
			if (beanXML && beanXML.dataProviders)
			{
				for each(var dataProviderXml:XML in beanXML.dataProviders.children())
				{
					_dataProviderMap[dataProviderXml.@id] = dataProviderXml.children();
				}
			}
			
		}
		
		private function parseBeanProp(beanXML:XML):void
		{
			if (beanXML && beanXML.@id)
			{
				this.beanId = beanXML.@id;
			}
			if (beanXML &&  beanXML.@type)
			{
				this.beanClass = MyClassUtil.getClass(beanXML.@type);
			}else{
				MyClassUtil.getClass(MyClassUtil.getClassName(this.model));
			}
			
			if (beanXML &&  beanXML.@title)
			{
				this.title =  beanXML.@title;
			}
		}
		
		
		
		
		/**
		 * parse excludeProps from xml
		 */ 
		private function parseExcludeProps(beanXML:XML):void
		{
			if (beanXML &&　beanXML.excludeProps ){
				for each(var propXML:XML in beanXML.excludeProps.children())
				{
					var propName:String = propXML.toString();
					excludeProps.addItem(propName);
				}
			}
		}
		
		
		private function dispatchParseXmlComplete():void
		{
			if (component)
			{
				component.dispatchEvent(new LoadXmlCompleteEvent(LoadXmlCompleteEvent.COMPLETE));
			}
		}
		

		public function get excludeProps():IList
		{
			return _excludeProps;
		}

		public function set excludeProps(value:IList):void
		{
			_excludeProps = value;
		}
		
		
		public function set beanClass(value:Class):void
		{
			_beanClass = value;
		}
		
		public function get beanClass():Class
		{
			return _beanClass;
		}
		
		public function get beanId():String
		{
			return _beanId;
		}
		
		public function set beanId(value:String):void
		{
			_beanId = value;
		}
		
		
		
		public function getDataProvider(key:String):XMLList
		{
			return _dataProviderMap[key] as XMLList;
		}
		
		public function get viewOnly():Boolean
		{
			return _viewOnly;
		}
		
		public function set viewOnly(value:Boolean):void
		{
			_viewOnly = value;
		}


		
		

	}
}