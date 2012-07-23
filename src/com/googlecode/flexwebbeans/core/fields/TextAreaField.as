package com.googlecode.flexwebbeans.core.fields
{
	import com.googlecode.flexwebbeans.core.model.api.ElementMetaData;
	
	import flash.events.Event;
	
	import mx.core.UIComponent;
	import mx.validators.Validator;
	
	import spark.components.TextArea;
	
	
	public class TextAreaField extends BaseField
	{
		private var textInput:TextArea;
		public function TextAreaField()
		{
			super();
		}
		
		 
		
		override protected function createUIComponent():UIComponent
		{
			textInput  =  new TextArea();
			var value:Object = getModel();
			if (elementMetaData.viewOnly)
			{
				textInput.enabled = false;
			}else{
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
				
			}
			return textInput;
		}
		
		private function changeText(event:Event):void
		{
			setModel(textInput.text);
		}
	}
}