import ddf.minim.*; 

ArrayList<Roach> coks;
PImage img;
Minim minim;
AudioPlayer hitSound;
int lastSpawnTime = 0;

void setup() {
  size(800, 800);
  coks = new ArrayList<Roach>();
  img = loadImage("kecoa.png");
  
  minim = new Minim(this);
  hitSound = minim.loadFile("Hit.wav");}

void draw() {
  background(#9AA2AF);
  
  if (millis() - lastSpawnTime > 5000) {
    addRandomRoach();
    lastSpawnTime = millis();
  }
  
for (int i = coks.size() - 1; i >= 0; i--) {
    Roach c = coks.get(i);
    c.live();
  }

  fill(51);
  textSize(16);
  text("nums: " + coks.size(), 50, 750); 
}

void addRandomRoach() {
  float randomX = random(width);
  float randomY = random(height);
  coks.add(new Roach(img, randomX, randomY));
}


void mouseClicked() {
  boolean hit = false;
  
  for (int i = coks.size() - 1; i >= 0; i--) {
    Roach c = coks.get(i);
    if (dist(mouseX, mouseY, c.pos.x, c.pos.y) < img.width / 2) {
      coks.remove(i);
      hit = true;
      break;
    }
  }
  
  if (hit) {
    hitSound.rewind();
    hitSound.play();
  }
}
