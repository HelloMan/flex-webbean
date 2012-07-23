
package com.googlecode.flexwebbeans.core.utils
{
	
	
	/**
	 *  @private
	 *  This class represents a single cache entry, this gets created
	 *  as part of the <code>describeType</code> method call on the 
	 *  <code>DescribeTypeCache</code>  class.
	 */
	
	public dynamic class DescribeTypeCacheHolder 
	{
		//--------------------------------------------------------------------------
		//
		//  Class variables
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Class properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  typeDescription
		//----------------------------------
		
		/**
		 *  @private
		 */
		public var typeDescription:XML;
		
		//----------------------------------
		//  typeName
		//----------------------------------
		
		/**
		 *  @private
		 */
		public var typeName:String;
		
	}
	
}
