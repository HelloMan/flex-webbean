package com.googlecode.flexwebbeans.core.containers
{
	import com.googlecode.flexwebbeans.core.events.CRUDEvent;
	import com.googlecode.flexwebbeans.core.events.LoadXmlCompleteEvent;
	import com.googlecode.flexwebbeans.core.model.BeanMetaDataFactory;
	import com.googlecode.flexwebbeans.core.model.api.BaseBeanMetaData;
	import com.googlecode.flexwebbeans.core.model.api.BeanMetaData;
	import com.googlecode.flexwebbeans.core.model.api.ElementMetaData;
	import com.googlecode.flexwebbeans.core.model.api.ListBeanMetaData;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.collections.IList;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.controls.DataGrid;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.events.CloseEvent;
	import mx.events.ListEvent;
	import mx.managers.PopUpManager;
	
	import spark.components.HGroup;
	import spark.components.VGroup;
	
	[Event(name="onDelete", type="com.googlecode.flexwebbeans.core.events.CRUDEvent")]
	
	/**
	 * 
	 * @author Jason Zhang
	 * 
	 */
	public class BeanTableLayout extends VGroup  implements IBeanModel
	{
		
		private var _grid:DataGrid = new DataGrid();
		
		private var _showDeleteButton:Boolean = true;
		
		private var _showCreateButton:Boolean = true;
		
		private var _showUpdateButton:Boolean = true;
		
		private var _showViewButton:Boolean = true ;
		
		private var _useFormLayout:Boolean = true;
		
		private var _listBeanMetaData:ListBeanMetaData;
		
		private var _selectedItem:Object;
		
		private var _dataProvider:ArrayCollection;
		
		public function BeanTableLayout()
		{
			super();
			this.addEventListener(LoadXmlCompleteEvent.COMPLETE,buildUI);
			this.percentWidth = 100;
			this.percentHeight = 100;
		}
		

		[Bindable]
		public function get dataProvider():ArrayCollection
		{
			return _dataProvider;
		}

		public function set dataProvider(value:ArrayCollection):void
		{
			_dataProvider = value;
			grid.dataProvider = _dataProvider;
		}

		public function set grid(value:DataGrid):void
		{
			_grid = value;
		}

		public function setBeanMetaData(beanMetaData:BaseBeanMetaData):void
		{
			this._listBeanMetaData = beanMetaData as ListBeanMetaData;
		}
		
		public function get useFormLayout():Boolean
		{
			return _useFormLayout;
		}

		public function set useFormLayout(value:Boolean):void
		{
			_useFormLayout = value;
		}

		public function get showViewButton():Boolean
		{
			return _showViewButton;
		}

		public function set showViewButton(value:Boolean):void
		{
			_showViewButton = value;
		}

		public function get grid():DataGrid
		{
			return _grid;
		}


		protected function buildButtonsBar():void
		{
			var container:HGroup = new HGroup();
			container.percentWidth = 100;
			if (showCreateButton){
				var createBtn: Button  = new Button();
				createBtn.label = "Create";
				createBtn.addEventListener(MouseEvent.CLICK,createItem);
				container.addElement(createBtn);
			}
			
			if (showUpdateButton){
				var updateBtn: Button  = new Button();
				updateBtn.label = "Update";
				updateBtn.addEventListener(MouseEvent.CLICK,updateItem);
				container.addElement(updateBtn);
			}
			
			if (showDeleteButton){
				var deleteBtn: Button  = new Button();
				deleteBtn.label = "Delete";
				deleteBtn.addEventListener(MouseEvent.CLICK,deleteItem);
				container.addElement(deleteBtn);
			}
			
			if (showViewButton){
				var viewBtn: Button  = new Button();
				viewBtn.label = "View";
				viewBtn.addEventListener(MouseEvent.CLICK,viewItem);
				container.addElement(viewBtn);
			}
			this.addElement(container);
		}
		
		public function get showUpdateButton():Boolean
		{
			return _showUpdateButton;
		}

		public function set showUpdateButton(value:Boolean):void
		{
			_showUpdateButton = value;
		}

		public function get showCreateButton():Boolean
		{
			return _showCreateButton;
		}

		public function set showCreateButton(value:Boolean):void
		{
			_showCreateButton = value;
		}

		public function get showDeleteButton():Boolean
		{
			return _showDeleteButton;
		}

		public function set showDeleteButton(value:Boolean):void
		{
			_showDeleteButton = value;
		}

		public function get listBeanMetaData():ListBeanMetaData
		{
			return _listBeanMetaData;
		}
		
		public function set listBeanMetaData(value:ListBeanMetaData):void
		{
			_listBeanMetaData = value;
			_listBeanMetaData.component = this;
		}
		
		private function buildUI(event:LoadXmlCompleteEvent):void
		{
			if (event && event.target == this){
				buildButtonsBar();
				buildGrid();
			}
			
		}
		
		private function buildGrid():void
		{
		
			grid.addEventListener(ListEvent.CHANGE,grid_changeHandler);
			
			grid.addEventListener(ListEvent.ITEM_DOUBLE_CLICK,gridViewItem);
			
			var gridColumns:ArrayCollection = listBeanMetaData.gridColumns as ArrayCollection;
			
			var sort:Sort = new Sort();
			sort.fields = [new SortField("order",false,false)];
			gridColumns.sort = sort;
			
			var columns:Array = [];
			
			for each(var gridColumn:ElementMetaData in gridColumns)
			{
				var column:DataGridColumn = new DataGridColumn();
				column.editable = !gridColumn.viewOnly;
				gridColumn.populateElementProp(column,["id","editable"]);
				columns.push(column);
			}
			
			if (columns.length>0)
			{
				grid.columns = columns;
			}
			
			dataProvider = listBeanMetaData.model as ArrayCollection;
			
			this.addElement(grid);
		}
		
		protected function grid_changeHandler(event:ListEvent):void
		{
			this._selectedItem = grid.selectedItem;
		}
		
		protected function createItem(event:MouseEvent):void
		{
			var ClassRef:Class = listBeanMetaData.beanClass;
			var newObj:Object = new ClassRef();
			popupEditWindow(newObj,false,false);
			
		}
		
		/**
		 * 
		 * @param obj
		 * @param viewOnly
		 * @param modify
		 * 
		 */
		private function popupEditWindow(obj:Object,viewOnly:Boolean,modify:Boolean):void
		{
			grid.percentHeight = 100;
			grid.percentWidth = 100;
			
			var beanEdit :BeanLayout ;
			if (useFormLayout)
			{
				beanEdit = new BeanFormLayout();
			}else{
				beanEdit = new BeanGridLayout();
			}
			
			beanEdit.addEventListener(CRUDEvent.CREATE,onCreateSuccess);
			beanEdit.addEventListener(CRUDEvent.UPDATE,onUpdateSuccess);
			
			beanEdit.showCloseButton = true;
			beanEdit.showSaveButton = true;
			
			var parentBeanMetaData :BeanMetaData = listBeanMetaData.parent as BeanMetaData;
			
			var curBeanMetaData:BeanMetaData = BeanMetaDataFactory.createBeanMetaDataByXML(
															obj,
															listBeanMetaData.beanXml,
															parentBeanMetaData.componentRegistry,
															parentBeanMetaData,beanEdit);
			curBeanMetaData.enableCommitChange = true;
			
			beanEdit.modify = modify;
			
			PopUpManager.addPopUp(beanEdit,this,true);
			PopUpManager.centerPopUp(beanEdit);
		}
		
		/**
		 *this is used to refresh grid when selecteditem has been changed 
		 * @param event
		 * 
		 */
		private function onUpdateSuccess(event :CRUDEvent):void
		{
			dataProvider.refresh();
		}
		
		/**
		 *this is used to refresh grid when selecteditem has been changed 
		 * @param event
		 * 
		 */
		private function onCreateSuccess(event :CRUDEvent):void
		{
			if (event.model)
			{
				dataProvider.addItem(event.model);
				grid.selectedIndex = dataProvider.getItemIndex(event.model);
				grid.scrollToIndex(grid.selectedIndex );
			}
		}
		
		protected function updateItem(event:MouseEvent):void
		{
			if( grid.selectedIndex>-1)
			{
				popupEditWindow(_selectedItem,false,true);
			}
			
		}
		
		
		protected function deleteItem(event:MouseEvent):void
		{
			if( grid.selectedIndex>-1)
			{
				Alert.show("Are you sure you want to delete this item?","Delete",Alert.YES | Alert.NO,this,deleteItemHandler);
			}
			
		}
		
		
		private function deleteItemHandler(event:CloseEvent):void
		{
			
			var index:int = dataProvider.getItemIndex(this._selectedItem);
			if (index !=-1)
			{
				dataProvider.removeItemAt(index);
				dispatchEvent(new CRUDEvent(CRUDEvent.DELETE,this._selectedItem));
			}
		}
		
		
		protected function viewItem(event:MouseEvent):void
		{
			if (grid.selectedIndex>-1)
			{
				popupEditWindow(_selectedItem,true,false);
			}
			
		}
		
		
		protected function gridViewItem(event:ListEvent):void
		{
			if (grid.selectedIndex>-1)
			{
				popupEditWindow(_selectedItem,true,false);
			}
		}
	}
}