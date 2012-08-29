// Generated by CoffeeScript 1.3.3
(function() {

  app.implement(function(form) {
    var conf, displayError, getInputLabel, parseRules, resetError, self, testRule, validateEmail, validateField, validateForm;
    self = {};
    conf = app.config.get('form');
    getInputLabel = function(input) {
      return input.closest('form').find('label[for="' + input.attr('name') + '"]');
    };
    resetError = function(input) {
      var label;
      label = getInputLabel(input);
      return label.find(conf.selectors.errorMessage).remove();
    };
    displayError = function(msg, input) {
      var label;
      label = getInputLabel(input);
      if (label.find(conf.selectors.errorMessage).length !== 0) {
        resetError(input);
      }
      return label.append(app.template.render('ui.validation.error', {
        message: msg
      }));
    };
    validateEmail = function(string) {
      var lastAtPos, lastDotPos;
      lastAtPos = string.lastIndexOf('@');
      lastDotPos = string.lastIndexOf('.');
      return lastAtPos < lastDotPos && lastAtPos > 0 && string.indexOf('@@') === -1 && lastDotPos > 2 && (string.length - lastDotPos) > 2;
    };
    testRule = function(input, rule, ruleVal) {
      var targetField, validates;
      validates = true;
      switch (rule) {
        case 'minLength':
          if (input.val().length < parseInt(ruleVal, 10)) {
            validates = false;
            displayError("Must be at least " + ruleVal + " characters long", input);
          }
          break;
        case 'type':
          if (ruleVal === 'email') {
            validates = validateEmail(input.val());
            displayError('Needs to be a valid email address', input);
          }
          break;
        case 'matchField':
          if (form.find(("[name='" + ruleVal + "']").length)) {
            targetField = form.find("[name='" + ruleVal + "']");
            if (input.val() !== targetField.val()) {
              validates = false;
              displayError(app.utils.string.capitalise(ruleVal) + ' confirmation doesn\'t match', input);
            }
          }
          break;
        case 'required':
          if (ruleVal === true || ruleVal === 'true' && input.val().length === 0) {
            validates = false;
            displayError('This field cannot be empty', input);
          }
      }
      return validates;
    };
    parseRules = function(rulesString) {
      var curr, rules, rulesArr, _i, _len;
      rules = {};
      rulesArr = rulesString.split(',');
      for (_i = 0, _len = rulesArr.length; _i < _len; _i++) {
        curr = rulesArr[_i];
        curr = curr.split(':');
        rules[app.utils.string.trimSpaces(curr[0])] = app.utils.string.trimSpaces(curr[1]);
      }
      return rules;
    };
    validateField = function(input, rules) {
      var rule, ruleVal;
      for (rule in rules) {
        ruleVal = rules[rule];
        if (testRule(input, rule, ruleVal) === false) {
          return false;
        }
      }
      resetError(input);
      return true;
    };
    validateForm = function(form) {
      var validates;
      validates = true;
      form.find('input').each(function() {
        var rules;
        if (typeof $(this).attr('data-validate') !== 'undefined') {
          rules = parseRules($(this).attr('data-validate'));
          return validates = validateField($(this), rules);
        }
      });
      return validates;
    };
    return validateForm(form);
  }, ['form', 'validate'], false);

}).call(this);