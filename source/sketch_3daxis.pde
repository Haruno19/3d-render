///*** Global Variables ***///
//** constants **//
int AxisLength = 75;
int gen_dims = 200;
int delay_ms = 100;
int text_size = 16;
int bg_color = 0;
int st_color = 255;
int line_color = 200;

//** base structures **//
//list containing all the points. First 6 are fundamental vectors 
ArrayList<point> points;
//array of flags
//PrintAxis, GeneratePoints, DrawLines
Boolean flags[] = new Boolean[3];

void setup()
{
  size(700, 700);
  background(bg_color);
  stroke(st_color);
  textSize(text_size);
  
  initialize();
}

void draw()
{
  background(bg_color);
  draw_env();
  delay(delay_ms);
}


/* Hotkey management */
void keyPressed()
{
  if(key == 'c')         //clear all
    remove_all();
  else if(key == 'o')    //restore to default settings
    initialize();
  else if(key == 'a')    //DrawAxis
    flags[0] = !flags[0];
  else if(key == 'r')    //GeneratePoints
    flags[1] = !flags[1];
  else if(key == 'l')
    flags[2] = !flags[2];
  else if(key == CODED)  //Rotation
  {
    if(keyCode == UP)
      rotate_all_x(-3.6f);
    else if(keyCode == DOWN)
      rotate_all_x(3.6f);
    else if(keyCode == RIGHT)
      rotate_all_y(-3.6f);
    else if(keyCode == LEFT)
      rotate_all_y(3.6f);
    else if(keyCode == CONTROL)
      rotate_all_z(3.6f);
    else if(keyCode == SHIFT)
      rotate_all_z(-3.6f);
  }
  background(bg_color);
  draw_env();
}


///*** Global Drawing Functions ***///
void draw_env()
{
  if(flags[0])
    draw_axis();
  if(flags[1])
    add_point(new point (random(gen_dims + gen_dims)-gen_dims, 
                         random(gen_dims + gen_dims)-gen_dims, 
                         random(gen_dims + gen_dims)-gen_dims));
  draw_all();
}

void draw_axis()
{
  point offset = points.get(1);
  point origin = points.get(0);
  stroke(255,0,0);
  points.get(3).drawline(origin, offset);
  points.get(3).drawlabel("x", offset);
  stroke(0,0,255);
  points.get(4).drawline(origin, offset);
  points.get(4).drawlabel("y", offset);
  stroke(0,255,0);
  points.get(5).drawline(origin, offset);
  points.get(5).drawlabel("z", offset);
  stroke(st_color);
}

void draw_all()
{
  point offset = points.get(1);
  point origin = points.get(0);
  for (int i = 6; i < points.size(); i++)
  {
     points.get(i).drawpoint(offset);
     if(flags[2])
     {
       stroke(line_color);
       origin.drawline(points.get(i), offset);
       stroke(st_color);
     }
  }
}


///*** Environment Management Functions ***///
void initialize()
{
  points = new ArrayList<point>(); 
  flags[0] = true;  //PrintAxis
  flags[1] = false; //GeneratePoints
  flags[2] = false; //DrawLines
  
  point origin = new point(0, 0, 0);  
  //fundamental axis vectors
  point x_axis = new point(AxisLength,0,0);  
  point y_axis = new point(0,AxisLength,0);
  point z_axis = new point(0,0,AxisLength);  
  //offest vector to offset the origin at the center of the window
  point offset = new point(float(width/2), -float(height/2), 0);
  //vector that accounts to all the rotation occoured
  point rotation = new point(0, 0, 0);
  
  //adding the 6 fundamental vectors to the list
  points.add(origin);   //0
  points.add(offset);   //1
  points.add(rotation); //2
  points.add(x_axis);   //3
  points.add(y_axis);   //4
  points.add(z_axis);   //5
  
  //rotating the axis
  rotate_all_y(135f);
  rotate_all_x(35f);
}

//rotates all points starting from the fourth one (the first axis)
void rotate_all_y(float theta)
{
  point rotation = points.get(2);
  for (int i = 3; i < points.size(); i++)
  {
     points.get(i).rotate_y(theta);
  }
  rotation.v.set(rotation.v.x, rotation.v.y+theta, rotation.v.z);
}

void rotate_all_x(float theta)
{
  point rotation = points.get(2);
  for (int i = 3; i < points.size(); i++)
  {
     points.get(i).rotate_x(theta);
  }
  rotation.v.set(rotation.v.x+theta, rotation.v.y, rotation.v.z);
}

void rotate_all_z(float theta)
{
  point rotation = points.get(2);
  for (int i = 3; i < points.size(); i++)
  {
     points.get(i).rotate_z(theta);
  }
  rotation.v.set(rotation.v.x, rotation.v.y, rotation.v.z+theta);
}

//each new added point gets rotated according to the current rotation values
void add_point(point _p)
{
  point rotation = points.get(2);
  _p.rotate_y(rotation.v.y);
  _p.rotate_z(rotation.v.z);
  _p.rotate_x(rotation.v.x);
  points.add(_p);
  println(_p.v);
}

//deletes all points aside from the 6 foundamental vectors
void remove_all()
{
  for(int i = points.size()-1; i>5; i--)
  {
    points.remove(i);
  }
}


///*** Point Class ***//
public class point
{
  PVector v;
  
  point(float _x, float _y, float _z)
  {
    v = new PVector(_x, -_y, _z);
  }
  
  
  /*** Rotates the point by theta degrees around the axis, using the rotation matrix ***/
  void rotate_y(float theta)
  {
    theta *= PI/180.0f;
    v.set(v.x*cos(theta)+v.z*sin(theta), v.y, v.z*cos(theta)-v.x*sin(theta));
  }
  
  void rotate_x(float theta)
  {
    theta *= PI/180.0f;
    v.set(v.x, v.y*cos(theta)-v.z*sin(theta), v.z*cos(theta)+v.y*sin(theta));
  }
  
  void rotate_z(float theta)
  {
    theta *= PI/180.0f;
    v.set(v.x*cos(theta)-v.y*sin(theta), v.y*cos(theta)+v.x*sin(theta), v.z);
  }
  
  
  /*** Drawing Functions ***/
  void drawpoint(point _offset)
  {
    point(v.x+_offset.v.x, v.y+_offset.v.y);
  }
  
  void drawline(point _p, point _offset)
  {
    line(v.x+_offset.v.x, v.y+_offset.v.y, _p.v.x+_offset.v.y, _p.v.y+_offset.v.y);
  }
  
  void drawlabel(String s, point _offset)
  {
    text(s, v.x+_offset.v.x, v.y+_offset.v.y);
  }
  
}
