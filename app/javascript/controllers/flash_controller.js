import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    const flash = document.getElementById("flash");

    setTimeout(() => {
      flash.remove();
    }, 3500);
  }
}
