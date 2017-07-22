class Particle {
  PVector pos;
  PVector vel;
  float r = 10;
  float a;
  boolean dead;
  
  Particle(PVector _pos){
    pos = _pos.copy();
    a = 200;
    float dir = random(TAU);
    vel = PVector.fromAngle(dir);
    dead = false;
  }
  
  void render(){
    strokeWeight(r);
    stroke(255, a);
    pushMatrix();
    translate(pos.x, pos.y);
    point(0, 0);
    popMatrix();
  }
  
  void update(){
    pos.add(vel);
    a-=5;
    if(a < 0) dead = true;
  }
}