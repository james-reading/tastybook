import { Controller } from "stimulus";
import _ from "lodash";

export default class extends Controller {
  static targets = ["input"];

  initialize() {
    this.debouncedResize = _.debounce(this.resize, 100)
  }

  connect() {
    console.log("Connected to textarea-controller");

    this.inputTarget.style.overflow = "hidden";

    this.resize();
  }


  resize() {
    this.inputTarget.style.height = "auto"; // Force re-print before calculating the scrollHeight value.
    this.inputTarget.style.height =  `${this.inputTarget.scrollHeight}px`;
  }
}
