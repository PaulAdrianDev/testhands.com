import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    window.decks_table = this.decks_table;
    console.log(decks_table);
  }
  
  search_decks(){
    let query = this.query
    
    for(let i = 0; i < decks_table.children.length; i++){
      let deck = decks_table.children[i];
      let search_target = deck;
      if(deck.firstChild)
        search_target = deck.querySelector(".search_target");
      
      console.log(search_target.innerHTML.toLowerCase().includes(query.toLowerCase()));
      console.log(search_target.innerHTML.toLowerCase());
      console.log(query.toLowerCase()); 
      if(search_target.innerHTML.toLowerCase().includes(query.toLowerCase()))
        deck.style.display = "inline-block";
      else
        deck.style.display = "none";
    }
  }

  async open(arg) {
    const archetype_id = (arg instanceof Event) ? arg.target.value : arg; // if arg is event it means it was called by data-action, thus we need the this.tier value

    this.disableDecksTable();
    await this.openDuelingBoard(archetype_id);
    this.enableDecksTable();
  }

  async openDuelingBoard(archetype_id){
    let response = await this.getDeck(archetype_id);
    if( response == null ){
      alert("An error occurred, please report this to us.");
      return null;
    }
    else if( response.error ){
      alert(response.error);
      return null;
    }

    const dueling_board = document.getElementById("dueling-overlay");
    const boardController = this.application.getControllerForElementAndIdentifier(dueling_board, "dueling-board");
    boardController.open(response.deck, { archetype_id: archetype_id });
  }

  async getDeck(archetype_id){
    let data = null;
    let url = `/api/v1/decks/random?archetype_id=${archetype_id}`;
    let curr_deck_id = parseInt(sessionStorage.getItem("current_deck_id"), 10);

    if(Number.isInteger(curr_deck_id))
      url = `${url}&except=${curr_deck_id}`; // in future if i want to exclude many previously fought decks make it here

    try{
      let res = await fetch(url);
      data = await res.json();
    }
    catch(e){
      return null;
    }
    
    return data;
  }

  disableDecksTable(){
    let btn = document.getElementById("decks-table");
    btn.style.pointerEvents = "none";
    btn.style.cursor = "wait";
  }

  enableDecksTable(){
    let btn = document.getElementById("decks-table");
    btn.style.pointerEvents = "all";
    btn.style.cursor = "pointer";
  }

  get tier(){
    return this.targets.find("tier").value;
  }


  get query() {
    return this.targets.find("query").value;
  }

  get decks_table() {
    return this.targets.find("decks_table");
  }
}
