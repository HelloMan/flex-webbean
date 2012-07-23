package com.googlecode.flexwebbeans.core.fields
{
	import com.googlecode.flexwebbeans.core.constants.WebbeanConstant;
	import com.googlecode.flexwebbeans.core.model.api.ElementMetaData;
	
	import mx.core.UIComponent;
	
	import spark.components.Group;

	/**
	 * @author jason zhang
	 */
	 public  class BaseField extends Group implements Field
	{
		private var  _elementMetaData:ElementMetaData;
		
		
		private var _populateUIProp:Boolean;
		
		public function BaseField()
		{
			super();
			this._populateUIProp = true;
			this.percentWidth = 100;
			this.percentHeight = 100;
			this.styleName =  WebbeanConstant.BEAN_FIELD_COMPONENT_STYLE;
		}

		
		protected function get populateUIProp():Boolean
		{
			return _populateUIProp;
		}

		protected function set populateUIProp(value:Boolean):void
		{
			_populateUIProp = value;
		}

		override protected function createChildren():void
		{
			super.createChildren();
			this.addElement(buildUIComponent());
		}
		/** create UIComponent and set all prop for UIComponent
		 * 
		 */ 
		private function buildUIComponent():UIComponent
		{
			var uiComponent:UIComponent = createUIComponent();
			if (populateUIProp){
				populateUIComponentProp(uiComponent);	
			}
			 
			return uiComponent;
		}
		
		/** set UIComponent prop from dynamic elementMetaData 
		 * 
		 */
		protected function populateUIComponentProp(uiComponent:UIComponent):void
		{
			uiComponent.enabled = elementMetaData.enable && !elementMetaData.viewOnly;
			elementMetaData.populateElementProp(uiComponent,["id","name","viewonly"]);
			
		}
		
		
		public function get elementMetaData():ElementMetaData
		{
			return _elementMetaData;
		}

		public function set elementMetaData(value:ElementMetaData):void
		{
			_elementMetaData = value;
		}
		
		/** get value model for this UIComponent
		 * 
		 */
		protected function getModel():Object
		{
			return elementMetaData.getModel();
		}
		
		
		/** set value model for this UIComponent
		 * 
		 */
		protected function setModel(value:Object):void
		{
			elementMetaData.setModel(value);
		}
		
		protected function createUIComponent():UIComponent
		{
			return new UIComponent();
		}

	}
}