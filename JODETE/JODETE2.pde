int cardWidth = 168;
int cardHeight = 243;
//based on the dimensions of the images
int screenWidth = 1440;
int screenHeight = 1365;
//for cardWidth = 168 and cardHeight = 243

//RESTART button
int buttonWidth = 150;
int buttonHeight = 50;
int buttonX = 50;
int buttonY = 80;

//PASS button
int button2Width = 100;
int button2Height = 50;
int button2X = 1100;
int button2Y =screenHeight/2-button2Height/2;


//type of deck
int suits = 4;
int elements = 13;
int jokers = 2;

//cards each player has at the start of the game
int initialPlayerCards = 5;

int turn = 0;
int userCards = 0;
int computerCards = 0;

int[][] deck = new int[suits*elements+jokers][2];
int[] activeDeck = new int[suits*elements+jokers];
int[] pile = new int[suits*elements+jokers];
int[] user = new int[suits*elements+jokers];
int[] computer = new int[suits*elements+jokers];

//card images
PImage[] cards = new PImage[56];

//first card, card that first player has to "match"
int pileCard;

int currentFrame;
boolean endGame = false;

void setup() {
  size(1440, 1365);

  //For suits = 4, elements = 13, and jokers = 2:
  //Initializes clubs (from A to K)
  cards[0] = loadImage("row-1-col-1.jpg");
  cards[1] = loadImage("row-1-col-2.jpg");
  cards[2] = loadImage("row-1-col-3.jpg");
  cards[3] = loadImage("row-1-col-4.jpg");
  cards[4] = loadImage("row-1-col-5.jpg");
  cards[5] = loadImage("row-1-col-6.jpg");
  cards[6] = loadImage("row-1-col-7.jpg");
  cards[7] = loadImage("row-1-col-8.jpg");
  cards[8] = loadImage("row-1-col-9.jpg");
  cards[9] = loadImage("row-1-col-10.jpg");
  cards[10] = loadImage("row-1-col-11.jpg");
  cards[11] = loadImage("row-1-col-12.jpg");
  cards[12] = loadImage("row-1-col-13.jpg");
  //Initializes diamonds (from A to K)
  cards[13] = loadImage("row-2-col-1.jpg");
  cards[14] = loadImage("row-2-col-2.jpg");
  cards[15] = loadImage("row-2-col-3.jpg");
  cards[16] = loadImage("row-2-col-4.jpg");
  cards[17] = loadImage("row-2-col-5.jpg");
  cards[18] = loadImage("row-2-col-6.jpg");
  cards[19] = loadImage("row-2-col-7.jpg");
  cards[20] = loadImage("row-2-col-8.jpg");
  cards[21] = loadImage("row-2-col-9.jpg");
  cards[22] = loadImage("row-2-col-10.jpg");
  cards[23] = loadImage("row-2-col-11.jpg");
  cards[24] = loadImage("row-2-col-12.jpg");
  cards[25] = loadImage("row-2-col-13.jpg");
  //Initializes hearts (from A to K)
  cards[26] = loadImage("row-3-col-1.jpg");
  cards[27] = loadImage("row-3-col-2.jpg");
  cards[28] = loadImage("row-3-col-3.jpg");
  cards[29] = loadImage("row-3-col-4.jpg");
  cards[30]= loadImage("row-3-col-5.jpg");
  cards[31] = loadImage("row-3-col-6.jpg");
  cards[32] = loadImage("row-3-col-7.jpg");
  cards[33] = loadImage("row-3-col-8.jpg");
  cards[34]= loadImage("row-3-col-9.jpg");
  cards[35] = loadImage("row-3-col-10.jpg");
  cards[36] = loadImage("row-3-col-11.jpg");
  cards[37] = loadImage("row-3-col-12.jpg");
  cards[38] = loadImage("row-3-col-13.jpg");
  //Initializes spades (from A to K)
  cards[39] = loadImage("row-4-col-1.jpg");
  cards[40] = loadImage("row-4-col-2.jpg");
  cards[41] = loadImage("row-4-col-3.jpg");
  cards[42] = loadImage("row-4-col-4.jpg");
  cards[43] = loadImage("row-4-col-5.jpg");
  cards[44] = loadImage("row-4-col-6.jpg");
  cards[45] = loadImage("row-4-col-7.jpg");
  cards[46] = loadImage("row-4-col-8.jpg");
  cards[47]= loadImage("row-4-col-9.jpg");
  cards[48] = loadImage("row-4-col-10.jpg");
  cards[49] = loadImage("row-4-col-11.jpg");
  cards[50] = loadImage("row-4-col-12.jpg");
  cards[51] = loadImage("row-4-col-13.jpg");
  //Initializes jokers (black and red) and card back
  cards[52] = loadImage("row-5-col-1.jpg");
  cards[53] = loadImage("row-5-col-2.jpg");
  cards[54] = loadImage("row-5-col-3.jpg");
  cards[55] = loadImage("row-5-col-4.jpg");

  //Creates deck
  //println("Deck:");
  for (int x=0; x<suits; x++) {
    for (int y=0; y<elements; y++) {
      deck[elements*x+y][0] = x+1;
      deck[elements*x+y][1] = y+1;
      //println("Card "+(elements*x+y+1)+": "+"["+deck[elements*x+y][0]+"]["+deck[elements*x+y][1]+"]");
    }
  }
  for (int z=0; z<jokers; z++) {
    deck[suits*elements+z][0] = 0;
    deck[suits*elements+z][1] = z;
    //println("Card "+(suits*elements+z+1)+": "+"["+deck[suits*elements+z][0]+"]["+deck[suits*elements+z][1]+"]");
  }
  
  //Creates active deck / Creates pile, user cards, and computer cards with -1 values ("control" method)
  for(int x=0; x<(suits*elements+jokers); x++){
    activeDeck[x] = x;
    pile[x] = -1;
    user[x] = -1;
    computer[x] = -1;
  }
  drawCard(1);
  drawPlayerCards();
}

