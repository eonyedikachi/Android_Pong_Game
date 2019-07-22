
//ScreenWdith= 1280, ScreenHeight = 720

float screenWidth = width; //set to your screen width using system variable
float screenHeight = height; //set to your screen height using system variable

float rectXLeft = 0; //X-position of left paddle
float rectYLeft = 0; //Y-position of left paddle

float rectWidth = 30; //Width of all paddles
float rectHeight = 170; //Height of all paddles

float rectXRight = width-rectWidth; //X-position of paddles width - 1250
float rectYRight = height - rectHeight; //Y-position of paddles height - 550

int ballX = 640; //X-postion of ball is ScreenWidth/2
int ballY = 360; //Y-position of ball is ScreenHeight/2
int ballWidth = 30; //Width of ball
int ballHeight = 30; //Height of ball
int xSpeed = 5; //ball's horizontal speed
int ySpeed = 5; //ball's vertical speed
int radius =15; // half of ball width and height since they are same

int scoreLeftPlayerX = 450; // X-position of left player score
int scoreLeftPlayerY = 360; //Y-position of left player score
int scoreRightPlayerX = 800; // X-position of right player score
int scoreRightPlayerY = 360; //Y-position of right player score
int scoreTextSize = 50; //score text size
int scoreLeftPlayer = 0; //initialise left player score
int scoreRightPlayer = 0; //initialise right player score

boolean gameOn; //hold boolean value to determine when to start game

boolean hasOverlappedLeftPaddle = false;
boolean hasOverlappedRightPaddle = false;

void setup() //runs once
{
fullScreen(); //Sets the program to run in full screen mode
}

void draw() //runs forever
{

background(0,190,200); //set backgorund colour, you can use any colour

displayPaddles(rectXLeft, rectYLeft, rectWidth, rectHeight);// display left paddle
displayPaddles(rectXRight, rectYRight, rectWidth, rectHeight);// display right paddle

displayBall(ballX, ballY, ballWidth, ballHeight); // call function to display ball

displayScore(scoreLeftPlayer, scoreLeftPlayerX, scoreLeftPlayerY); //left player score
displayScore(scoreRightPlayer, scoreRightPlayerX, scoreRightPlayerY); //  right player score

gameOn = setGameMode(); // start game if screen is pressed
moveBall(); //move ball if game is on
checkWall(); //checks walls and determine which player score a point

movePaddle(); //function to move paddles when screen is touched
checkLeftPaddle(); // call function to check left paddle and ball overlap
checkRightPaddle();// call function to check right paddle and ball overlap
}//end of draw function


//function to draw paddles
void displayPaddles(float a, float b, float c, float d)
{

fill(255,120,20); //set green as paddles colour
stroke(0, 255, 0); //sets the paddles outline colour to green

rect(a, b, c, d); //draw paddle
}//end of displayPaddles function
 

//draw ball
void displayBall(int a, int b, int c, int d)
{
fill(255); //set ball and text colour to white
stroke(255); //sets the ball and text outline colour
ellipse(a, b, c, d); //draw ball with the specified parameters
} //end of display ball function


// show players score
void displayScore(int a, int b, int c)
{
fill(255); //text colour to white
stroke(255);//outline colour of text
textSize(scoreTextSize); //set score text size
text(a, b, c); //Player Score
}// end of show score function


//Check if mouse is pressed, set gameOn to true
boolean setGameMode()
{
if (mousePressed) { //check if screen was touched

  gameOn = true;
}
return gameOn;
}//end of game mode function


//move ball
void moveBall()
{
if (gameOn) {
ballX = ballX+xSpeed;
ballY = ballY+ySpeed;
}
}//end of move ball function


//check the wall ball hit and increament player score accordingly
void checkWall()
{

//Check if ball hits top or bottom walls
if ((ballY-radius < 0) || (ballY+radius) > screenHeight) {
ySpeed = ySpeed * -1; //Reverse direction
}

//Check if ball hits left or right walls
if ((ballX+radius) > screenWidth) {
gameOn = false;

//move ball back to center
ballX =640; 
ballY = 360;
scoreLeftPlayer = scoreLeftPlayer + 1; //increase left player score by 1
} else if (ballX-radius < 0) 
{
gameOn = false;

//move ball back to center
ballX = 640;
ballY = 360;
scoreRightPlayer = scoreRightPlayer + 1; //increase right player score by 1
}
}// end of check wall functio

 
//Check if there is an overlap between ball and left paddle
void checkLeftPaddle()
{
hasOverlappedLeftPaddle = doesOverlap(rectXLeft, rectYLeft, rectWidth, rectHeight, ballX, ballY, radius);
if (hasOverlappedLeftPaddle) {
xSpeed = xSpeed *-1;// reverse direction
}
}// end of check left paddle function


//Check if there is an overlap between ball and right paddle
void checkRightPaddle()
{
hasOverlappedRightPaddle = doesOverlap(rectXRight, rectYRight, rectWidth,
rectHeight, ballX, ballY, radius);
if (hasOverlappedRightPaddle) {
xSpeed = xSpeed *-1; //reverse direction
}
}// end of check right paddle function


//move paddle
void movePaddle()
{
//move left or right paddle when corresponding side of screen is touched
if (mouseX < (screenWidth/2)){
rectYLeft = constrain(mouseY, rectXLeft,screenHeight-rectHeight);//move left paddle
} else {
rectYRight = constrain( mouseY, rectYLeft, screenHeight - rectHeight); //move right paddle
}

}//end of move paddle function

//Checks if ball overlaps paddle
boolean doesOverlap(float xPaddle, float yPaddle, float widthPaddle, float heightPaddle, float xBall, float yBall, float radius)
 {
float ballLeftEdge = xBall-radius; //left edge of ball
float ballBottomEdge = yBall+radius; //bottom edge of ball
float ballRightEdge = xBall+radius; //right edge of ball
float ballTopEdge = yBall-radius; //top edge of ball
float paddleLeftEdge = xPaddle; //left edge of paddle
float paddleBottomEdge = yPaddle+heightPaddle; //bottom edge of paddle
float paddleRightEdge = xPaddle+widthPaddle; //right edge of paddle
float paddleTopEdge = yPaddle; //top edge of paddle

if ((ballBottomEdge >= paddleTopEdge) && (ballTopEdge <= paddleBottomEdge) && (ballLeftEdge <= paddleRightEdge) && (ballRightEdge >= paddleLeftEdge )) //Check if ball and paddle overlap
{
return true;
}
else {
return false;
}
}// end of ball overlap checking function by
