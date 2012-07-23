package com.googlecode.flexwebbeans.core.containers
{
	import com.googlecode.flexwebbeans.core.events.CRUDEvent;
	import com.googlecode.flexwebbeans.core.events.LoadXmlCompleteEvent;
	import com.googlecode.flexwebbeans.core.model.api.BaseBeanMetaData;
	import com.googlecode.flexwebbeans.core.model.api.BeanMetaData;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import mx.containers.HBox;
	import mx.containers.TitleWindow;
	import mx.controls.Alert;
	import mx.controls.ToolTip;
	import mx.core.IToolTip;
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	import mx.events.ValidationResultEvent;
	import mx.managers.PopUpManager;
	import mx.managers.ToolTipManager;
	import mx.validators.Validator;
	
	import spark.components.Button;
	import spark.components.VGroup;
	
	[Event(name="onUpdate", type="com.googlecode.flexwebbeans.core.events.CRUDEvent")]
	[Event(name="onCreate", type="com.googlecode.flexwebbeans.core.events.CRUDEvent")]
	/**
	 * 
	 * @author Administrator
	 * 
	 */
	public class BeanLayout extends TitleWindow implements IBeanModel,IBeanValidator
	{
		
		private var _beanMetaData:BeanMetaData;
		
		private var _showSaveButton:Boolean;
		
		private var _useImageButton:Boolean;
		
		private var _modify:Boolean;
		
		private var _validatorArr:Array =[];
		
		private var _allErrTips:Array = [];
		
		
		public function BeanLayout()
		{
			super();
			this.addEventListener(CloseEvent.CLOSE,close);
			this.addEventListener(LoadXmlCompleteEvent.COMPLETE,buildUI);
			this.percentWidth = 100;
			this.percentHeight = 100;
		}
		
		public function registerValidator(value:Validator):void
		{
			this._validatorArr.push(value);
		}
		
		public  function setBeanMetaData(beanMetaData:BaseBeanMetaData):void
		{
			this._beanMetaData = beanMetaData as BeanMetaData;
		}

		public function get modify():Boolean
		{
			return _modify;
		}

		public function set modify(value:Boolean):void
		{
			_modify = value;
		}

		public function get useImageButton():Boolean
		{
			return _useImageButton;
		}
		
		public function set useImageButton(value:Boolean):void
		{
			_useImageButton = value;
		}
		
		public function get showSaveButton():Boolean
		{
			return _showSaveButton;
		}
		
		public function set showSaveButton(value:Boolean):void
		{
			_showSaveButton = value;
		}
		
		public function get beanMetaData():BeanMetaData
		{
			return _beanMetaData;
		}
		
		public function set beanMetaData(value:BeanMetaData):void
		{
			_beanMetaData = value;
			value.component = this;
		}
		
		protected function buildUI(event:LoadXmlCompleteEvent):void
		{
			if (event && event.target == this)
			{
				this.title = beanMetaData.title;
				var vGroup:VGroup = new VGroup();
				vGroup.percentWidth = 100;
				vGroup.percentHeight = 100;
				vGroup.addElement(getLayout());
				vGroup.addElement(getButtons());
				this.addElement(vGroup);
			}
		}
		
		protected function getLayout():UIComponent
		{
			return new UIComponent();
		}
		
		protected function getButtons():UIComponent
		{
			var hBox:HBox = new HBox();
			if (showSaveButton){
				var saveBtn:Button = new Button();
				saveBtn.label = "Save";
				saveBtn.addEventListener(MouseEvent.CLICK,save);
				hBox.addElement(saveBtn);
			}
			
			if (showCloseButton){
				var closeBtn:Button = new Button();
				closeBtn.label = "Return";
				closeBtn.addEventListener(MouseEvent.CLICK,close);
				hBox.addElement(closeBtn);
			}
			return hBox;
		}
		
		
		protected function postBean():void
		{
			beanMetaData.commitChange();
			var event:CRUDEvent = new CRUDEvent(modify == true?CRUDEvent.UPDATE:CRUDEvent.CREATE,beanMetaData.editModel);
			dispatchEvent(event);
			
		}
		
		public function save(event:MouseEvent):void
		{
			if (!hasValidateError() && beanMetaData.hasModify() ){
				postBean();
				PopUpManager.removePopUp(this);
			}
		
		}
		
		private function hasValidateError():Boolean
		{
			//remove all error tips
//			if (_allErrTips.length >0 ){
//				for each( var errTip:IToolTip in _allErrTips)
//				{
//					ToolTipManager.destroyToolTip(errTip);
//				}
//				_allErrTips.length = 0;
//			}
//			
			var validateErrArray:Array = Validator.validateAll(_validatorArr);
			var hasValidErr:Boolean = validateErrArray.length >0;
//			if (hasValidErr)
//			{
//				//create error tips
//				for each ( var err:ValidationResultEvent in validateErrArray)
//				{
//					var pt:Rectangle = this.stage.getBounds(err.currentTarget.source);
//					var yPos:Number = pt.y * -1;
//					var xPos:Number = pt.x * -1;
//					
//					var errorTip:ToolTip = ToolTipManager.createToolTip(err.message,xPos + err.currentTarget.source.width , yPos) as ToolTip;
//					errorTip.setStyle("styleName","errorToolTip");
//					_allErrTips.push(errorTip);
//					
//				}
//			}
			
			return hasValidErr;
		}
		
		public function close(event:Event):void
		{
			if (beanMetaData.hasModify()){
				Alert.show("Do you want to save your changed?","Confirm",Alert.YES | Alert.NO | Alert.CANCEL,this,closeHandler);
				
			}else{
				PopUpManager.removePopUp(this);
			}
		}
		
		private function closeHandler(event:CloseEvent):void
		{
			switch (event.detail)
			{
				case Alert.YES:
				{
					if (!hasValidateError()){
						postBean();
						PopUpManager.removePopUp(this);
					}
					break;
				}
				case Alert.NO:{
					PopUpManager.removePopUp(this);
					break;
				}
				case Alert.CANCEL:
				{
					break;
				}
					
			}
		}
		
		
		public function isModified():Boolean{
			return beanMetaData.hasModify();
		}
	}
}