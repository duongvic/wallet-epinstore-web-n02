/**
 * 
 */
'use strict';
var App = function(){
	return {
		// main function to initiate the module
		init:function(){
			$('.multiple-select').multiselect({ 
				maxHeight: 200, 
				includeSelectAllOption: true, 
				enableCaseInsensitiveFiltering: true,
				selectAllText: 'All Merchant',
			});
			
			$('.multiselect-container li').last().after('<a class="mb-xs mt-xs mr-xs btn btn-primary m-s-btn ms-btn-sbm">Submit</a>');
		}
	};
	
}();
jQuery(document).ready(function() {
	App.init();
});