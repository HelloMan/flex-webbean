package com.googlecode.flexwebbeans.core.model
{
	import com.googlecode.flexwebbeans.core.fields.ActionField;
	import com.googlecode.flexwebbeans.core.fields.AutoCompleteField;
	import com.googlecode.flexwebbeans.core.fields.BaseField;
	import com.googlecode.flexwebbeans.core.fields.BeanFormField;
	import com.googlecode.flexwebbeans.core.fields.BeanGridField;
	import com.googlecode.flexwebbeans.core.fields.BeanTableField;
	import com.googlecode.flexwebbeans.core.fields.CheckBoxField;
	import com.googlecode.flexwebbeans.core.fields.ComboboxField;
	import com.googlecode.flexwebbeans.core.fields.DateInputField;
	import com.googlecode.flexwebbeans.core.fields.EmptyField;
	import com.googlecode.flexwebbeans.core.fields.LabelField;
	import com.googlecode.flexwebbeans.core.fields.LookupField;
	import com.googlecode.flexwebbeans.core.fields.RadioButtonGroupField;
	import com.googlecode.flexwebbeans.core.fields.RichEditableTextField;
	import com.googlecode.flexwebbeans.core.fields.RichTextField;
	import com.googlecode.flexwebbeans.core.fields.SpinnerField;
	import com.googlecode.flexwebbeans.core.fields.TextAreaField;
	import com.googlecode.flexwebbeans.core.fields.TextInputField;
	import com.googlecode.flexwebbeans.core.model.api.ElementMetaData;
	
	import mx.core.UIComponent;

	public class ComponentRegistry
	{
		private var _registry:Object = new Object();
		
		public function ComponentRegistry()
		{
			_registry["String"] = TextInputField;
			_registry["int"] = TextInputField;
			_registry["Object"] = BeanGridField;
			_registry["Date"]= DateInputField;
			_registry["Number"] = TextInputField;
			_registry["Boolean"]=CheckBoxField;

			_registry["BeanTable"] = BeanTableField;
			
			_registry["BeanGrid"] = BeanGridField;
			_registry["BeanForm"] = BeanFormField;

			
			_registry["_EMPTY_"] = EmptyField;
			_registry["Spinner"] = SpinnerField;
			_registry["BigString"]= TextAreaField;
			_registry["Combobox" ] = ComboboxField;
			_registry["AutoComplete"]=AutoCompleteField;
			_registry["Action"]=ActionField;
			_registry["Label"] = LabelField;
			_registry["Lookup"]=LookupField;
			_registry["RadioButtonGroup"]=RadioButtonGroupField;
			_registry["Password"]=TextInputField;
			_registry["RichText"]=RichTextField;
			_registry["RichEditableText"] = RichEditableTextField;
			
			
			
			
		}
		
		public function getField(elementMetaData:ElementMetaData):UIComponent
		{
			var ClassReference:Class = _registry[elementMetaData.fieldType] as Class;  
			var instance:BaseField = new ClassReference() as BaseField;
			instance.elementMetaData = elementMetaData;
			return instance ;
		}
		
		public function registryComponent(key:String,componentCls:Class):void
		{
			_registry[key] = componentCls;
		}
		
		
		
		
	}
}