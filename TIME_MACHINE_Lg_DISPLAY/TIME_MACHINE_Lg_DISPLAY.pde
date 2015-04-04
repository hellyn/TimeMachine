import java.awt.event.KeyEvent;

final int FEED_WIDTH = 1280;
final int FEED_HEIGHT = 1024;
final int MITRIX_X0 = 248;
final int MITRIX_Y0 = 270; // originally 336
final int MITRIX_WIDTH = 80;
final int MITRIX_HEIGHT = 208;

float perlinVar = 0.007;
int k = 0;
boolean drawBars = false;
boolean changePerlin = false;

float xoff = 0.0; // for noise()

void setup() {
  size(FEED_WIDTH, FEED_HEIGHT);
  background(#00ffcc);
  noStroke();
}

void draw() {
  setLocation(0,0);
  background(#000000);
  
  for (int i = MITRIX_X0; i < MITRIX_X0 + MITRIX_WIDTH; i++) {
    for (int j = MITRIX_Y0; j < MITRIX_Y0 + MITRIX_HEIGHT; j++) {
      
      if (changePerlin) {
        if (xoff < 2) xoff += perlinVar;
        else xoff = 0;
      }
      else xoff += perlinVar;
      
      
      
      float r = random(0,1);
      if (r < 0.7){
        fill(round(noise(xoff) * 255), round(noise(xoff) * 255), round(noise(xoff) * 255));
      }
      
      rect(i,j, round(random(1,1)), round(random(1,1)));
    }
  } 
  
  if (drawBars) {
    fill(255);
    
    int dbX0 = MITRIX_X0 + round(MITRIX_WIDTH * random(0,1));
    int dbY0 = MITRIX_Y0 + MITRIX_HEIGHT/2 + k;
    int dbW = round((MITRIX_X0 + MITRIX_WIDTH - dbX0) * random(0,1));
    int dbH = round(random(0,5));
    rect(dbX0, dbY0, dbW, dbH);
    
    if (k < MITRIX_HEIGHT/2 - 5) k++;
    else k = 0;
    
  }
  
  fill(0);
  triangle(MITRIX_X0, MITRIX_Y0+MITRIX_HEIGHT, MITRIX_X0, MITRIX_Y0+MITRIX_HEIGHT/2, MITRIX_X0+MITRIX_WIDTH/3, MITRIX_Y0+MITRIX_HEIGHT);
  triangle(MITRIX_X0+MITRIX_WIDTH, MITRIX_Y0+MITRIX_HEIGHT, MITRIX_X0+MITRIX_WIDTH, MITRIX_Y0+MITRIX_HEIGHT/2, MITRIX_X0+MITRIX_WIDTH-MITRIX_WIDTH/3, MITRIX_Y0+MITRIX_HEIGHT);
  
}

void keyPressed() {
  if (keyCode == KeyEvent.VK_1) drawBars = !drawBars;
  else if (keyCode == KeyEvent.VK_EQUALS) {
    perlinVar -= 0.001;
    print("perlinVar = ");
    println(perlinVar);
  }
  else if (keyCode == KeyEvent.VK_MINUS) {
    perlinVar += 0.001;
    print("perlinVar = ");
    println(perlinVar);
  }
  else if (keyCode == KeyEvent.VK_2) changePerlin = !changePerlin;
}
