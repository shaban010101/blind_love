!function(t){"use strict";Foundation.libs.tooltip={name:"tooltip",version:"5.0.0",settings:{additional_inheritable_classes:[],tooltip_class:".tooltip",append_to:"body",touch_close_text:"Tap To Close",disable_for_touch:!1,tip_template:function(t,o){return'<span data-selector="'+t+'" class="'+Foundation.libs.tooltip.settings.tooltip_class.substring(1)+'">'+o+'<span class="nub"></span></span>'}},cache:{},init:function(t,o,i){this.bindings(o,i)},events:function(){var o=this;Modernizr.touch?t(this.scope).off(".tooltip").on("click.fndtn.tooltip touchstart.fndtn.tooltip touchend.fndtn.tooltip","[data-tooltip]",function(i){var e=t.extend({},o.settings,o.data_options(t(this)));e.disable_for_touch||(i.preventDefault(),t(e.tooltip_class).hide(),o.showOrCreateTip(t(this)))}).on("click.fndtn.tooltip touchstart.fndtn.tooltip touchend.fndtn.tooltip",this.settings.tooltip_class,function(o){o.preventDefault(),t(this).fadeOut(150)}):t(this.scope).off(".tooltip").on("mouseenter.fndtn.tooltip mouseleave.fndtn.tooltip","[data-tooltip]",function(i){var e=t(this);/enter|over/i.test(i.type)?o.showOrCreateTip(e):("mouseout"===i.type||"mouseleave"===i.type)&&o.hide(e)})},showOrCreateTip:function(t){var o=this.getTip(t);return o&&o.length>0?this.show(t):this.create(t)},getTip:function(o){var i=this.selector(o),e=null;return i&&(e=t('span[data-selector="'+i+'"]'+this.settings.tooltip_class)),"object"==typeof e?e:!1},selector:function(t){var o=t.attr("id"),i=t.attr("data-tooltip")||t.attr("data-selector");return(o&&o.length<1||!o)&&"string"!=typeof i&&(i="tooltip"+Math.random().toString(36).substring(7),t.attr("data-selector",i)),o&&o.length>0?o:i},create:function(o){var i=t(this.settings.tip_template(this.selector(o),t("<div></div>").html(o.attr("title")).html())),e=this.inheritable_classes(o);i.addClass(e).appendTo(this.settings.append_to),Modernizr.touch&&i.append('<span class="tap-to-close">'+this.settings.touch_close_text+"</span>"),o.removeAttr("title").attr("title",""),this.show(o)},reposition:function(o,i,e){var s,n,a,r,l;if(i.css("visibility","hidden").show(),s=o.data("width"),n=i.children(".nub"),a=n.outerHeight(),r=n.outerHeight(),l=function(t,o,i,e,s,n){return t.css({top:o?o:"auto",bottom:e?e:"auto",left:s?s:"auto",right:i?i:"auto",width:n?n:"auto"}).end()},l(i,o.offset().top+o.outerHeight()+10,"auto","auto",o.offset().left,s),this.small())l(i,o.offset().top+o.outerHeight()+10,"auto","auto",12.5,t(this.scope).width()),i.addClass("tip-override"),l(n,-a,"auto","auto",o.offset().left);else{var u=o.offset().left;Foundation.rtl&&(u=o.offset().left+o.offset().width-i.outerWidth()),l(i,o.offset().top+o.outerHeight()+10,"auto","auto",u,s),i.removeClass("tip-override"),e&&e.indexOf("tip-top")>-1?l(i,o.offset().top-i.outerHeight(),"auto","auto",u,s).removeClass("tip-override"):e&&e.indexOf("tip-left")>-1?l(i,o.offset().top+o.outerHeight()/2-2.5*a,"auto","auto",o.offset().left-i.outerWidth()-a,s).removeClass("tip-override"):e&&e.indexOf("tip-right")>-1&&l(i,o.offset().top+o.outerHeight()/2-2.5*a,"auto","auto",o.offset().left+o.outerWidth()+a,s).removeClass("tip-override")}i.css("visibility","visible").hide()},small:function(){return matchMedia(Foundation.media_queries.small).matches},inheritable_classes:function(o){var i=["tip-top","tip-left","tip-bottom","tip-right","noradius"].concat(this.settings.additional_inheritable_classes),e=o.attr("class"),s=e?t.map(e.split(" "),function(o){return-1!==t.inArray(o,i)?o:void 0}).join(" "):"";return t.trim(s)},show:function(t){var o=this.getTip(t);this.reposition(t,o,t.attr("class")),o.fadeIn(150)},hide:function(t){var o=this.getTip(t);o.fadeOut(150)},reload:function(){var o=t(this);return o.data("fndtn-tooltips")?o.foundationTooltips("destroy").foundationTooltips("init"):o.foundationTooltips("init")},off:function(){t(this.scope).off(".fndtn.tooltip"),t(this.settings.tooltip_class).each(function(o){t("[data-tooltip]").get(o).attr("title",t(this).text())}).remove()},reflow:function(){}}}(jQuery,this,this.document);