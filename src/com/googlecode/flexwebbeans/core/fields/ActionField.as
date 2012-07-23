package com.googlecode.flexwebbeans.core.fields
{
	import com.googlecode.flexwebbeans.core.events.ActionEvent;
	import com.googlecode.flexwebbeans.core.model.api.ElementMetaData;
	
	import flash.events.MouseEvent;
	
	import mx.controls.Image;
	import mx.core.UIComponent;
	
	import spark.components.Button;
	
	public class ActionField extends BaseField
	{
		public function ActionField()
		{
			super();
		}
		
		
		override protected function createUIComponent():UIComponent
		{
			
			if (elementMetaData.imageUri){
				var image: Image = new Image();
				image.source = elementMetaData.imageUri;
				image.addEventListener(MouseEvent.CLICK,clickHandler);
				return image;
			}else{
				var button:Button = new Button();
				button.addEventListener(MouseEvent.CLICK,clickHandler);
				button.visible = !elementMetaData.viewOnly;
				return button;
			}
			
			
		}
		
		private function clickHandler(event:MouseEvent):void
		{
			 if (elementMetaData.eventType){
				dispatchEvent(new ActionEvent(elementMetaData.eventType,this.getModel()));
			 }
		}
	}
}