package com.googlecode.flexwebbeans.core.fields
{
	import com.googlecode.flexwebbeans.core.constants.WebbeanConstant;
	import com.googlecode.flexwebbeans.core.model.api.ElementMetaData;
	
	import mx.containers.HBox;
	import mx.controls.Label;
	import mx.controls.TextInput;
	import mx.core.UIComponent;
	
	import spark.components.Group;
	
	
	public class HorizontalField extends Group
	{
		private var elementMetaData:ElementMetaData ; 
		public function HorizontalField(elementMetaData:ElementMetaData)
		{
			super();
			this.elementMetaData = elementMetaData;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			var hbox:HBox = new HBox();
			if (elementMetaData.name){
				var label : Label = new Label();
				label.text = elementMetaData.label;
				label.styleName = WebbeanConstant.BEAN_FIELD_LABEL_STYLE;
				hbox.addElement(label);
			}
			var component:UIComponent = elementMetaData.tabMetaData.beanMetaData.componentRegistry.getField(elementMetaData);
			hbox.addElement(component);
			this.addElement(hbox);
		}
		
	}
}