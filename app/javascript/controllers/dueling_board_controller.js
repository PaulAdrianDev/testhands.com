import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect(){
    window.deck_history = {};
    sessionStorage.setItem("current_deck_id", 0);
    window.consistent_information = {}; // tier, deck, user
  }

  open(deck, info){
    deck_history[deck.id] = deck;
    consistent_information = info;
    this.openOverlay();
    this.setUpOverlay(deck);
  } 
  setUpOverlay(deck){
    sessionStorage.setItem("current_deck_id", deck.id);
    this.closeCardDetails();
    this.setTitle(deck.archetypes);
    this.setBoardType("Full Combo 1");
    this.setUsername(deck.user.username);
    this.setAdvice(deck.advice);
    this.addBoardsAndOptions(deck.boards);
    this.addToDeckHistory(deck);
  }

  addBoardsAndOptions(boards){
    this.options.innerHTML = ""; // clear past children

    boards.forEach((board) =>{
      this.addOptionFor(board);
      if(board.board_type.name == "Full Combo 1")
        this.addCardsFor(board);
    });
  }

  changeBoard(board_id){
    let board = JSON.parse(sessionStorage.getItem(board_id));
    this.setBoardType(board.board_type.name);
    this.addCardsFor(board);
  }

  addCardsFor(board){
    this.removeAllCards();
    let zones_used = [];
    
    board.board_cards.forEach((card_and_position) => {
      let zone = document.getElementById(card_and_position.position);
      let card = card_and_position.card;

      let card_image = document.createElement("img");
      card_image.src = this.element.dataset.cardImageUrl;
      card_image.setAttribute("data-card-name", card.name);
      card_image.setAttribute("data-card-description", card.description); 
      card_image.addEventListener("click", (event) => { this.openCardDetails(event.target) }) // here make an overlay

      zone.appendChild(card_image);
      zones_used.push(card_and_position.position); 
    })

    this.addInvisibleCardsToEmptyRows(zones_used);
  }

  addInvisibleCardsToEmptyRows(zones){ // this is needed because the table td's have set width but no height, if a row doesn't have a single card in it then the whole row becomes height 0
    let table_rows = this.board.querySelectorAll("tr");
    let cards_in_row = [false, false, false, false]

    zones.forEach((zone) => {
      if(zone.includes("emz") || zone == "banishment")
        cards_in_row[0] = true;
      else if(zone.includes("mmz") || zone == "field" || zone == "graveyard")
        cards_in_row[1] = true;
      else if(zone.includes("stz") || zone == "deck" || zone == "extra-deck")
        cards_in_row[2] = true;
      else
        cards_in_row[3] = true;
    });
    
    let invisible_card = document.createElement("img");
    invisible_card.src = this.element.dataset.cardImageUrl;
    invisible_card.style.opacity = 0;
    invisible_card.style.pointerEvents = "none";
    
    for(let i = 0; i < cards_in_row.length; i++)
      if(cards_in_row[i] == false)
        table_rows[i].querySelector(".usable-zone").appendChild(invisible_card.cloneNode(false));
  }

  removeAllCards(){
    let zones = document.querySelectorAll(".usable-zone");

    zones.forEach((zone) => {
      while(zone.firstChild)
        zone.removeChild(zone.lastChild);
    })
  }

  openCardDetails(card){
    this.card_details.style.pointerEvents = "all";
    this.card_details.style.opacity = "1";
    this.card_details.style.top = `${card.getBoundingClientRect().bottom - this.board.getBoundingClientRect().top}px`;
    
    this.card_details_name.textContent = card.getAttribute("data-card-name");
    this.card_details_description.textContent = card.getAttribute("data-card-description");
  }

  closeCardDetails(){
    this.card_details.style.opacity = "0";
    this.card_details.style.pointerEvents = "none";
  }

  addOptionFor(board){
    let newOption = document.createElement("input");
    newOption.type = "radio";
    newOption.id = "board" + board.id;
    newOption.value = board.id;
    newOption.name = "board_select";
    newOption.classList.add("me-2");
    newOption.style.cursor = "pointer";
    newOption.style.transform = "scale(1.3)";
    if(board.board_type.name == "Full Combo 1")
      newOption.checked = true;

    newOption.addEventListener("click", (event) => { this.changeBoard(event.target.id) });

    sessionStorage.setItem(newOption.id, JSON.stringify(board));

    let newOptionLabel = document.createElement("label");
    newOptionLabel.for = newOption.id;
    newOptionLabel.textContent = board.board_type.name;

    let div = document.createElement("div");
    div.appendChild(newOption);
    div.appendChild(newOptionLabel);

    this.options.appendChild(div);
  }

  openOverlay(){
    document.getElementById("dueling-overlay").scrollIntoView();
    let overlay = this.overlay;
    overlay.style.pointerEvents = "all";
    overlay.style.opacity = "1";
  }

  setTitle(archetypes){
    let title = "";

    archetypes.forEach((archetype) => {
      title += archetype.name;
    });

    this.title.textContent = title;
  }

  setBoardType(name){
    this.board_type.textContent = name;
  }

  setUsername(username){
    this.username.textContent = "- by " + username;
  }

  setAdvice(advice){
    this.removePreviousAdvice();
    if(advice){
      this.advice_title.textContent = "Creator's Advice:";
      this.advice.textContent = advice;
    }
  }

  removePreviousAdvice(){
    this.advice_title.textContent = "";
    this.advice.textContent = "";
  }

  flip(){
    let outerDiv = this.targets.find("board-outer-div");

    if(outerDiv.style.transform == "scaleY(-1)")
      outerDiv.style.transform = "scaleY(1)";
    else
      outerDiv.style.transform = "scaleY(-1)";
  } 

  close(){
    sessionStorage.setItem("current_deck_id", 0);
    let overlay = this.overlay;
    overlay.style.pointerEvents = "none";
    overlay.style.opacity = "0";
  }

  addToDeckHistory(deck){
    let title = "";
    deck.archetypes.forEach((archetype) => {
      title += archetype.name;
    });
    title += ` - by ${deck.user.username}`;
    let new_deck = document.createElement("p");
    new_deck.textContent = title;
    new_deck.setAttribute("data-deck-id", deck.id);
    new_deck.classList.add("data-deck-history-deck");
    new_deck.addEventListener("click", (event) => { this.rematchDeck(event.target.getAttribute("data-deck-id")) })

    this.deck_history_div.appendChild(new_deck);
  }

  rematchDeck(deck_id){
    window.scrollTo(0, 0);
    if(current_deck_id() != deck_id)
      this.setUpOverlay(deck_history[deck_id]);
  }

  async newDeck(){
    switch(Object.keys(consistent_information)[0]){
      case "tier":
        const random_deck = document.getElementById("random-deck-tab");
        const randomController = this.application.getControllerForElementAndIdentifier(random_deck, "random-board");
        randomController.open(consistent_information.tier);
      break;
    }
  }

  current_deck_id(){
    return sessionStorage.getItem("current_deck_id");
  }

  get overlay(){
    return this.targets.find("overlay");
  }

  get title(){
    return this.targets.find("title");
  }

  get board_type(){
    return this.targets.find("board-type");
  }

  get username(){
    return this.targets.find("username");
  }

  get advice_title(){
    return this.targets.find("advice-title");
  }

  get advice(){
    return this.targets.find("advice");
  }

  get options(){
    return this.targets.find("options");
  }

  get board(){
    return this.targets.find("board");
  }
  
  get deck_history_div(){
    return this.targets.find("deck-history");
  }

  get card_details(){
    return this.targets.find("card-details");
  }

  get card_details_name(){
    return this.targets.find("card-details-name");
  }

  get card_details_description(){
    return this.targets.find("card-details-description");
  }
}