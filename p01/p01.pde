
PImage backgroundImg;
PImage ovni;
PImage shotgun;
PImage bullet;
PImage ovni2;
PImage beginningscreen;
PImage explosion;
PImage roast;
int state=3, stage = 1, numBullets = 5, lastClear = 0, lastReload = 0, stageFrame = 0, lives = 5, score, highscore, timeLeft;
boolean dead = false;
boolean shoot = false;
boolean goldDuckShot = false;
import ddf.minim.*;
Minim soundengine;
AudioSample sonido1;
AudioSample sonido3;
void setup() {
   soundengine = new Minim(this);
  sonido1 = soundengine.loadSample("01.mp3", 2000);
  //sonido2 = soundengine.loadSample("02.mp3", 20000);
  sonido3 = soundengine.loadSample("03.mp3", 10000);
  size(700, 600); 
  backgroundImg = loadImage("background.jpg");
  ovni = loadImage("ovni.png");
  shotgun = loadImage("shotgun.png");
  bullet = loadImage("bullet.png");
  ovni2 = loadImage("ovni2.png");
  beginningscreen = loadImage("beginningscreen.jpg");
  explosion = loadImage("explosion.png");
  roast = loadImage("roast.png");
  noCursor();
}
ArrayList <ovni> ovnis = new ArrayList<ovni>();
ArrayList <ovni2> ovnis2 = new ArrayList<ovni2>();
ArrayList <PImage> bullets = new ArrayList<PImage>();

void draw() {
  
  if (state == 3) {
    background(0);
    image(beginningscreen,0,170);
    textAlign(CENTER);
    text("press 1 if you wash the instructions in english", 330, 50);
    text("si  deseas las instrucciones en español presiona 2 ", 330, 100);
    if (key=='1'){
      state = 2;
    }
    if(key=='2'){
      state=4;
    }
      
    }
     if (state == 4) {
    background(0);
    image(beginningscreen, 0, 200);
    textAlign(CENTER);
    text("bienvenido a .....", 330, 30);
    text("aqui estan las instrucciones:", 330, 50);
    text("1) dispara a los ovnis para obtener puntos. entre mayor sea el nivel, mas rapido se moveran ", 330, 70);
    text("2) tu tienes 5 vidas. si tu pierdes un ovni, tu pierdes una vida, no dejes que tus vidas se pierdan", 330, 90);
    text("3) presiona r para recargar", 330, 110);
    text("4) con la tecla espaciadora eliminaras todos los ovnis excepto al gran ovni,pero no obtienes puntos", 330,130);
    text("5) dispara con punteria para un buen tiro!", 330, 150);
    text("6) dispara al gran ovni para obtener mas puntos!", 330, 170);
    if (mousePressed) {
      frameCount = 0;
      state = 2;
    }
  }
  if (state == 0) {
    timeLeft=(int)(20-(((frameCount-stageFrame)%1200)/60));
    if (lives<=0) {
      sonido3.trigger();
      background(255, 0, 0);
      textSize(50);
      text("GAME OVER", width/2+125, height/2);
      sonido3.trigger();
      lives=0;
      if (mousePressed) {
        ovnis.clear();
        score = 0;
        lives = 5;
        numBullets = 5;
        stage = 1;
        stageFrame=0;
        lastReload = 0;
        lastClear = 0;
        frameCount = 0;
        goldDuckShot= false;
        ovnis2.get(0).vx=stage*2;
      }
    }
    else {
      if (frameCount%(120-(10*stage))==0) {
        int derpx;
        int derpy = (int)random(0, 500);
        boolean derpsplit;
        if (random(0, 2)>1) {
          derpx=700;
          derpsplit = true;
        }
        else {
          derpx=0;
          derpsplit = false;
        }
        ovnis.add(new ovni(derpx, derpy, derpsplit));
      }
      image(backgroundImg, 0, 0);
      if ((frameCount-stageFrame)%1200==600) {
        ovnis2.add(new ovni2(0, (int)random(50, height-50)));
      }
      if ((frameCount-stageFrame)%1200>600) {
        if (ovnis2.size()>0) {
          ovnis2.get(0).display();
          if (goldDuckShot==false&&mousePressed&&dist(mouseX, mouseY, ovnis2.get(0).xovni1, ovnis2.get(0).yovni1)<60&&lives>0) {
            goldDuckShot=true;
            score+=stage*10;
            ovnis2.get(0).shot=true;
          }
        }
      }
      for (int i=0;i<ovnis.size();i++) {
        ovnis.get(i).display();
        if (ovnis.get(i).bull) {
          fill(0);
          text("nice shot!", ovnis.get(i).xovni, ovnis.get(i).yovni);
        }
        if (700<ovnis.get(i).xovni||ovnis.get(i).xovni<0) {
          lives--;
          ovnis.remove(i);
        }
      }
      if (score>=highscore) {
        highscore=score;
      }
      image(shotgun, mouseX-15, mouseY-15);
      if ((frameCount - stageFrame)%1200==0) {
        state = 1;
      }
      fill(255);
      textSize(10);
      textAlign(RIGHT);
      text("score: "+score, width-10, 50);
      text("lives: "+lives, width-10, 70);
      text("highscore: "+highscore, width-10, 30);
      text("Time Left: "+timeLeft, width-10, 90);
      for (int j = 0 ; j < numBullets; j++) {
        if (state==0) {
          image(bullet, j*10+10, 540);
        }
      }
    }
  }
  if (state == 2) {
    background(0);
    image(beginningscreen, 0, 200);
    textAlign(CENTER);
    text("Welcome to .....", width/2, 30);
    text("Here are the instructions:", width/2, 50);
    text("1) Shoot the objects to get points.The higher the stage,the faster the ducks move ", 340, 70);
    text("2) You have 5 lives. If you miss a object, you lose a life. Don't let your lives run out!", 350, 90);
    text("3) Press r to reload; it takes a second to reload", width/2, 110);
    text("4) Space is available every 7 seconds and it clears all ducks except the....., but doesn't give any points", width/2, 130);
    text("5) Shoot accurately for a ns!", width/2, 150);
    text("6) Hit the bigovnifor a lot of points!", width/2, 170);
    if (mousePressed) {
      frameCount = 0;
      state = 0;
    }
  }
  if (state==1) {
    background(0);
    textAlign(CENTER);
    textSize(50);
    text("Stage " + (stage+1), width/2, height/2);
    text("Click to Continue", width/2, height/2+50);
    lives = 5;
    if (mousePressed&&(frameCount-stageFrame)>=1300) {
      ovnis.clear();
      stageFrame = frameCount;
      //frameCount=0;
      lives = 5;
      numBullets = 5;
      stage++;
      goldDuckShot=false;
      ovnis2.remove(0);
      state = 0;
    }
  }
}
  
