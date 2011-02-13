(function($){
  $.fn.extend({
    align: function (withit, options, adjust) {
      options = options || "";
      adjust = adjust || {};
      var viewportTop = document.documentElement.scrollTop || document.body.scrollTop || 0,
          viewportLeft = document.documentElement.scrollLeft || document.body.scrollLeft || 0,
          viewportWidth = document.documentElement.clientWidth,
          viewportHeight = document.documentElement.clientHeight;
      if (withit == window) var K = {
        left: viewportLeft,
        top: viewportTop,
        width: $(window).width(),
        height: $(window).height()
      };
      else {
        withit = $(withit);
        var off = withit.offset();
        K = {
          left: off.left,
          top: off.top,
          width: withit.innerWidth(),
          height: withit.innerHeight()
        }
      }
      withit = {
        width: this.innerWidth(),
        height: this.innerHeight()
      };
      var new_left = options.indexOf("-left") >= 0 ? K.left : options.indexOf("left") >= 0 ? K.left - withit.width : options.indexOf("-right") >= 0 ? K.left + K.width - withit.width : options.indexOf("right") >= 0 ? K.left + K.width : K.left + (K.width - withit.width) / 2;
      var new_right = options.indexOf("-top") >= 0 ? K.top : options.indexOf("top") >= 0 ? K.top - withit.height : options.indexOf("-bottom") >= 0 ? K.top + K.height - withit.height : options.indexOf("bottom") >= 0 ? K.top + K.height : K.top + (K.height - withit.height) / 2;
      options = options.indexOf("no-constraint") >= 0 ? false : true;
      new_left += adjust.left || 0;
      new_right += adjust.top || 0;
      if (options) {
        new_left = Math.max(viewportLeft, Math.min(new_left, viewportLeft + viewportWidth - withit.width));
        new_right = Math.max(viewportTop, Math.min(new_right, viewportTop + viewportHeight - withit.height))
      }
      $(this).css({
        position: "absolute",
        left: new_left + "px",
        top: new_right + "px"
      });
      return this
    },
     draggable: function (options) {
        options || (options = {});
        this.each(function () {
          var p = this,
              R = null,
              W = null,
              ea = null,
              ga = function (k) {
              k.stopPropagation();
              k.preventDefault();
              return false
              },
              la = _.bind(function (k) {
              if (!p._drag) return ga(k);
              if (R) R.css({
                top: k.pageY - ea,
                left: k.pageX - W
              });
              else {
                p.style.left = p._drag.left + k.pageX - p._drag.x + "px";
                p.style.top = p._drag.top + k.pageY - p._drag.y + "px"
              }
            }, p),
              K = _.bind(function (k) {
              $(document.body).unbind("selectstart", ga);
              $(document.body).unbind("mouseup", K);
              $(document.body).unbind("mousemove", la);
              $(R || p).removeClass("dragging");
              R && $(R).remove();
              p._drag = null;
              if (options.onDrop) options.onDrop(k)
            }, p),
              ia = _.bind(function (k) {
              var v;
              v = $(k.target).is("input, select, textarea, label, a, canvas, .minibutton, .text_link, .selectable_text, .not_draggable") ? true : $(k.target).parents(".is_draggable").andSelf().length ? ga(k) : true;
              if (v) return true;
              if (options.ghost) {
                W = $(p).width() / 2;
                ea = $(p).height() / 2;
                R = $(p).clone().css({
                  position: "absolute",
                  cursor: "copy",
                  "z-index": 1E3,
                  top: k.pageY - ea,
                  left: k.pageX - W
                }).appendTo(document.body)
              }
              $(R || p).addClass("dragging");
              p._drag = {
                left: parseInt(p.style.left, 10) || 0,
                top: parseInt(p.style.top, 10) || 0,
                x: k.pageX,
                y: k.pageY
              };
              $(document.body).bind("selectstart", ga);
              $(document.body).bind("mouseup", K);
              $(document.body).bind("mousemove", la)
            }, p);
          $(p).bind(options.ghost ? "dragstart" : "mousedown", ia)
        })
      },
  });
})(jQuery)