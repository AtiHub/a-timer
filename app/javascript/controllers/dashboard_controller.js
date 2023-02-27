import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "sessionsFrame",
    "sessionsSelect",
    "recordFrame",
    "recordForm",
    "recordTimeInput",
    "recordSessionIdInput",
    "recordScrambleInput",
    "scrambleFrame",
    "scrambleCategorySelect",
    "scrambleContainer",
    "timerContainer"
  ]

  hi(){
    console.log("Hello, Stimulus!");
  }

  goToSelectedSession() {
    let container = this.sessionsFrameTarget;
    let select = this.sessionsSelectTarget;

    let url = "/sessions?selected_session_id=" + select.value;

    container.src = url;
    container.reload();
  }

  beforeSubmitRecord() {
    this.recordSessionIdInputTarget.value = this.sessionsSelectTarget.value;
    this.recordScrambleInputTarget.value = this.scrambleContainerTarget.innerHTML.trim();
  }

  afterSubmitRecord() {
    this.recordTimeInputTarget.value = "";
    this.changeScrambleCategory();
  }

  changeScrambleCategory() {
    let container = this.scrambleFrameTarget;
    let select = this.scrambleCategorySelectTarget;

    let url = "/scrambles?category=" + select.value;

    container.src = url;
    container.reload();
  }

  // KEY PRESS

  key(event) {
    if(event.keyCode == 32) { // space
      this.timerAction();
    }
  }

  // TIMER METHODS

  static timerStatuses = ['standby', 'running'];
  interval;
  timerStartAt;
  timeDiff;

  timerAction() {
    let timerContainer = this.timerContainerTarget;

    if(timerContainer.dataset.timerStatus == "standby") {
      timerContainer.dataset.timerStatus = "running";
      this.startTimer();
    } else {
      timerContainer.dataset.timerStatus = "standby";
      this.stopTimer();
    }
  }

  startTimer() {
    this.timerStartAt = Date.now();
    this.timeDiff = 0;
    this.interval = setInterval(() => { this.timer(); }, 10);
  }

  stopTimer() {
    clearInterval(this.interval);
    this.submitRecord()
    this.timerContainerTarget.textContent = this.timerFormat('standby');
  }

  timer() {
    this.timeDiff = Date.now() - this.timerStartAt;

    this.timerContainerTarget.textContent = this.timerFormat();
  }

  timerFormat(format = 'running') {
    var msec = Math.floor(this.timeDiff % 1000).toString();
    var sec = Math.floor((this.timeDiff / 1000) % 60).toString();
    var min = Math.floor((this.timeDiff / 1000 / 60) % 60).toString();

    if(msec.length == 2) {
      msec = format == "running" ? "0" : ("0" + msec.substring(0, 1))
    } else {
      msec = format == "running" ? msec.substring(0, 1) : msec.substring(0, 2)
    }

    if(min != "0") {
      sec = sec.length == 1 ? ("0" + sec) : sec;
    }

    var chrono = [sec, msec].join('.');
    if(min != "0") { chrono = min + ":" + chrono; }

    // console.log(chrono);
    return chrono;
  }

  submitRecord() {
    this.recordTimeInputTarget.value = this.timeDiff;
    this.recordFormTarget.requestSubmit();
  }
}