void  keyPressed() {
  if (key==' ' && (frameCount - lastClear) > 60*7) {
    ovnis.clear();
    lastClear = frameCount;
  }
  if (key=='r') {
    lastReload = frameCount;
    numBullets = 5;
  }
}
void mousePressed() {
  if (frameCount - lastReload>=60) {
    if (numBullets > 0) {
      numBullets--;
       if (mousePressed) {
    sonido1.trigger();
}
      for (int i=0;i<ovnis.size();i++) {
        if (dist(mouseX, mouseY, ovnis.get(i).xovni, ovnis.get(i).yovni+50)<100&&dist(mouseX, mouseY, ovnis.get(i).xovni, ovnis.get(i).yovni+50)>20&&lives>0) {
          score+=stage;
          ovnis.get(i).murpx=ovnis.get(i).xovni;
          ovnis.get(i).murpy=ovnis.get(i).yovni;
          ovnis.get(i).shot=true;
 
          if (ovnis.get(i).yovni>600) {
            ovnis.remove(i);
          }
        }
        else if (dist(mouseX, mouseY, ovnis.get(i).xovni, ovnis.get(i).yovni+50)<20&&dist(mouseX, mouseY, ovnis.get(i).xovni, ovnis.get(i).yovni)>0&&lives>0) {
          score+=stage*3;
          ovnis.get(i).murpx=ovnis.get(i).xovni;
          ovnis.get(i).murpy=ovnis.get(i).yovni;
          ovnis.get(i).shot=true;
          ovnis.get(i).bull=true;
          if (ovnis.get(i).yovni>600) {
            ovnis.remove(i);
          }
        }
      }
    }
  }
}