package com.googlecode.flexwebbeans.core.fields
{
	import com.googlecode.flexwebbeans.core.model.api.ElementMetaData;
	
	import flash.events.Event;
	
	import mx.controls.DateField;
	import mx.controls.Label;
	import mx.core.UIComponent;
	import mx.events.CalendarLayoutChangeEvent;
	import mx.formatters.DateFormatter;
	import mx.validators.Validator;
	
	
	public class DateInputField extends BaseField
	{
		private var dateField:DateField = new DateField();
		
		public function DateInputField()
		{
			super();
		}
		
		
		override protected function createUIComponent():UIComponent
		{
			dateField = new DateField();
			dateField.formatString = elementMetaData.formatString ==null?"DD/MM/YYYY":elementMetaData.formatString;
			dateField.selectedDate = getModel() as Date;
			if (elementMetaData.viewOnly){
				dateField.editable = false;
				dateField.enabled = false;
			}else{
				var validator :Validator = elementMetaData.registerValidator();
				if (validator)
				{
					validator.source = dateField;
					validator.property = "selectedDate";
				}
				dateField.addEventListener(CalendarLayoutChangeEvent.CHANGE,changeDate);
			}
			return dateField;
		}
		
		private function changeDate(event:CalendarLayoutChangeEvent):void
		{
			setModel(dateField.selectedDate);
		}

	}
}