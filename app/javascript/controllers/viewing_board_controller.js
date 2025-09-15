import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  view(event){
    this.disableButtons();
    this.setUpBoard(event);
    this.enableButtons();
  }

  async setUpBoard(event){
    const id = event.target.getAttribute("data-board-id");
    let board = await this.fetchBoard(id);

    if(board == null){
      alert("An error has occurred. Please report this to us.");
      return;
    }

  }

  setCardsToBoard(cards){
    this.clearCards();
    
    cards.forEach((card) => {
      document.getElementById(card.position).style.backgroundColor = "red";
    });
  }

  clearCards(){
    let zones = this.board.querySelectorAll(".usable-zone");

    zones.forEach((zone) =>{
      zone.style.backgroundColor = "transparent";
    })
  }

  async fetchBoard(id){
    if(!Number.isInteger(Number(id)))
      return null;
    
    let data = null;

    try{
      const res = await fetch(`/api/v1/decks/specific_board?board_id=${id}`);
      data = await res.json();
    }
    catch{
      return null;
    }

    return data.board;
  }

  setBoardTitle(board_name){
    this.targets.find("board-name").textContent = board_name;
  }

  setSummons(board){
    this.targets.find("hand-summons").textContent = `Hand: ${board.hand_summons}`;
    this.targets.find("deck-summons").textContent = `Deck/Extra Deck: ${board.deck_summons}`;
    this.targets.find("gy-banishment-summons").textContent = `GY & Banishment: ${board.gy_banishment_summons}`;
  }

  disableButtons(){
    let board_options = this.view_board_options;

    board_options.style.pointerEvents = "none";
    board_options.style.opacity = "0.7";
  }

  enableButtons(){
    let board_options = this.view_board_options;

    board_options.style.pointerEvents = "all";
    board_options.style.opacity = "1";
  }

  get view_board_options(){
    return this.targets.find("view-board-options");
  }

  get board(){
    return this.targets.find("board");
  }
}