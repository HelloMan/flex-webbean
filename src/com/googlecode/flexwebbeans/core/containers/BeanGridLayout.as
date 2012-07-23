package com.googlecode.flexwebbeans.core.containers
{
	import com.googlecode.flexwebbeans.core.constants.WebbeanConstant;
	import com.googlecode.flexwebbeans.core.fields.ActionField;
	import com.googlecode.flexwebbeans.core.fields.BaseField;
	import com.googlecode.flexwebbeans.core.fields.VerticalLabelField;
	import com.googlecode.flexwebbeans.core.model.api.BeanMetaData;
	import com.googlecode.flexwebbeans.core.model.api.ElementMetaData;
	import com.googlecode.flexwebbeans.core.model.api.TabMetaData;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.collections.IList;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.containers.Grid;
	import mx.containers.GridItem;
	import mx.containers.GridRow;
	import mx.containers.TabNavigator;
	import mx.containers.VBox;
	import mx.core.UIComponent;
	
	/**
	 * @author jason zhang
	 */
	public class BeanGridLayout extends BeanLayout  
	{
		
		public function BeanGridLayout()
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
			vBox.label = tabMetaData.caption;
			
			var elementList:ArrayCollection = tabMetaData.props as ArrayCollection;
			var sort:Sort = new Sort();
			sort.fields = [new SortField("order",false,false)];
			elementList.sort = sort;
			
			var rowsAndCols:Array = [];
			
			var columns:int = tabMetaData.columns;
			
			var currRow:Array;
			
			var colPos:int = 0;
			
			for each(var  element:ElementMetaData in elementList) {
				var colspan:int = element.colspan;
				if (colspan < 1 || colspan > columns) { 
					colspan = 1;
				}
				
				// If colspan > number of columns left, start a new row.
				if ((colPos + colspan) > columns) {
					colPos = 0;
				}
				
				if (colPos == 0) {
					currRow = [];
					rowsAndCols.push(currRow);
				}
				
				currRow.push(element);
				colPos += colspan;
				if (colPos >= columns) {
					colPos = 0;
				}
			}
			
			var grid:Grid = new Grid();
			grid.styleName = WebbeanConstant.BEAN_GRID_STYLE; 
			grid.percentWidth = 100;
			for each(var curRow:Array in rowsAndCols)
			{
				var gridRow:GridRow = new GridRow();
				gridRow.percentWidth = 100;
				gridRow.styleName = WebbeanConstant.BEAN_GRID_ROW_STYLE;
				for each(var curCol:ElementMetaData in curRow)
				{
					var gridItem :GridItem  = new GridItem();
					gridItem.percentWidth = 100;
					if (curCol.itemHeight)
					{
						gridItem.height = curCol.itemHeight;
					}
					gridItem.styleName = WebbeanConstant.BEAN_GRID_ITEM_STYLE;
					gridItem.colSpan = curCol.colspan;
					gridItem.rowSpan = curCol.rowspan;
					if (curCol.isActionField())
					{
						var baseelement:BaseField = new ActionField();
						baseelement.elementMetaData = curCol;
						gridItem.addElement(baseelement);
					}else{
						gridItem.addElement(new VerticalLabelField(curCol));
					}
					gridRow.addElement(gridItem);
				}
				grid.addElement(gridRow);
			}
			vBox.addElement(grid);
			return vBox;
		}
		
	}
}