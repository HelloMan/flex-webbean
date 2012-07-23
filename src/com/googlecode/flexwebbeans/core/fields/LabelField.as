package com.googlecode.flexwebbeans.core.fields
{
	import com.googlecode.flexwebbeans.core.model.api.ElementMetaData;
	
	import mx.core.UIComponent;
	
	import spark.components.Label;
	
	
	public class LabelField extends BaseField
	{
		public function LabelField()
		{
			super();
		}
		
		override protected function createUIComponent():UIComponent
		{
			
			var label :Label =  new Label();
			if (getModel()==null){
				label.text = "";
			}else{
				label.text = getModel().toString();
			}
			return label;
		}
		
		override protected function populateUIComponentProp(uiComponent:UIComponent):void
		{
			
		}
	}
}