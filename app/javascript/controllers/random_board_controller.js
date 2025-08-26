import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  async open() {
    this.disableButton();
    await this.openDuelingBoard();
    this.enableButton();
  }

  async openDuelingBoard(){
    let response = await this.getDeck();
    if( response == null ){
      alert("An error occurred, please report this to us.");
      return null;
    }
    // openboard
    const dueling_board = document.getElementById("dueling-overlay");
    const boardController = this.application.getControllerForElementAndIdentifier(dueling_board, "dueling-board");
    boardController.open(response.deck);
  }

  async getDeck(){
    let data = null;
    let tier = this.tier;

    try{
      let res = await fetch(`/api/v1/decks/random?tier=${tier}`);
      data = await res.json();
    }
    catch(e){
      return null;
    }
    return data;
  }

  disableButton(){
    let btn = document.getElementById("generate-board-btn");
    btn.style.pointerEvents = "none";
    btn.style.backgroundColor = "#586066";
    btn.style.cursor = "wait";
  }

  enableButton(){
    let btn = document.getElementById("generate-board-btn");
    btn.style.pointerEvents = "all";
    btn.style.backgroundColor = "var(--bs-btn-bg)";
    btn.style.cursor = "pointer";
  }

  get tier(){
    return this.targets.find("tier").value;
  }
}
