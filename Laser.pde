//code for lasers
class Laser {
  PVector pos;
  PVector vel;
  float r;
  
  Laser(PVector shipPos, float angle){
    pos = new PVector(shipPos.x, shipPos.y);
    vel = PVector.fromAngle(angle-PI/2);
    vel.mult(15);
    r = 10;
  }
  
  void update(){
    pos.add(vel);
  }
  
  void render(){
    strokeWeight(r);
    point(pos.x, pos.y);
  }
  
  boolean hits(PVector apos, float r){
    float d = dist(pos.x, pos.y, apos.x, apos.y);
    return (d < r);
  }
  
  boolean offscreen(){
    if((pos.x > width+r) || (pos.y > height+r)){
      return true;
    } else if((pos.x < -r) || (pos.y < -r)){
      return true;
    } else {
      return false;
    }
  }
}

class Alaser {
  PVector pos;
  PVector vel;
  float r;
  
  Alaser(PVector _aship, PVector _shipPos){
    pos = new PVector(_aship.x, _aship.y);
    float x = _shipPos.x - pos.x;
    float y = _shipPos.y - pos.y;
    float a = atan2(y, x);
    vel = PVector.fromAngle(a+random(-PI/12, PI/12));
    vel.setMag(11);
    r = 10;
  }
  
  boolean hits(Ship s){
    float d = dist(pos.x, pos.y, s.pos.x, s.pos.y);
    return (d < s.r);
  }
  
  boolean hitsa(PVector apos, float r){
    float d = dist(pos.x, pos.y, apos.x, apos.y);
    return (d < r);
  }
  
  void update(){
    pos.add(vel);
  }
  
  void render(){
    strokeWeight(r);
    point(pos.x, pos.y);
  }
  
  boolean offscreen(){
    if((pos.x > width+r) || (pos.y > height+r)){
      return true;
    } else if((pos.x < -r) || (pos.y < -r)){
      return true;
    } else {
      return false;
    }
  }
}