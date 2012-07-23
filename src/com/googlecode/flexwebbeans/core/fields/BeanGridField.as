
package com.googlecode.flexwebbeans.core.fields {
	import com.googlecode.flexwebbeans.core.containers.BeanGridLayout;
	import com.googlecode.flexwebbeans.core.model.api.ElementMetaData;
	
	import mx.core.UIComponent;
	
	
	
	
	/**
	 * A Field that presents a property's bean in a BeanGridPanel. 
	 *
	 * @author Jason Zhang
	 */
	public class BeanGridField extends BaseField
	{
	    /**
	     * Construct a new BeanGridField.
	     *
	     * @param id the Wicket id for the editor.
	     * @param model the model.
	     * @param metaData the meta data for the property.
	     * @param viewOnly true if the component should be view-only.
	     */
	    public function BeanGridField()
	    {
	        super();
	    }
		
		override protected function createUIComponent():UIComponent
		{
			var beanGridLayout:BeanGridLayout =  new BeanGridLayout();
			beanGridLayout.beanMetaData = elementMetaData.createBeanMetaData(beanGridLayout);
			return beanGridLayout;
		}
		
	}
}