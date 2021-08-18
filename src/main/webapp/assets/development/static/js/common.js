function disagree() {
  $.MessageBox({message: 'Bạn không có quyền thao tác!'});
}

$(document).ready(function () {
  $('#hight-title').hover(function () {
    $('#hight-title').css("color", "#F58220");
  }, function () {
    $('#hight-title').css("color", "");
  });

  $(".guide_alert_over").click(function () {
    $("body").addClass("body_over");
  });

  $(".modal-dismiss").click(function () {
    $("body").removeClass("body_over");
  });

  $('[data-toggle="popover"]').popover();
  $("a.not-role").click(function () {
    /*var notice = new PNotify({
      title: 'Thông báo',
      text: 'Bạn không có quyền sử dụng chức năng này.',
      addclass: 'notification-primary stack-bottomright',
      icon: 'fa fa-twitter'
    });*/
    $.MessageBox({message: "Bạn không có quyền sử dụng chức năng này.!"});
  });

  $('li.nav-parent').find('> a').on('click', function () {
    var prev = $(this).closest('ul.nav').find('> li.nav-expanded'), next = $(this).closest('li');
    if (prev.get(0) !== next.get(0)) {
      collapse(prev);
      expand(next);
    } else {
      collapse(prev);
    }
  });

  function expand(li) {
    li.children('ul.nav-children').slideDown('fast', function () {
      li.addClass('nav-expanded');
      $(this).css('display', '');
      ensureVisible(li);
    });
  }

  function collapse(li) {
    li.children('ul.nav-children').slideUp('fast', function () {
      $(this).css('display', '');
      li.removeClass('nav-expanded');
    });
  }

  function ensureVisible(li) {
    var scroller = li.offsetParent();
    if (!scroller.get(0)) {
      return false;
    }
    var top = li.position().top;
    if (top < 0) {
      scroller.animate({
        scrollTop: scroller.scrollTop() + top
      }, 'fast');
    }
  }

  if ($('table#item').length) {
    //table paging, order column
    $('table#item').dataTable({
      "paginate": false,
      "sort": true,
      "searching": false,
      "autoWidth": true
    });
  }

  $('[data-toggle="tooltip"]').tooltip();

  //number text
  $(document).on('keyup', 'input.textNumber', function () {
    var text = $(this).val();
    var number = text.replace(/,/g, '');
    number = number.replace(/(\d)(?=(\d{3})+\b)/g, '$1,');
    $(this).val(number);
    $("form[name=cashOnHand] .totalamount").html(number);
  });
  $(document).on('keydown', 'input.textNumber', function (e) {
    // Allow: backspace, delete, tab, escape, enter and .
    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 116]) !== -1 ||
        // Allow: Ctrl+A, Command+A
        (e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) ||
        // Allow: home, end, left, right, down, up
        (e.keyCode >= 35 && e.keyCode <= 40)) {
      // let it happen, don't do anything
      return;
    }
    // Ensure that it is a number and stop the keypress
    if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
      e.preventDefault();
    }
  });

});




