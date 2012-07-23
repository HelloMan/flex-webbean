package com.googlecode.flexwebbeans.core.utils
{
	import mx.utils.ObjectUtil;

	public class MyObjectUtil
	{
		/**
		 * 
		 * @param obj
		 * @param propName
		 * @return 
		 * 
		 */		
		public static function getDynamicPropValue(obj:Object,propName:String):Object
		{
			
			if (propName)
			{
				var propNameChain:Array = propName.split(".");
				var objValue:Object = obj;
				for each(var prop:String in propNameChain)
				{
					try{
						objValue = objValue[prop];
					}catch(e:Error)
					{
						return null;
					}
				}
				return objValue;
			}
			return null;
		}
		
		
		/**
		 * copy object from one to another
		 * @param nObj
		 * @param oObj
		 * 
		 */
		public static function copyObject(destObj:Object, sourceObj:Object):void
		{
			var oClassObj:Object = ObjectUtil.getClassInfo(sourceObj);
			
			var nClassObj:Object = ObjectUtil.getClassInfo(destObj);
			
			var oPropArr:Array = oClassObj.properties as Array;
			
			var propName:String = "";
			
			var oArrSize:int = oPropArr.length;
			
			for (var i:int = 0; i < oArrSize; i++)
			{
				propName = oPropArr[i];
				if (sourceObj.hasOwnProperty(propName))
				{
					destObj[propName] = ObjectUtil.copy(sourceObj[propName]);
				}
			}
		}
		
		/**
		 * 
		 * @param obj
		 * @param propXml
		 * 
		 */
		public static function setDynamicPropByXml(obj:Object ,propXml:XML):void
		{
			var propName:String ;
			var propValue:String ;
			for each(var propAttribute:XML in propXml.attributes())
			{
				propName = propAttribute.localName();
				propValue  = propAttribute.toString();
				setDynamicProp(obj,propName,propValue);
				
			}
			for each( var propChild:XML in propXml.children())
			{
				if (propChild.hasSimpleContent()){
					propName = propChild.localName();
					propValue  = propChild.toString();
					
					setDynamicProp(obj,propName,propValue);
				}
			}
		}
		
		/**
		 * 
		 * @param obj
		 * @param propName
		 * @param propValue
		 * 
		 */
		public static function setDynamicProp(obj:Object,propName:String,propValue:String):void
		{
			try{
				var propNum:Number = parseInt(propValue);
				var isBool:Boolean = ("TRUE" == propValue.toUpperCase() || "FALSE" == propValue.toUpperCase());
				if (!isNaN(propNum))
				{
					obj[propName] = propNum;
				}else if (isBool)
				{
					obj[propName] = ("TRUE" == propValue.toUpperCase())? true:false;
				}else{
					obj[propName] = propValue;
				}
			}
			catch(e:Error){
				
			}
		}

	}
}