void drawCard(int event){
  //Takes card from active deck and places it on pile/user cards
  int deckCard = (int)random(suits*elements);
  while(activeDeck[deckCard] == -1){
    deckCard = (int)random(suits*elements);
  }
  activeDeck[deckCard] = -1;
  for(int x=0; x<(suits*elements+jokers); x++){
    if(event == 1){
      if(pile[x] == -1){
        pile[x] = deckCard;
        pileCard = deckCard;
        break;
      }
    }
    else if(event == 2){
      if(activeDeck[x] == -1){
        user[userCards] = deckCard;
        break;
      }
    }
    else{
      if(activeDeck[x] == -1){
        computer[computerCards] = deckCard;
        currentFrame = frameCount;
        break;
      }
    }
  }
  //println(pile);
  //println("Active deck: ");
  //println(activeDeck);
}

void drawPlayerCards(){
  //Takes 10 cards from active deck and gives them to players, five cards each
  for(int x=0; x<(initialPlayerCards*2); x++){
    int deckCard = (int)random(suits*elements+1);
    while(activeDeck[deckCard] == -1){
      deckCard = (int)random(suits*elements+1);
    }
    activeDeck[deckCard] = -1;
    for(int y=0; y<(suits*elements+jokers); y++){
      if(y < initialPlayerCards){
        if(user[y] == -1){
          user[y] = deckCard;
          break;
        }
      }
      else{
        if(computer[y-initialPlayerCards] == -1){
          computer[y-initialPlayerCards] = deckCard;
          break;
        }
      }
    }
  }
  //println("User: ");
  //println(user);
  //println("Computer: ");
  //println(computer);
}

void reorganizeCards(int index, int event){
  if(event == 1){
    for(int x=index; x<userCards; x++){
      if(x<userCards-1){
        user[x] = user[x+1];
      }
      else{
        user[x] = -1;
      }
    }
    userCards--;
    if(userCards == 0){
      endGame = true;
    }
  }
  else{
    for(int x=index; x<computerCards; x++){
      if(x<computerCards-1){
        computer[x] = computer[x+1];
      }
      else{
         computer[x] = -1;
      }
    }
    computerCards--;
    if(computerCards == 0){
      endGame = true;
    }
  }
}

void showUserCards(){
  int selectedCard = -1;
  int cardX;
  int nextCardX;
  for(int x=0; x<userCards; x++){
    if(userCards<6){
      cardX = 300+cardWidth*x;
    }
    else{
      cardX = 300+((screenWidth-600)/userCards)*x;
    }
    if(x!=(userCards-1) && userCards>=6){
      nextCardX = 300+((screenWidth-600)/userCards)*(x+1);
    }
    else{
      nextCardX = cardX + cardWidth;
    }
    if(mouseX>=cardX && mouseX<=nextCardX && mouseY>=(cardHeight*4+75) && mouseY<=(cardHeight*5+75)){
      selectedCard = x;
      break;
    }
  }
  for(int y=0; y<userCards; y++){
    int userPositionX;
    if(userCards<6){
      userPositionX = 300+cardWidth*y;
    }
    else{
      userPositionX = 300+((screenWidth-600)/userCards)*y;
    }
    if(selectedCard!=y){
      image(cards[user[y]], userPositionX, cardHeight*4+75);
    }
    else{
     image(cards[user[y]], userPositionX, cardHeight*4);
     if(mousePressed && ((deck[user[y]][0] == deck[pileCard][0] || deck[user[y]][1] == deck[pileCard][1]) || deck[user[y]][0] == 0 || deck[pileCard][0] == 0)){
       pileCard = user[y];
       turn++;
       currentFrame = frameCount;
       reorganizeCards(y, 1);
       break;
     } 
    }
  }
}

