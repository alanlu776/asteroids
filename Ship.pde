class Ship {
  PVector pos;
  PVector vel;
  PVector acc;
  int r;
  float heading;
  float rotation;
  boolean isAccel = false;
  boolean flashing;
  float flashtime;
  
  Ship() {
    rotation = 0;
    flashtime = 0;
    pos = new PVector(width/2, height/2);
    r = 20;
    heading = PI/2;
    vel = new PVector(0, 0);
    flashing = true;
  }

  void update(){
    if(isAccel){
      accel();
    }
    vel.mult(0.95);
    pos.add(vel);
    
  }
  
  void wrap(){
    if(pos.x > width+r){
      pos.x = -r;
    } else if(pos.x < -r){
      pos.x = width+r;
    }
    if(pos.y > height+r){
      pos.y = -r;
    } else if(pos.y < -r){
      pos.y = height+r;
    }
  }
  
  void isAccel(boolean b){
    isAccel = b;
  }
  
  void accel(){
    PVector force = PVector.fromAngle(heading-PI/2);
    vel.add(force);
  }
  
  boolean hits(PVector apos, float ar){
    float d = dist(pos.x, pos.y, apos.x, apos.y);
    if((d <= r + ar)){
      return true;
    } else {
      return false;
    }
  }
  
  boolean hitslaser(Alaser a){
    float d1 = dist(pos.x, pos.y, a.pos.x, a.pos.y);
    if(d1 <= r + a.r){
      return true;
    } else {
      return false;
    }
  }
  
  void render() {
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(heading);
    fill(0);
    if(flashing) {
      if(random(1) < 0.4) noStroke();
      else stroke(255);
      flashtime += 0.1;
      if(flashtime > 5){
        flashing = false;
      }
    }
    triangle(-r, r, r, r, 0, 1.5*-r);
    if(isAccel){
      if(map(int(random(2)), 0, 1, 0, 255) == 0) noStroke();
      else stroke(map(int(random(2)), 0, 1, 0, 255));
      noFill();
      triangle(-r/2, r, r/2, r, 0, 2*r);
    }
    stroke(255);
    popMatrix();
  }
  
  void setRotation(float a){
    rotation = a;
  }
  
  void turn(){
    heading += rotation;
  }
}

class Alienship {
  PVector pos;
  PVector vel;
  PVector acc;
  int r;
  float heading;
  float rotation;
  boolean hitsast = true;
  float maxspeed = 5;
  boolean isRect = false;
  boolean isedges = false;
  float size;
  
  Alienship(){
    rotation = 0;
    size = 0.2;
    if(isedges){
      if(random(1) < 0.5){
        if(random(1) < 0.5) pos = new PVector(random(width), 0);
        else pos = new PVector(random(width), height);
      } else {
        if(random(1) < 0.5) pos = new PVector(0, random(height));
        else pos = new PVector(width, random(height));
      }
    } else {
      pos = new PVector(random(width), random(height));
    }
    r = 20;
    heading = PI/2;
    vel = new PVector(0, 0);
  }
  
  void update(){
    PVector force = PVector.fromAngle(heading-PI/2);
    if(vel.mag() < maxspeed){
      vel.add(force);
    }
    pos.add(vel);
    vel.mult(0);
    heading += random(-1/TAU, 1/TAU);
    if(size < 1){
      size += 0.04;
    }
  }
  
  boolean hits(PVector apos, float ar){
    if(hitsast){
      float d = dist(pos.x, pos.y, apos.x, apos.y);
      if((d <= r + ar)){
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
  
  void wrap(){
    if(pos.x > width+r){
      pos.x = -r;
    } else if(pos.x < -r){
      pos.x = width+r;
    }
    if(pos.y > height+r){
      pos.y = -r;
    } else if(pos.y < -r){
      pos.y = height+r;
    }
  }
  
  void render(){
    pushMatrix();
    translate(pos.x, pos.y);
    strokeWeight(5);
    if(isRect){
      rectMode(CENTER);
      rect(0, 0, r*2*size, r*2*size);
    } else {
      ellipse(0, 0, r*2*size, r*2*size);
      ellipse(0, 0, r*4*size, r/2*size);
      fill(0);
      arc(0, 0, r*2*size, r*2*size, PI, 2*PI);
      arc(0, 0, r*2*size, r/2*size, 0, PI);
      noFill();
    }
    popMatrix();
  }
}