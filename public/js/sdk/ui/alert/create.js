// Generated by CoffeeScript 1.3.3
(function() {

  app.implement(function() {
    var alerts, conf, getInitialY, init, removeFirst, self, showAlert, updateElements, updatePositions;
    self = {};
    alerts = [];
    conf = app.config.get('ui.alert');
    updatePositions = function() {
      var y;
      y = conf.settings.margin;
      return alerts.each(function() {
        var alert;
        alert = $(this);
        alert.stop().animate({
          top: y
        }, 500);
        return y += alert.outerHeight() + conf.settings.margin;
      });
    };
    updateElements = function() {
      return alerts = $(conf.selectors.alert);
    };
    removeFirst = function() {
      alerts.first().fadeOut(200, function() {
        $(this).remove();
        return updatePositions();
      });
      return alerts = alerts.not(alerts.first());
    };
    getInitialY = function() {
      var y;
      y = conf.settings.margin;
      if (alerts.length !== 0) {
        alerts.each(function() {
          return y += $(this).outerHeight() + conf.settings.margin;
        });
      }
      return y;
    };
    showAlert = function(content, options) {
      var initialY;
      options = $.extend({
        type: '',
        url: '',
        action: '',
        content: content
      }, options);
      initialY = getInitialY();
      $(app.template.render('ui.alert', options)).appendTo('body').css({
        top: initialY
      });
      updateElements();
      setTimeout(removeFirst, conf.settings.duration);
      return updatePositions();
    };
    init = function() {
      return updateElements();
    };
    init();
    self.show = showAlert;
    return self;
  }, ['ui', 'alert'], true);

}).call(this);