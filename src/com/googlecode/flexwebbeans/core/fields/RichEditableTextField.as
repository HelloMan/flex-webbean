package com.googlecode.flexwebbeans.core.fields
{
	import com.googlecode.flexwebbeans.core.model.api.ElementMetaData;
	
	import flash.events.Event;
	
	import mx.controls.RichTextEditor;
	import mx.core.UIComponent;
	import mx.validators.Validator;
	
	
	public class RichEditableTextField extends BaseField
	{
		private var textInput:RichTextEditor;
		public function RichEditableTextField()
		{
			super();
		}
		
		
		override protected function createUIComponent():UIComponent
		{
			textInput  =  new RichTextEditor();
			if (elementMetaData.viewOnly)
			{
				textInput.enabled = false;
			}else{
				var value:Object = getModel();
				textInput  =  new RichTextEditor();
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