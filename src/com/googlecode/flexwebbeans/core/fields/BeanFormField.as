
package com.googlecode.flexwebbeans.core.fields {
	import com.googlecode.flexwebbeans.core.containers.BeanFormLayout;
	import com.googlecode.flexwebbeans.core.containers.BeanGridLayout;
	import com.googlecode.flexwebbeans.core.model.api.ElementMetaData;
	
	import mx.core.UIComponent;
	
	
	
	
	/**
	 * A Field that presents a property's bean in a BeanGridPanel. 
	 *
	 * @author Jason Zhang
	 */
	public class BeanFormField extends BaseField
	{
	    /**
	     * Construct a new BeanGridField.
	     *
	     * @param id the Wicket id for the editor.
	     * @param model the model.
	     * @param metaData the meta data for the property.
	     * @param viewOnly true if the component should be view-only.
	     */
	    public function BeanFormField()
	    {
	        super();
	    }
		
		override protected function createUIComponent():UIComponent
		{
			var beanFormLayout:BeanFormLayout =  new BeanFormLayout();
			beanFormLayout.beanMetaData = elementMetaData.createBeanMetaData(beanFormLayout);
			return beanFormLayout;
		}
		
	}
}