import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  async open(arg) {
    let tier = (arg instanceof Event) ? this.tier : arg; // if arg is event it means it was called by data-action, thus we need the this.tier value

    if(!["any", "1", "2", "3", "4", "5"].includes(tier))
      tier = "any";

    this.disableButton();
    await this.openDuelingBoard(tier);
    this.enableButton();
  }

  async openDuelingBoard(tier){
    let response = await this.getDeck(tier);
    if( response == null ){
      alert("An error occurred, please report this to us.");
      return null;
    }
    else if( response.error ){
      alert(response.error);
      return null;
    }
    // openboard
    const dueling_board = document.getElementById("dueling-overlay");
    const boardController = this.application.getControllerForElementAndIdentifier(dueling_board, "dueling-board");
    boardController.open(response.deck, { tier: tier });
  }

  async getDeck(tier){
    let data = null;

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
