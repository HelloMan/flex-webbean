package com.googlecode.flexwebbeans.core.fields
{
	import com.googlecode.flexwebbeans.core.model.api.ElementMetaData;
	
	import flash.events.Event;
	
	import mx.binding.utils.BindingUtils;
	import mx.core.UIComponent;
	
	import spark.components.CheckBox;
	
	
	public class CheckBoxField extends BaseField
	{
		private var checkBox:CheckBox;
		public function CheckBoxField()
		{
			super();
		}
		
		override protected function createUIComponent():UIComponent
		{
			checkBox = new CheckBox();
			if (elementMetaData.viewOnly){
				checkBox.enabled = false;
			}else{
				checkBox.selected = Boolean(getModel() );
				checkBox.addEventListener(Event.CHANGE,changeHandler);
			}
			return checkBox;
		}
		
		private function changeHandler(event:Event):void{
			setModel(checkBox.selected);
		}
	}
}