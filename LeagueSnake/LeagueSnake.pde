//*
// ***** SEGMENT CLASS *****
// This class will be used to represent each part of the moving snake.
//*

class Segment {

  //Add x and y member variables. They will hold the corner location of each segment of the snake.
  int x;
  int y;

  // Add a constructor with parameters to initialize each variable.
  Segment(int x, int y) {
    this.x = x;
    this.y = y;
  }
}


//*
// ***** GAME VARIABLES *****
// All the game variables that will be shared by the game methods are here
//*
ArrayList<Segment> tail = new ArrayList<Segment>();
Segment head;
int foodX;
int foodY;
int d = UP;
int foodEaten = 0;
int foodEatenNow;
//


//*
// ***** SETUP METHODS *****
// These methods are called at the start of the game.
//*

void setup() {
  frameRate(10);
  head = new Segment(400, 400);
  size(560, 560);
  dropFood();
}

//sasssss
void dropFood() {
  //Set the food in a new random location
  foodX = ((int)random(20)*20 + 80);
  foodY = ((int)random(20)*20 + 80);
}

//*
// ***** DRAW METHODS *****
// These methods are used to draw the snake and its food 
//*
//
void draw() {
  background(#050505);
  drawFood();
  move();
  drawSnake();
  //manageTail();
  eat();
}

void drawFood() {
  //Draw the food
  fill(#0D12FA);
  rect(foodX, foodY, 10, 10);
}

void drawSnake() {
  //Draw the head of the snake followed by its tail
  fill(#F70032);
  rect(head.x, head.y, 10, 10);
  manageTail();
}


//*
// ***** TAIL MANAGEMENT METHODS *****
// These methods make sure the tail is the correct length.
//*

void drawTail() {
  //Draw each segment of the taildw
  for (int i = 0; i < tail.size(); i++) {
    rect((tail.get(i).x), tail.get(i).y, 10, 10);
  }
}


void manageTail() {
  //After drawing the tail, add a new segment at the "start" of the tail and remove the one at the "end" 
  //This produces the illusion of the snake tail moving.
  checkTailCollision();
  drawTail();
  tail.add(new Segment(head.x, head.y));
  tail.remove(0);
}

void checkTailCollision() {
  //If the snake crosses its own tail, shrink the tail back to one segment
  for (int i = 0; i < tail.size(); i++) {
    if (head.x == tail.get(i).x &&  head.y == tail.get(i).y) {
      exit();
    }
  }
}

//*
// ***** CONTROL METHODS *****
// These methods are used to change what is happening to the snake
//*

void keyPressed() {
  //Set the direction of the snake according to the arrow keys pressed
  if (key == 'w') {
    d = UP;
  } else if (key == 's') {
    d = DOWN;
  } else if (key == 'a') {
    d = LEFT;
  } else if (key == 'd') {
    d = RIGHT;
  }
}

//
void move() {
  //Change thed location of the Snake head based on the direction it is moving.

  switch(d) {
  case UP:
    // move head up here 
    head.y -= 10;
    break;
  case DOWN:
    // move head down here 
    head.y += 10;
    break;
  case LEFT:
    // figure it out
    head.x -= 10;
    break;
  case RIGHT:
    // mystery code goes here 
    head.x += 10;
    break;
  }
  checkBoundaries();
}

void checkBoundaries() {
  //If the snake leaves the frame, make it reappear on the other side
  if (head.x <= 0) {
    exit();
  }
  if (head.y <= 0) {
    exit();
  }
  if (head.y >= 560) {
    exit();
  }//ss
  if (head.x >= 560) {
    exit();
  }
}
void eat() {
  //When the snake eats the food, its tail should grow and more food appears
  if (foodY == head.y && foodX == head.x) {
    dropFood();
    //foodEatenNow = foodEaten;
    foodEaten++;
    tail.add(new Segment(head.x, head.y));
    println(tail.size());
  }
}
