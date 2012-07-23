package com.googlecode.flexwebbeans.core.containers
{
	import com.googlecode.flexwebbeans.core.constants.WebbeanConstant;
	import com.googlecode.flexwebbeans.core.fields.ActionField;
	import com.googlecode.flexwebbeans.core.fields.BaseField;
	import com.googlecode.flexwebbeans.core.model.api.ElementMetaData;
	import com.googlecode.flexwebbeans.core.model.api.TabMetaData;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.collections.IList;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.containers.Form;
	import mx.containers.FormItem;
	import mx.containers.TabNavigator;
	import mx.containers.VBox;
	import mx.core.UIComponent;
	
	/**
	 * @author jason zhang
	 */
	public class BeanFormLayout extends BeanLayout 
	{
		
		public function BeanFormLayout()
		{
			super();
			
		}
		
		override protected function getLayout():UIComponent
		{
			var tabList:IList = new ArrayList();
			for ( var index:int =0 ; index<beanMetaData.tabs.length ; index++){
				var aTab:TabMetaData = beanMetaData.tabs.getItemAt(index ) as TabMetaData;
				tabList.addItem(createTabContent(aTab));
			}
			
			if (tabList.length == 1){
				return tabList.getItemAt(0) as UIComponent;
			}else
			{
				//create Tabnavigate
				var tabNav:TabNavigator = new TabNavigator();
				tabNav.percentWidth = 100;
				tabNav.percentHeight = 100;
				for (var tabIndex:int = 0 ;tabIndex<tabList.length; tabIndex++)
				{
					tabNav.addElement(tabList.getItemAt(tabIndex) as UIComponent);
				}
				return tabNav;
			}
			
		}
		
		private function createTabContent(tabMetaData:TabMetaData):UIComponent
		{
		
			var vBox:VBox = new VBox();
			vBox.percentWidth = 100;
			vBox.percentHeight = 100;
			vBox.label = tabMetaData.caption;
			var elementList:ArrayCollection = tabMetaData.props as ArrayCollection;
			var sort:Sort = new Sort();
			sort.fields = [new SortField("order",false,false)];
			elementList.sort = sort;
			
		
			var form:Form = new Form();
			form.styleName = WebbeanConstant.BEAN_GRID_STYLE; 
			form.percentWidth = 100;
			for (var index:int=0 ; index<tabMetaData.props.length ; index++)
			{
				
				
				var curElement:ElementMetaData = tabMetaData.props.getItemAt(index) as ElementMetaData;
				
				if (curElement.isEmptyField())
				{
					continue;
				}
				var formItem:FormItem = new FormItem();
				formItem.percentWidth = 100;
				formItem.styleName = WebbeanConstant.BEAN_GRID_ROW_STYLE;
				if (curElement.required){
					formItem.required = curElement.required;
				}
				
				formItem.label = curElement.label;
				if (curElement.isActionField())
				{
					var element:BaseField = new ActionField();
						element.elementMetaData = curElement;
					formItem.addElement(element);
				}else{
					formItem.addElement(curElement.getFieldComponent());
				}
				form.addElement(formItem);
			}
			
			vBox.addElement(form);
			return vBox;
		}
		
	
	}
}