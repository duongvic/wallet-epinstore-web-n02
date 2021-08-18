/**
 * 
 */
var Product = function() {
	
	var urlBase = location.origin + location.pathname;
	var cb = function(start, end) {
		$('#reportrange span').html(
				start.format('DD/MMMM/YYYY') + ' - '
						+ end.format('DD/MMMM/YYYY'));
	}

	var initDateRange = function(currentRange) {
		if (currentRange != '') {
			$('#reportrange span').html(currentRange);
			$('#reportrange input:hidden[name="range"]').val(currentRange);
		} else {
			$('#reportrange input:hidden[name="range"]').val(
					moment().subtract(0, 'days').format('DD/MMMM/YYYY') + '-'
							+ moment().format('DD/MMMM/YYYY'));
			cb(moment().subtract(0, 'days'), moment());
		}

		$('#reportrange').daterangepicker(
				{
					ranges : {
						'Today' : [ moment(), moment() ],
						'Yesterday' : [ moment().subtract(1, 'days'),
								moment().subtract(1, 'days') ],
						'Last 7 Days' : [ moment().subtract(6, 'days'),
								moment() ],
						'Last 30 Days' : [ moment().subtract(29, 'days'),
								moment() ],
						'This Month' : [ moment().startOf('month'),
								moment().endOf('month') ],
						'Last Month' : [
								moment().subtract(1, 'month').startOf('month'),
								moment().subtract(1, 'month').endOf('month') ]
					},
					locale : {
						applyLabel : 'Apply',
						customRangeLabel : 'Option',
						cancelLabel : 'Cancel'
					}
				}, cb);
	}
	
	var filterTransactionByDateRange = function(){
		$('#reportrange').on(
				'apply.daterangepicker',
				function(ev, picker) {
					var date = picker.startDate.format('DD/MM/YYYY') + '-'
							+ picker.endDate.format('DD/MM/YYYY');
					
					$('#reportrange input:hidden[name="range"]').val(date);
					var url = urlBase + '?'
					+ $('#transaction-filter').serialize();
					if(searchText != 'undefined' && searchText != ''){
						url += '&id=' + searchText;
					}
					location = url;
				});
	}
	
	var searchTransaction = function(){
		$('#btn-search').on('click', function(){
			var url = location.href.replace(/&?id=([^&]$|[^&]*)/i, '');
        	if(url.indexOf('?') == -1) url = url + '?';
            location = url + '&id=' + $('#search').val();
		});
		
		 $('#search').on('keypress', function (event) {
	         if(event.which === 13){
	        	 var url = location.href.replace(/&?id=([^&]$|[^&]*)/i, '');
	         	if(url.indexOf('?') == -1) url = url + '?';
	             location = url + '&id=' + $('#search').val();
	         }
	   });
	}
	
	var filterByMerchants = function(){
		if (merchants != '' && merchants.length > 0) {
			$('.multiple-select').find('option').each(
					function() {
						if ($.inArray($(this).val(), merchants) > -1) {
							$('.multiple-select').multiselect('select',
									$(this).val(), true);
						} else {
							$('.multiple-select').multiselect('deselect',
									$(this).val());
						}
					});
		}
		
		$('.ms-btn-sbm').on('click', function(){
			var url = urlBase + '?'
			+ $('#transaction-filter').serialize();
			if(searchText != 'undefined' && searchText != ''){
				url += '&id=' + searchText;
			}
			location = url;
		});
		
	}
	
	
	var filterByService = function(){
		$('select[name="service"]').on("change", function(){
			if($(this).val() == 'FUND_IN'){
				location = '/fundin/list';
			}else if($(this).val() == 'FUND_OUT'){
				location = '/fundout/list';
			}else{
				var url = urlBase + '?'
				+ $('#transaction-filter').serialize();
				if(searchText != 'undefined' && searchText != ''){
					url += '&id=' + searchText;
				}
				location = url;
			}
		});
	}
	
	var filterByType = function(){
		$('select[name="type"]').on("change", function(){
			var url = urlBase + '?'
			+ $('#transaction-filter').serialize();
			if(searchText != 'undefined' && searchText != ''){
				url += '&id=' + searchText;
			}
			location = url;
		});
	}
	
	var filterByStatus = function(){
		$('select[name="status"]').on("change", function(){
			var url = urlBase + '?'
			+ $('#transaction-filter').serialize();
			if(searchText != 'undefined' && searchText != ''){
				url += '&id=' + searchText;
			}
			location = url;
		});
	}
	
	var initAdd = function() {
		$('#add').on(
				'show.bs.modal',
				function(e) {
					$('#add input[name=sku]').val('');
					$('#add input[name=materialName]').val('');
					$('#add input[name=price]').val('0');
					$('#add select[name=availability]').val('No');
					//
				});
	}
	
	var initEdit = function() {
		$('#edit').on(
				'show.bs.modal',
				function(e) {
					$('#edit input[name=id]').val('');
					$('#edit input[name=sku]').val('');
					$('#edit input[name=materialName]').val('');
					$('#edit input[name=price]').val('0');
					$('#edit select[name=availability]').val('No');
					//
					var id = $(e.relatedTarget).closest('a').attr('prodid');
					var sku = $(e.relatedTarget).closest('a').attr('prodsku');
					var materialName = $(e.relatedTarget).closest('a').attr('prodmaterialname');
					var price = $(e.relatedTarget).closest('a').attr('prodprice');
					var availability = $(e.relatedTarget).closest('a').attr('prodavailability');

					$('#edit input[name=id]').val(id);
					$('#edit input[name=sku]').val(sku);
					$('#edit input[name=materialName]').val(materialName);
					$('#edit input[name=price]').val(price);
					$('#edit select[name=availability]').val(availability);
				});
	}
	
	var initView = function() {
		$('#view').on(
				'show.bs.modal',
				function(e) {
					$('#view input[name=id]').val('');
					$('#view input[name=sku]').val('');
					$('#view input[name=materialName]').val('');
					$('#view input[name=price]').val('0');
					$('#view select[name=availability]').val('No');
					//
					var id = $(e.relatedTarget).closest('a').attr('prodid');
					var sku = $(e.relatedTarget).closest('a').attr('prodsku');
					var materialName = $(e.relatedTarget).closest('a').attr('prodmaterialname');
					var price = $(e.relatedTarget).closest('a').attr('prodprice');
					var availability = $(e.relatedTarget).closest('a').attr('prodavailability');

					$('#view input[name=id]').val(id);
					$('#view input[name=sku]').val(sku);
					$('#view input[name=materialName]').val(materialName);
					$('#view input[name=price]').val(price);
					$('#view select[name=availability]').val(availability);
				});
	}
	
	var initAddSubmit = function(){
		$('#add form[name=add]').on('submit', function(e){
    		e.preventDefault();
			if(!confirm('Are you sure to add new Product?'))
				return false;
			var form = $('#add form[name=add]');
			var formData = new FormData($(this)[0]);
			var target  = form.attr('action');
    		$.ajax({
    			type : "POST",
    			url : target,
    			data : formData,
    			async: false,
    			mimeType:"multipart/form-data",
    			contentType: false,
	            cache: false,
	            processData:false,
    			dataType : 'json',
    			beforeSend: function() {
    		        $('#add .submitBtn').val('Sending....'); // change submit button text
    		      },
    			error : function(xhr, ajaxOptions, thrownError) {
    				$('#add .submitBtn').val('Add new');
    			},
    			success : function(data, textStatus, jqXHR) {
    				 $('#add .submitBtn').val('Add new');
    				alert(data.message);
    				if(data.code == 0) {
    					$('#add .dismissBtn').click();
    					// Reset
    					$('#add form[name=add]').trigger("reset");
    					location.reload();
    				} 
    			}
    		});
    		return false;
		});
	}
	
	var initEditSubmit = function(){
		$('#edit form[name=edit]').on('submit', function(e){
    		e.preventDefault();
			if(!confirm('Are you sure to edit Product?'))
				return false;
			var form = $('#edit form[name=edit]');
			var formData = new FormData($(this)[0]);
			var target  = form.attr('action');
    		$.ajax({
    			type : "POST",
    			url : target,
    			data : formData,
    			async: false,
    			mimeType:"multipart/form-data",
    			contentType: false,
	            cache: false,
	            processData:false,
    			dataType : 'json',
    			beforeSend: function() {
    		        $('#edit .submitBtn').val('Editing....'); // change submit button text
    		      },
    			error : function(xhr, ajaxOptions, thrownError) {
    				$('#edit .submitBtn').val('Edit');
    			},
    			success : function(data, textStatus, jqXHR) {
    				 $('#edit .submitBtn').val('Edit');
    				alert(data.message);
    				if(data.code == 0) {
    					$('#edit .dismissBtn').click();
    					// Reset
    					$('#edit form[name=edit]').trigger("reset");
    					location.reload();
    				} 
    			}
    		});
    		return false;
		});
	}
	
	return {
		// main function to initiate the module
		init : function() {
			// dropdown navbar
			$("#navbar-main-1").bootstrapDropdownOnHover();
			$("#navbar-main-2").bootstrapDropdownOnHover();
			$("#navbar-main-3").bootstrapDropdownOnHover();

			$(".guide_alert_over").click(function() {
				$("body").addClass("body_over");
			});
			$(".modal-dismiss").click(function() {
				$("body").removeClass("body_over");
			});

			$('.c-column .multiselect-container li').last().after(
					'<li class="btn-rs"><a href="">Reset as default</a></li>');
			
			initView();
			initAdd();
			initEdit();
			initAddSubmit();
			initEditSubmit();
			
		},
	};
}();
jQuery(document).ready(function() {
	Product.init();
});