package com.googlecode.flexwebbeans.core.utils
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class XmlLoadUtil
	{
		public static function loadXML(xmlFile:String,loadCompleteFun:Function):void
		{
			var loader:URLLoader = new URLLoader();           
			var request:URLRequest = new URLRequest(xmlFile);
			loader.addEventListener(Event.COMPLETE,loadCompleteFun);
			loader.load(request);
		}
		
	}
}