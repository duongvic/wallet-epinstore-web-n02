jQuery(document).ready(function () {
  $.i18n().locale = $('html').attr('lang');
  $('body').i18n();
  $.i18n().load({
    vi: ctx + '/assets/development/i18n/language_en.json', // Messages for Hindi
    en: ctx + '/assets/development/i18n/language_en.json'
  });
});