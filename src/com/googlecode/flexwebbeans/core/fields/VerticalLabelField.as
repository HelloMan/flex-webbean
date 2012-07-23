package com.googlecode.flexwebbeans.core.fields
{
	import com.googlecode.flexwebbeans.core.constants.WebbeanConstant;
	import com.googlecode.flexwebbeans.core.model.api.ElementMetaData;
	
	import flash.display.DisplayObject;
	
	import mx.containers.VBox;
	import mx.core.IUITextField;
	import mx.core.UIComponent;
	
	import spark.components.Group;
	import spark.components.Label;
	
	
	public class VerticalLabelField extends Group
	{
		private var elementMetaData:ElementMetaData ; 
		
		public function VerticalLabelField(elementMetaData:ElementMetaData)
		{
			super();
			this.elementMetaData = elementMetaData;
		}
			
		override protected function createChildren():void
		{
			super.createChildren();
			var vbox:VBox = new VBox();
			vbox.percentHeight = 100;
			vbox.percentWidth = 100;
			
			if ( elementMetaData.label && elementMetaData.showLabel){
				var label : Label = new Label();
				label.text = elementMetaData.label;
				label.styleName = WebbeanConstant.BEAN_FIELD_LABEL_STYLE;
				vbox.addElement(label);
			}else{
			}
			var component:UIComponent = elementMetaData.tabMetaData.beanMetaData.componentRegistry.getField(elementMetaData);
			
			vbox.addElement(component);
			this.addElement(vbox);
		}
	}
}