void computerPlay(){
  boolean move = false;
  if(frameCount == currentFrame + 80){
    for(int x=0; x<computerCards; x++){
      if(deck[computer[x]][0] == deck[pileCard][0] || deck[computer[x]][1] == deck[pileCard][1] || deck[computer[x]][0] == 0 || deck[pileCard][0] == 0){
        move = true;
        pileCard = computer[x];
        turn++;
        reorganizeCards(x, 2);
        break;
      }
    }
    if(move == false){
      int chance = (int)random(2);
      println(chance);
      if(chance==0){
        drawCard(3);
      }
      else{
        turn++;
      }
    }
  }
}

void mousePressed(){
  //mouse pressed on RESTART
  if(mouseX>=buttonX && mouseX<=(buttonX+buttonWidth) && mouseY>=buttonY && mouseY<=(buttonY+buttonHeight)){
    turn = 0;
    if(endGame){
      endGame = false;
    }
    setup();
  }
  if(turn%2==0){
    //mouse pressed on PASS
    if(mouseX>=button2X && mouseX<=(button2X+button2Width) && mouseY>=button2Y && mouseY<=(button2Y+button2Height)){
      turn++;
      currentFrame = frameCount;
    }
    //mouse pressed on deck card
    if(mouseX>=cardWidth*3+300 && mouseX<=cardWidth*4+300 && mouseY>=cardHeight*2+75 && mouseY<=cardHeight*3+75){
      drawCard(2);
    }
  }
}

void draw() {
  background(0, 51, 102);
  textAlign(CENTER);
  
  //RESTART button
  fill(255);
  stroke(0);
  rect(buttonX, buttonY, buttonWidth, buttonHeight);
  fill(0);
  textSize(30);
  text("RESTART",buttonX+buttonWidth/2,buttonY+35);
  
  //mouse on RESTART
  if(mouseX>=buttonX && mouseX<=(buttonX+buttonWidth) && mouseY>=buttonY && mouseY<=(buttonY+buttonHeight)){
     //RESTART button
    fill(211);
    stroke(0);
    rect(buttonX, buttonY, buttonWidth, buttonHeight);
    fill(0);
    textSize(30);
    text("RESTART",buttonX+buttonWidth/2,buttonY+35); 
  }
  
  if(endGame){
    fill(255);
    textSize(100);
    text("END",screenWidth/2,screenHeight/2);
  }
  else{
    //PASS button
    fill(255);
    stroke(0);
    rect(button2X, button2Y, button2Width, button2Height);
    fill(0);
    textSize(30);
    text("PASS",button2X+button2Width/2,button2Y+35);
    
    userCards = 0;
    computerCards = 0;
    
    //Count how many cards each player has
    for(int x=0; x<(suits*elements+jokers); x++){
      if(user[x] != -1){
        userCards++;
      }
      if(computer[x] != -1){
        computerCards++;
      }
    }
    
    for(int x=0; x<computerCards; x++){
      int computerPositionX;
      if(computerCards<6){
        computerPositionX = 300+cardWidth*x;
      }
      else{
        computerPositionX = 300+((screenWidth-600)/computerCards)*x;
      }
      image(cards[54], computerPositionX, 75);
    }
    
    //Show active deck and pile cards
    image(cards[pileCard], cardWidth*1 + 300, cardHeight*2+75);
    image(cards[54], cardWidth*3 + 300, cardHeight*2+75);
    
    if(turn%2==0){
      fill(241,245,133);
      textSize(30);
      text("USER's turn",screenWidth/2,screenHeight-(screenHeight/5*1.5));
      //mouse on PASS
      if(mouseX>=button2X && mouseX<=(button2X+button2Width) && mouseY>=button2Y && mouseY<=(button2Y+button2Height)){
        fill(211);
        stroke(0);
        rect(button2X, button2Y, button2Width, button2Height);
        fill(0);
        textSize(30);
        text("PASS",button2X+button2Width/2,button2Y+35);
      }
      if(mouseX>=cardWidth*3 + 300 && mouseX<=cardWidth*4 + 300 && mouseY>=cardHeight*2+75 && mouseY<=cardHeight*3+75){
        image(cards[55], cardWidth*3 + 300, cardHeight*2+75);
      }
      showUserCards();
    }
    else{
      fill(241,245,133);
      textSize(30);
      text("COMPUTER's turn",screenWidth/2,screenHeight/5*1.5);
      //Show player cards
      for(int x=0; x<userCards; x++){
        int userPositionX;
        if(userCards<6){
          userPositionX = 300+cardWidth*x;
        }
        else{
          userPositionX = 300+((screenWidth-600)/userCards)*x;
        }
        image(cards[user[x]], userPositionX, cardHeight*4+75);
      }
      computerPlay();
    }
  }
}
