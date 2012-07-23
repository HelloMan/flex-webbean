package com.googlecode.flexwebbeans.core.fields
{
	import flash.events.Event;
	
	import mx.binding.utils.BindingUtils;
	import mx.core.UIComponent;
	import mx.validators.Validator;
	
	import spark.components.TextInput;

	public class TextInputField extends BaseField
	{
		private var validator :Validator;
		
		private  var textInput:TextInput;
		
		public function TextInputField()
		{
			super();
	
		}
		
		override protected function createUIComponent():UIComponent
		{
			if (elementMetaData.viewOnly)
			{
				var label:LabelField = new LabelField();
				label.elementMetaData = elementMetaData;
				return label;
			}else{
				var value:Object = getModel();
				textInput  =  new TextInput();
//				if (value){
//					textInput.text = value.toString();
//				}else{
//					textInput.text = "";
//				}
				
				BindingUtils.bindProperty(textInput,"text",elementMetaData.tabMetaData.beanMetaData.editModel,elementMetaData.name);
				BindingUtils.bindSetter(changeText,textInput,"text");
				
				validator = elementMetaData.registerValidator();
				if (validator)
				{
					validator.source = textInput;
					validator.property = "text";
				}
				
//				textInput.addEventListener(Event.CHANGE,changeText);
				return textInput;
			}
		}
		
		private function changeText(event:*):void
		{
			setModel(textInput.text);
		}
		
		
	}
}