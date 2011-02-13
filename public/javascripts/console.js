if (!window.console) {
  var names = ["log", "debug", "info", "warn", "error"];
  window.console = {};
  for (var i = 0; i < names.length; ++i) window.console[names[i]] = function () {}
}