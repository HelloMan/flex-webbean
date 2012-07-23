package com.googlecode.flexwebbeans.core.fields
{
	import com.googlecode.flexwebbeans.core.model.api.ElementMetaData;
	
	import flash.events.Event;
	
	import mx.controls.Label;
	import mx.core.UIComponent;
	import mx.states.OverrideBase;
	import mx.validators.Validator;
	
	import spark.components.Spinner;
	
	
	public class SpinnerField extends BaseField
	{
		private var textInput:Spinner;
		public function SpinnerField()
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
				textInput  =  new Spinner();
				if (value){
					textInput.value = Number(value.toString());
				}else{
					textInput.value =  0;
				}
				var validator :Validator = elementMetaData.registerValidator();
				if (validator)
				{
					validator.source = textInput;
					validator.property = "value";
				}
				
				textInput.addEventListener(Event.CHANGE,changeText);
				return textInput;
			}
		}
		
		private function changeText(event:Event):void
		{
			setModel(textInput.value);
		}
		
	}
}