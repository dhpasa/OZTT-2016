/*
* jQuery-Simple-Timer
*
* Creates a countdown timer.
*
* Example:
*   $('.timer').startTimer();
*
*/
(function($){

  var timer;

  var Timer = function(targetElement){
    this.targetElement = targetElement;
    return this;
  };

  Timer.start = function(options, targetElement){
    timer = new Timer(targetElement);
    return timer.start(options);
  };

  Timer.prototype.start = function(options) {

    var createSubDivs = function(timerBoxElement){
      
      var seconds_1 = document.createElement('div');
      seconds_1.className = 'seconds-1';
      
      var seconds_2 = document.createElement('div');
      seconds_2.className = 'seconds-2';

      var minutes_1 = document.createElement('div');
      minutes_1.className = 'minutes-1';
      
      var minutes_2 = document.createElement('div');
      minutes_2.className = 'minutes-2';

      var hours_1 = document.createElement('div');
      hours_1.className = 'hours-1';
      
      var hours_2 = document.createElement('div');
      hours_2.className = 'hours-2';
      
      var splitTime_1 = document.createElement('div');
      splitTime_1.className = 'splitTime-1';
      
      var splitTime_2 = document.createElement('div');
      splitTime_2.className = 'splitTime-2';

      var clearDiv = document.createElement('div');
      clearDiv.className = 'clearDiv';

      return timerBoxElement.
        append(hours_1).
        append(hours_2).
        append(splitTime_1).
        append(minutes_1).
        append(minutes_2).
        append(splitTime_2).
        append(seconds_1).
        append(seconds_2).
        append(clearDiv);
    };

    this.targetElement.each(function(_index, timerBox) {
      var timerBoxElement = $(timerBox);
      var cssClassSnapshot = timerBoxElement.attr('class');

      timerBoxElement.on('complete', function() {
        clearInterval(timerBoxElement.intervalId);
      });

      timerBoxElement.on('complete', function() {
        timerBoxElement.onComplete(timerBoxElement);
      });

      timerBoxElement.on('complete', function(){
        timerBoxElement.addClass('timeout');
      });

      timerBoxElement.on('complete', function(){
        if(options && options.loop === true) {
          timer.resetTimer(timerBoxElement, options, cssClassSnapshot);
        }
      });

      createSubDivs(timerBoxElement);
      return this.startCountdown(timerBoxElement, options);
    }.bind(this));
  };

  /**
   * Resets timer and add css class 'loop' to indicate the timer is in a loop.
   * $timerBox {jQuery object} - The timer element
   * options {object} - The options for the timer
   * css - The original css of the element
   */
  Timer.prototype.resetTimer = function($timerBox, options, css) {
    var interval = 0;
    if(options.loopInterval) {
      interval = parseInt(options.loopInterval, 10) * 1000;
    }
    setTimeout(function() {
      $timerBox.trigger('reset');
      $timerBox.attr('class', css + ' loop');
      timer.startCountdown($timerBox, options);
    }, interval);
  }

  Timer.prototype.fetchSecondsLeft = function(element){
    var secondsLeft = element.data('seconds-left');
    var minutesLeft = element.data('minutes-left');

    if(secondsLeft){
      return parseInt(secondsLeft, 10);
    } else if(minutesLeft) {
      return parseFloat(minutesLeft) * 60;
    }else {
      throw 'Missing time data';
    }
  };

  Timer.prototype.startCountdown = function(element, options) {
    options = options || {};

    var intervalId = null;
    var defaultComplete = function(){
      clearInterval(intervalId);
      return this.clearTimer(element);
    }.bind(this);

    element.onComplete = options.onComplete || defaultComplete;

    var secondsLeft = this.fetchSecondsLeft(element);

    var refreshRate = options.refreshRate || 1000;
    var endTime = secondsLeft + this.currentTime();
    var timeLeft = endTime - this.currentTime();
    var finalValues = this.formatTimeLeft(timeLeft);
    this.setFinalValue(finalValues, element);

    intervalId = setInterval((function() {
      timeLeft = endTime - this.currentTime();
      this.setFinalValue(this.formatTimeLeft(timeLeft), element);
    }.bind(this)), refreshRate);

    element.intervalId = intervalId;
  };

  Timer.prototype.clearTimer = function(element){
    element.find('.seconds-1').text('0');
    element.find('.seconds-2').text('0');
    element.find('.minutes-1').text('0');
    element.find('.minutes-2').text('0');
    element.find('.hours-1').text('0');
    element.find('.hours-2').text('0');
    element.find('.splitTime').text(':');
  };

  Timer.prototype.currentTime = function() {
    return Math.round((new Date()).getTime() / 1000);
  };

  Timer.prototype.formatTimeLeft = function(timeLeft) {

    var lpad = function(n, width) {
      width = width || 2;
      n = n + '';

      var padded = null;

      if (n.length >= width) {
        padded = n;
      } else {
        padded = Array(width - n.length + 1).join(0) + n;
      }

      return padded;
    };

    var hours, minutes, remaining, seconds;
    remaining = new Date(timeLeft * 1000);
    hours = remaining.getUTCHours();
    minutes = remaining.getUTCMinutes();
    seconds = remaining.getUTCSeconds();

    if (+hours === 0 && +minutes === 0 && +seconds === 0) {
      return '';
    } else {
      var lpadStr = lpad(hours)+lpad(minutes)+lpad(seconds)+'';
      return lpadStr;
    }
  };

  Timer.prototype.setFinalValue = function(finalValues, element) {

    if(finalValues.length === 0){
      this.clearTimer(element);
      element.trigger('complete');
      return false;
    }
    element.find('.hours-1').text(finalValues.substring(0,1));
    element.find('.hours-2').text(finalValues.substring(1,2));
    element.find('.minutes-1').text(finalValues.substring(2,3));
    element.find('.minutes-2').text(finalValues.substring(3,4));
    element.find('.seconds-1').text(finalValues.substring(4,5));
    element.find('.seconds-2').text(finalValues.substring(5));
    element.find('.splitTime-1').text(':');
    element.find('.splitTime-2').text(':');
  };


  $.fn.startOtherTimer = function(options) {
    Timer.start(options, this);
    return this;
  };
})(jQuery);
