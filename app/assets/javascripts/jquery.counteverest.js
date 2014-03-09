/*!
 * Count Everest - jQuery Plugin
 * @version 	1.1
 * @requires 	jQuery v1.6 or later
 * @author 		Patrick Baber <support@anacoda.de>
 * @see			http://counteverest.anacoda.de
 *
 */
;(function ($, window, document, undefined) {
	//defaults
	var p = "countEverest",
		def = {
			/**
			 * Use this to specify the day in a month of the target date. The value have to be an integer between 1 and
			 * 31.
			 */
			day: 19,

			/**
			 * Use this to specify the month of the target date. The value have to be an integer between 1 and 12.
			 */
			month: 1,

			/**
			 * Use this to specify the year of the target date in four digits, e.g. 2021
			 */
			year: 2038,

			/**
			 * Use this to specify the hour of the target date. The value have to be an integer between 0 and 23.
			 */
			hour: 3,

			/**
			 * Use this to specify the minute of the target date. The value have to be an integer between 0 and 59.
			 */
			minute: 14,

			/**
			 * Use this to specify the second of the target date. The value have to be an integer between 0 and 59.
			 */
			second: 8,

			/**
			 * Use this to specify the millisecond of the target date. The value have to be an integer between 0 and
			 * 999.
			 */
			millisecond: 0,

			/**
			 * This is the sizzle selector for the days value inside your countdown wrapper.
			 */
			daysWrapper: ".ce-days",

			/**
			 * This is the sizzle selector for the hours value inside your countdown wrapper.
			 */
			hoursWrapper: ".ce-hours",

			/**
			 * This is the sizzle selector for the minutes value inside your countdown wrapper.
			 */
			minutesWrapper: ".ce-minutes",

			/**
			 * This is the sizzle selector for the seconds value inside your countdown wrapper.
			 */
			secondsWrapper: ".ce-seconds",

			/**
			 * This is the sizzle selector for the deciseconds value inside your countdown wrapper. If this element is
			 * found, the "highspeedTimeout" is used for the countdown calculation. See the explanation below for more
			 * details.
			 */
			decisecondsWrapper: ".ce-dseconds",

			/**
			 * This is the sizzle selector for the milliseconds value inside your countdown wrapper. If this element is
			 * found, the "highspeedTimeout" is used for the countdown calculation. See the explanation below for more
			 * details.
			 */
			millisecondsWrapper: ".ce-mseconds",

			/**
			 * This is the sizzle selector for the unit "days" inside your countdown wrapper.
			 */
			daysLabelWrapper: ".ce-days-label",

			/**
			 * This is the sizzle selector for the unit "hours" inside your countdown wrapper.
			 */
			hoursLabelWrapper: ".ce-hours-label",

			/**
			 * This is the sizzle selector for the unit "minutes" inside your countdown wrapper.
			 */
			minutesLabelWrapper: ".ce-minutes-label",

			/**
			 * This is the sizzle selector for the unit "seconds" inside your countdown wrapper.
			 */
			secondsLabelWrapper: ".ce-seconds-label",

			/**
			 * This is the sizzle selector for the unit "deciseconds" inside your countdown wrapper.
			 */
			decisecondsLabelWrapper: ".ce-dseconds-label",

			/**
			 * This is the sizzle selector for the unit "milliseconds" inside your countdown wrapper.
			 */
			millisecondsLabelWrapper: ".ce-mseconds-label",

			/**
			 * This is the unit label inside "daysLabelWrapper" which is used if the value inside the "daysWrapper" is
			 * greater than 1. "dayLabel" (singular) is used at a value of 1.
			 */
			daysLabel: "Days",

			/**
			 * Same as above, but this label is only used if the value of the calculated days is 1. Set it to null, if
			 * you want to use the "daysLabel" always.
			 */
			dayLabel: "Day",

			/**
			 * This is the unit label inside "hoursLabelWrapper" which is used if the value inside the "hoursWrapper" is
			 * greater than 1. "hourLabel" (singular) is used at a value of 1.
			 */
			hoursLabel: "Hours",

			/**
			 * Same as above, but this label is only used if the value of the calculated hours is 1. Set it to null, if
			 * you want to use the "hoursLabel" always.
			 */
			hourLabel: "Hour",

			/**
			 * This is the unit label inside "minutesLabelWrapper" which is used if the value inside the
			 * "minutesWrapper" is greater than 1. "minuteLabel" (singular) is used at a value of 1.
			 */
			minutesLabel: "Minutes",

			/**
			 * Same as above, but this label is only used if the value of the calculated minutes is 1. Set it to null,
			 * if you want to use the "minutesLabel" always.
			 */
			minuteLabel: "Minute",

			/**
			 * This is the unit label inside "secondsLabelWrapper" which is used if the value inside the
			 * "secondsWrapper" is greater than 1. "minuteLabel" (singular) is used at a value of 1.
			 */
			secondsLabel: "Seconds",

			/**
			 * Same as above, but this label is only used if the value of the calculated seconds is 1. Set it to null,
			 * if you want to use the "secondsLabel" always.
			 */
			secondLabel: "Second",

			/**
			 * This is the unit label inside "decisecondsLabelWrapper" which is used if the value inside the
			 * "decisecondsWrapper" is greater than 1. "decisecondLabel" (singular) is used at a value of 1.
			 */
			decisecondsLabel: "Deciseconds",

			/**
			 * Same as above, but this label is only used if the value of the calculated seconds is 1. If you don't want
			 * to use this, set it to null.
			 */
			decisecondLabel: "Decisecond",

			/**
			 * This is the unit label inside "millisecondsLabelWrapper" which is used if the value inside the
			 * "millisecondsWrapper" is greater than 1. "millisecondLabel" (singular) is used at a value of 1.
			 */
			millisecondsLabel: "Milliseconds",

			/**
			 * Same as above, but this label is only used if the value of the calculated milliseconds is 1. If you don't
			 * want to use this, set it to null.
			 */
			millisecondLabel: "Millisecond",

			/**
			 * After this time in milliseconds the calculation of the countdown is triggered periodically. The default
			 * value fits if you want to show seconds as your smallest time unit, otherwise read the explanation about
			 * the "highspeedTimeout" param bellow.
			 */
			timeout: 1000,

			/**
			 * Same as timeout, but this is only in use if the "decisecondsWrapper" or "millisecondsWrapper" are set to
			 * an existing element. This is necessary for the fast recalculation, which is needed for the presentation
			 * of deciseconds and milliseconds. The default value is the official W3C standard for HTML5 browsers. The
			 * calculation with the "highspeedTimeout" consumes more resources, so use it only when necessary.
			 */
			highspeedTimeout: 4,

			/**
			 * Use this option to force left-hand zeros. Every value will have two digits excluding the year (four
			 * digits) and the milliseconds (3 digits).
			 */
			leftHandZeros: true,

			/**
			 * Wrap each digit with a span tag to customize it individual.
			 */
			wrapDigits: true,

			/**
			 * This option is for a callback function which is called in the initialization process.
			 */
			onInit: null,

			/**
			 * This option is for a callback function which is called BEFORE every recalculation of the countdown
			 * starts. The "timeout" or the "highspeedTimeout" option defines how often the calculation process will
			 * run.
			 */
			beforeCalculation: null,

			/**
			 * This option is for a callback function which is called AFTER every recalculation of the countdown
			 * was performed. The "timeout" or the "highspeedTimeout" option defines how often the calculation process
			 * will run.
			 */
			afterCalculation: null,

			/**
			 * This function is deprecated. It is currently available for compatibility reasons. In the next
			 * release (version 1.2) this callback function will be removed and you have to use "afterCalculation". See
			 * description above for more details.
			 */
			onCalculation: null,

			/**
			 * This option is for a callback function which is only called after a change in the countdown display is
			 * done, like a step from one second to another. This callback will be called after the calculation process.
			 */
			onChange: null,

			/**
			 * This option is for a callback function which is called when the target date is reached.
			 */
			onComplete: null
		};

	//The actual plugin constructor
	function Plugin (e, o) {
		this.element = e;
		this.settings = $.extend({}, def, o);
		this._defaults = def;
		this._name = p;
		this.targetDate = null;
		this.days = null;
		this.hours = null;
		this.minutes = null;
		this.seconds = null;
		this.milliseconds = null;
		this.deciseconds = null;
		this.intervalId = null;
		this.dim = 86400000;	//day in milliseconds
		this.him = 3600000;	//hour in milliseconds
		this.iim = 60000;	//minute in milliseconds
		this.seim = 1000;	//second in milliseconds
		this.deim = 100;	//deciseconds in milliseconds
		this.wrapsExists = new Array();	//used for intelligent DOM manipulation
		this.oldValues = new Array();	//used for intelligent DOM manipulation
		this.changed = false;
		this.init();
	}

	Plugin.prototype = {
		init: function() {
			//short handle
			var t = this,
				e = t.element,
				s = t.settings;

			//define for the use in callback
			//t.getOptions = function() {
			//	return t.getOptions();
			//};

			//set target date
			t.setTargetDate(new Date(
				s.year,
				s.month - 1,
				s.day,
				s.hour,
				s.minute,
				s.second
			));

			//set timeout lower if milliseconds are used
			if ($(e).find(s.decisecondsWrapper).length > 0 || $(e).find(s.millisecondsWrapper).length > 0) {
				s.timeout = s.highspeedTimeout;
			}

			//onInit callback
			if ($.isFunction(s.onInit)) {
				s.onInit.call(t);
			}

			//run countdown calculation repetitive
			t.intervalId = setInterval(function(){
				t.calculate();
			}, t.timeout);

			//run countdown calculation first time
			t.calculate();
		},
		calculate: function () {
			//short handle
			var t = this,
				s = t.settings,
				cDate = t.getCurrentDate(),
				tDate = t.getTargetDate(),
				dT = tDate - cDate,
				dTC = dT,
				dateReached = false;

			//callback beforeCalculation
			if ($.isFunction(s.beforeCalculation)) {
				s.beforeCalculation.call(t);
			}

			//set "changed" flag to false for this calculation step
			t.changed = false;

			var d = Math.floor(dTC / t.dim);
			dTC = dTC % t.dim;
			var h = Math.floor(dTC / t.him);
			dTC = dTC % t.him;
			var i = Math.floor(dTC / t.iim);
			dTC = dTC % t.iim;
			var se = Math.floor(dTC / t.seim),
				m = dTC % t.seim,
				ds = Math.floor(m / t.deim);

			//prevent negative values
			d = t.naturalNum(d);
			h = t.naturalNum(h);
			i = t.naturalNum(i);
			se = t.naturalNum(se);
			m = t.naturalNum(m);
			ds = t.naturalNum(ds);

			//save values
			t.days = d;
			t.hours = h;
			t.minutes = i;
			t.seconds = se;
			t.milliseconds = m;
			t.deciseconds = ds;

			//write values to DOM
			t.output();

			//is every displayed value zero
			if (Math.floor(dT / s.timeout) <= 0) {
				dateReached = true;
				if (s.millisecondsWrapper != null || s.decisecondsWrapper != null) {
					dateReached = (dT <= 0) ? true : false;
				}
			}

			//target date is reached
			if (dateReached == true) {
				//onComplete callback
				if ($.isFunction(s.onComplete)) {
					s.onComplete.call(t);
				}
				clearInterval(t.intervalId);
			}

			//callback onCalculation
			if ($.isFunction(s.onCalculation)) {
				s.onCalculation.call(t);
			}

			//callback afterCalculation
			if ($.isFunction(s.afterCalculation)) {
				s.afterCalculation.call(t);
			}
		},
		output: function () {
			//short handle
			var t = this,
				e = t.element,
				j = $(e),
				s = t.settings,
				d = t.days,
				h = t.hours,
				i = t.minutes,
				se = t.seconds,
				ds = t.deciseconds,
				m = t.milliseconds,
				sdL = s.dayLabel,
				shL = s.hourLabel,
				siL = s.minuteLabel,
				sseL = s.secondLabel,
				sdsL = s.decisecondLabel,
				smL = s.millisecondsLabel;

			//decide to use the singular or plural label
			var dL = (d == 1
				&& sdL !== null)
				? sdL : s.daysLabel,
			hL = (h == 1
				&& shL !== null)
				? shL : s.hoursLabel,
			iL = (i == 1
				&& siL !== null)
				? siL : s.minutesLabel,
			sL = (se == 1
				&& sseL !== null)
				? sseL : s.secondsLabel,
			dsL = (ds == 1
				&& sdsL !== null)
				? sdsL : s.decisecondsLabel,
			mL = (m == 1
				&& smL !== null)
				? smL : s.millisecondsLabel;

			//write time labels to DOM
			t.writeToDom(s.daysLabelWrapper, dL);
			t.writeToDom(s.hoursLabelWrapper, hL);
			t.writeToDom(s.minutesLabelWrapper, iL);
			t.writeToDom(s.secondsLabelWrapper, sL);
			t.writeToDom(s.decisecondsLabelWrapper, dsL);
			t.writeToDom(s.millisecondsLabelWrapper, mL);

			//force digits
			if (s.leftHandZeros == true) {
				h = t.strPad(h, 2);
				i = t.strPad(i, 2);
				se = t.strPad(se, 2);
				m = t.strPad(m, 3);
			}

			//wrap digits, if needed
			if (s.wrapDigits == true) {
				d = t.wrapChars(d, "ce-days-digit");
				h = t.wrapChars(h, "ce-hours-digit");
				i = t.wrapChars(i, "ce-minutes-digit");
				se = t.wrapChars(se, "ce-seconds-digit");
				ds = t.wrapChars(ds, "ce-dseconds-digit");
				m = t.wrapChars(m, "ce-mseconds-digit");
			}

			//write time values to DOM
			t.writeToDom(s.daysWrapper, d);
			t.writeToDom(s.hoursWrapper, h);
			t.writeToDom(s.minutesWrapper, i);
			t.writeToDom(s.secondsWrapper, se);
			t.writeToDom(s.decisecondsWrapper, ds);
			t.writeToDom(s.millisecondsWrapper, m);

			//onChange callback if anything has changed
			if ($.isFunction(s.onChange) && t.changed == true) {
				s.onChange.call(t);
			}
		},
		setTargetDate: function(d) {
			this.targetDate = d;
		},
		getTargetDate: function() {
			return this.targetDate;
		},
		getCurrentDate: function() {
			return new Date();
		},
		getOptions: function() {
			return this.settings;
		},
		naturalNum: function (i) {
			return (i < 0) ? 0 : i;
		},
		strPad: function (i, l, s) {
			var o = i.toString();
			if (!s) {
				s = '0';
			}
			while (o.length < l) {
				o = s + o;
			}
			return o;
		},
		wrapChars: function (s, c) {
			var t = "";
			s = s.toString();
			for (var i = 0; i < s.length; i++) {
				t += '<span class="' + c + '">' + s[i] + '</span>';
			}
			return t;
		},
		writeToDom: function(e, v) {
			var t = this,
				j = $(t.element),
				s = t.settings;

			//check if the element exists
			if (t.wrapsExists[e] == null) {
				if (j.find(e).length > 0) {
					t.wrapsExists[e] = true;
				} else {
					t.wrapsExists[e] = false;
				}
			}

			//new value and the wrapper exists
			if (t.oldValues[e] != v && t.wrapsExists[e]) {
				t.oldValues[e] = v;
				j.find(e).html(v);
				t.changed = true;	//needed for the onChange callback
			}
		}
	};

	//a really lightweight plugin wrapper around the constructor, preventing against multiple instantiations
	$.fn[p] = function(o) {
		return this.each(function() {
			var pr = "plugin_";
			if (!$.data(this, pr + p)) {
				$.data(this, pr + p, new Plugin(this, o));
			}
		});
	};
})(jQuery, window, document);