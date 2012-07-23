package com.googlecode.flexwebbeans.core.model.api
{
	import com.googlecode.flexwebbeans.core.containers.IBeanValidator;
	import com.googlecode.flexwebbeans.core.model.BeanMetaDataFactory;
	import com.googlecode.flexwebbeans.core.utils.MyClassUtil;
	import com.googlecode.flexwebbeans.core.utils.MyObjectUtil;
	
	import mx.collections.ArrayCollection;
	import mx.collections.XMLListCollection;
	import mx.core.UIComponent;
	import mx.utils.ObjectUtil;
	import mx.validators.CurrencyValidator;
	import mx.validators.DateValidator;
	import mx.validators.EmailValidator;
	import mx.validators.NumberValidator;
	import mx.validators.PhoneNumberValidator;
	import mx.validators.StringValidator;
	import mx.validators.Validator;
	import mx.validators.ZipCodeValidator;

	
	/**
	 * @author jason zhang
	 */
	public dynamic class ElementMetaData extends MetaData implements IFieldModel
	{
		private static const PROP_BEANXMLURI:String = "beanXMLUri";
		
		private var _colspan:int = 1;
		
		private var _rowspan:int = 1;
		
		private var _order:int;
		
		private var _viewOnly:Boolean ;
		
		private var _enable:Boolean = true;
		
		private var _showLabel:Boolean = true;
		
		
		private var _tabMetaData:TabMetaData;
		
		private var _name:String;
		
		private var _label:String;
		
		private var _fieldType:String;
		
		private var _className:String;
		
		private var _validatorXml:XML;
		
		private var _formatter:Object;
		
		public function ElementMetaData()
		{
			super();
		}


		public function get validatorXml():XML
		{
			return _validatorXml;
		}

		public function set validatorXml(value:XML):void
		{
			_validatorXml = value;
		}

		public function get formatter():Object
		{
			return _formatter;
		}

		public function set formatter(value:Object):void
		{
			_formatter = value;
		}


		public function get showLabel():Boolean
		{
			return _showLabel;
		}

		public function set showLabel(value:Boolean):void
		{
			_showLabel = value;
		}

		public function get className():String
		{
			return _className;
		}

		public function set className(value:String):void
		{
			_className = value;
		}


		public function get fieldType():String
		{
			return _fieldType;
		}

		public function set fieldType(value:String):void
		{
			_fieldType = value;
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

		public function get tabMetaData():TabMetaData
		{
			return _tabMetaData;
		}

		public function set tabMetaData(value:TabMetaData):void
		{
			_tabMetaData = value;
		}
		
		public function get rowspan():int
		{
			return _rowspan;
		}
		
		public function set rowspan(value:int):void
		{
			_rowspan = value;
		}
		
		public function get colspan():int
		{
			return _colspan;
		}
		
		public function set colspan(value:int):void
		{
			_colspan = value;
		}
		
		public function get order():int
		{
			return _order;
		}
		
		public function set order(value:int):void
		{
			_order = value;
		}
		
		public function get viewOnly():Boolean
		{
			return _viewOnly;
		}
		
		public function set viewOnly(value:Boolean):void
		{
			_viewOnly = value;
		}
		
		public function get enable():Boolean
		{
			return _enable;
		}
		
		public function set enable(value:Boolean):void
		{
			_enable = value;
		}

 
		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		
		private function getRootBeanMetaData():BaseBeanMetaData
		{
			var parentBeanMetaData:BaseBeanMetaData = tabMetaData.beanMetaData;
			while(parentBeanMetaData.parent!=null)
			{
				parentBeanMetaData = parentBeanMetaData.parent;
			}
			return parentBeanMetaData;
		}
		
		public function isActionField():Boolean
		{
			return this.fieldType == "Action";
		}
		
		public function isEmptyField():Boolean
		{
			return this.fieldType == "EmptyField";
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function createBeanMetaData(uiComponent:UIComponent):BeanMetaData
		{
			var rootBeanMetaData:BeanMetaData = getRootBeanMetaData() as BeanMetaData;
			
			var beanXml:XML = rootBeanMetaData.getBeanXmlById(this[PROP_BEANXMLURI]);
			
			var model:Object = getModel();
			if (model==null)
			{
				var ClassRefrence:Class = MyClassUtil.getClass(className);
				model = new  ClassRefrence();
			}
			
			var beanMetaData:BeanMetaData =  BeanMetaDataFactory.createBeanMetaDataByXML(model,beanXml,rootBeanMetaData.componentRegistry,tabMetaData.beanMetaData,uiComponent);
			beanMetaData.enableCommitChange = true;
			return beanMetaData;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function createListBeanMetaData(uiComponent:UIComponent):ListBeanMetaData
		{
			var rootBeanMetaData:BeanMetaData = getRootBeanMetaData() as BeanMetaData;
			
			var beanXml:XML = rootBeanMetaData.getBeanXmlById(this[PROP_BEANXMLURI]);
			
			var model:Object =getModel();
			if (model==null)
			{
				
				if (className.indexOf("mx.collections") && "mx.collections.ArrayCollection" !=className)
				{
					model = new ArrayCollection();
				}else{
					var ClassRefrence:Class = MyClassUtil.getClass(className);
					model = new  ClassRefrence();
				}
			}
			
			return  BeanMetaDataFactory.createListBeanMetaDataByXML(model,beanXml,tabMetaData.beanMetaData,uiComponent);
		}
		
		
		public function populateElementProp(obj:Object,excludesProps:Array= null):void
		{
			var props:Array = ObjectUtil.getClassInfo(this).properties;
			for each(var prop:QName in props)
			{
				//igore "id" & "enabled" prop
				
				if (excludesProps.indexOf(prop)!=-1)
				{
					continue;
				}
				
				try
				{
					//Because we defined ElementMetaData as dynamic class ,so we can set prop by follwing code
					obj[prop.localName] = this[prop.localName];
				}catch(e:Error)
				{
					//if error,no problem which means no  property named prop  
				}
			}
		}
		
		public function getDataProvider(key:String):XMLListCollection
		{
			return  new XMLListCollection(getRootBeanMetaData().getDataProvider(key));
		}
		
		
		public function getFieldComponent():UIComponent
		{
			return this.tabMetaData.beanMetaData.componentRegistry.getField(this);
		}
		
		
		public function getModel():Object
		{
			return MyObjectUtil.getDynamicPropValue(tabMetaData.beanMetaData.editModel,this.name);
		}
		
		
		/** set value model for this UIComponent
		 * 
		 */
		public function setModel(value:Object):void
		{
			tabMetaData.beanMetaData.editModel[this.name] = value;
		}
		
		public function registerValidator():Validator
		{
			var validator :Validator = getValidator();
			if (validator)
			{
				
				var beanvalidator :IBeanValidator = tabMetaData.beanMetaData.component as IBeanValidator;
				beanvalidator.registerValidator(validator);
			}
			return validator;
			
		}
		
		
		private function getValidator():Validator
		{
			if (this._validatorXml )
			{
				var curValidator:Validator;
				switch (_validatorXml.@type )
				{
					case "String":
						curValidator = new StringValidator();
						break;
					case "Phone":
						curValidator = new PhoneNumberValidator();
						break;
					case "Number":
						curValidator = new NumberValidator();
						break;
					case "ZipCode":
						curValidator = new ZipCodeValidator();
						break;
					case "Email":
						curValidator = new EmailValidator();
						break;
					case "Currency":
						curValidator = new CurrencyValidator();
						break;
					case "Date":
						curValidator = new DateValidator();
						break;
					default :
						curValidator = new StringValidator();;
						break;
				}
				
				MyObjectUtil.setDynamicPropByXml(curValidator,_validatorXml);
				return curValidator;
			}
			
			return null;
		}
	}
}