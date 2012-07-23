package com.googlecode.flexwebbeans.core.fields
{
	import com.googlecode.flexwebbeans.core.model.api.ElementMetaData;
	
	import flash.events.Event;
	
	import mx.core.UIComponent;
	import mx.validators.Validator;
	
	import spark.components.RichText;
	
	
	public class RichTextField extends BaseField
	{
		private var textInput:RichText;
		public function RichTextField()
		{
			super();
		}
		
		
		override protected function createUIComponent():UIComponent
		{
			if (elementMetaData.viewOnly)
			{
				var label:LabelField =  new LabelField();
				label.elementMetaData = elementMetaData;
				return label;
			}else{
				var value:Object = getModel();
				textInput  =  new RichText();
				if (value){
					textInput.text = value.toString();
				}else{
					textInput.text = "";
				}
				var validator :Validator = elementMetaData.registerValidator();
				if (validator)
				{
					validator.source = textInput;
					validator.property = "text";
				}
				
				textInput.addEventListener(Event.CHANGE,changeText);
				return textInput;
			}
		}
		
		private function changeText(event:Event):void
		{
			setModel(textInput.text);
		}
	}
}