package com.googlecode.flexwebbeans.core.model.api
{
	import com.googlecode.flexwebbeans.core.model.ComponentRegistry;
	import com.googlecode.flexwebbeans.core.utils.MyClassUtil;
	import com.googlecode.flexwebbeans.core.utils.MyObjectUtil;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.collections.IList;
	import mx.core.UIComponent;
	import mx.utils.ObjectProxy;
	import mx.utils.ObjectUtil;

	
	/**
	 * @author jason zhang
	 */
	public  class BeanMetaData extends BaseBeanMetaData
	{
		/**
		 *this is used to determine whether commit change to original model from editModel 
		 */		
		private var _enableCommitChange:Boolean;
		/**
		 * Tell how many tab exists 
		 */ 
		private var _tabs:IList = new ArrayList();
		
		
		/**
		 * object clone from model,please call registerClassAlias first for custom object 
		 */ 
		private var _editModel:Object;
		
		/**
		 * original bean's properties 
		 */ 
		private var _props:Array;
		
		
		/**
		 * 
		 * @see com.googlecode.flexwebbeans.model.ComponentRegistry
		 */ 
		private var _componentRegistry:ComponentRegistry;
		
		

		
		public function get enableCommitChange():Boolean
		{
			return _enableCommitChange;
		}

		public function set enableCommitChange(value:Boolean):void
		{
			_enableCommitChange = value;
		}

		
		public function BeanMetaData(model:Object,componentRegistry:ComponentRegistry = null)
		{
			super(model);
			
			//you need to registry this bean class first and it's inner custom class 
			this._editModel =  ObjectUtil.copy(model) ;
			
			
			this._componentRegistry = componentRegistry;
			
			if (this._componentRegistry==null){
				_componentRegistry = new ComponentRegistry();
			}
		
		}
		

		public function get editModel():Object
		{
			return _editModel;
		}



		public function get componentRegistry():ComponentRegistry
		{
			return _componentRegistry;
		}


		/**
		 * parse elementMetaData from xml
		 */ 
		private function parseElementMetaData(tabXml:XML,tabMetaData:TabMetaData):void
		{
			var order:int = 0;
			if (tabXml.props )
			{
				for each(var propXml:XML in tabXml.props.children())
				{
					var elementMetaData:ElementMetaData = new ElementMetaData();
					elementMetaData.order = order++;
					elementMetaData.viewOnly = viewOnly;
					MyObjectUtil.setDynamicPropByXml(elementMetaData,propXml);
					
					for each( var propChild:XML in propXml.children())
					{
						if ("validator" == propChild.localName()){
							elementMetaData.validatorXml = propChild;
							break;
						}
					}
					elementMetaData.tabMetaData = tabMetaData;
					tabMetaData.props.addItem(elementMetaData);
				}
				
			}
			
		}
		
		private function parseTabMetaData(beanXML:XML):void
		{
			if (beanXML && beanXML.tabs )
			{	
				for each(var tabXml:XML in beanXML.tabs.children())
				{
					var tabMetaData:TabMetaData = new TabMetaData();
					tabMetaData.beanMetaData = this;
					MyObjectUtil.setDynamicPropByXml(tabMetaData,tabXml);
					parseElementMetaData(tabXml,tabMetaData);
					this.tabs.addItem(tabMetaData);
				}
			}else{
				createDefaultTabMetaData();
			}
		}
		
		private function getBeanProps():Array
		{
			if (this._props == null)
			{
				this._props = ObjectUtil.getClassInfo(this.model,this.excludeProps.toArray()).properties;
			}

			return this._props;
		}
		
		
		/**
		 * create defaultTabMetaData when there is no tab exist
		 */ 
		private function createDefaultTabMetaData():void{
			var tabMetaData:TabMetaData = new TabMetaData();
			tabMetaData.beanMetaData = this;
			for each(var prop:QName in getBeanProps())
			{
				var elementMetaData:ElementMetaData = new ElementMetaData();
				elementMetaData.name = prop.localName;
				elementMetaData.tabMetaData = tabMetaData;
				tabMetaData.props.addItem(elementMetaData);
			}
			this.tabs.addItem(tabMetaData);
		}
		
		/**
		 * parse bean xml and create BeanMetaData
		 * @param beanXML
		 * 
		 */		
		override public function parseBeanXml(beanXML:XML):void
		{
			parseTabMetaData(beanXML);
			setElementDefaultFieldType();
			super.parseBeanXml(beanXML);
		}
		
		
		
		/**
		 * 
		 * 
		 */
		protected function setElementDefaultFieldType():void
		{
			//process fieldType
			for (var i:int = 0; i<tabs.length ; i++ ){
				var tab:TabMetaData = tabs.getItemAt(i) as TabMetaData;
				for each (var element:ElementMetaData in tab.props)
				{
					if ( element.isActionField() || element.isEmptyField())
					{
						continue;
					}
					var className:String = MyClassUtil.getPropTypeName(this.model,element.name);
					element.className = className;
					if ( element.fieldType ==null){
						
						if (className != "int" && className != "Number" && className != "Boolean" && className != "String"  && className !="Date"){
							if (className.indexOf("mx.collections") !=-1 || className == "Array"){
								element.fieldType = "Grid";
							}else {
								element.fieldType = "Object";
							}
						}else{
							element.fieldType = className;
						}
						
					}
				}
			}
		}
		

		public function get tabs():IList
		{
			return _tabs;
		}

		public function set tabs(value:IList):void
		{
			_tabs = value;
		}

		public function getRootBeanMetaData():BaseBeanMetaData
		{
			var parent:BaseBeanMetaData = this.parent;
			while(parent!=null)
			{
				parent = parent.parent;
			}
			return parent;
		}
 
		
		public function hasModify():Boolean
		{
			return ObjectUtil.compare(this.editModel,this.model) != 0;
		}
		
		public function commitChange():void
		{
			if (enableCommitChange)
			{
				var props:Array = getBeanProps();
				for each(var prop:QName in props)
				{
					model[prop.localName] =  editModel[prop.localName];
				}
			}
			
		}

	}
}