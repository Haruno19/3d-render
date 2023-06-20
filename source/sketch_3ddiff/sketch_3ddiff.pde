///*** Global Variables ***///
//** constants **//
int AxisLength = 75;
int gen_dims = 200;
int delay_ms = 100;
int text_size = 16;
int bg_color = 0;
int st_color = 255;
int line_color = 240;
float single_rotation_degree = 5.0f;
float scale = 1f;
int pc = 0; //stores the last read instruction

//** base structures **//
//list containing all the points. First 5 are fundamental vectors 
ArrayList<point> points;
StringList rotation;
//array of flags
//DrawAxis, DrawOrigin, GeneratePoints, DrawLines
Boolean flags[] = new Boolean[5];

diff_eq d;

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


/* User Input management */
void keyPressed()
{
  if(key == 'c')         //clear all
    remove_all();
  else if(key == 'q')    //exit
    exit();
  else if(key == 'i')    //restore to default settings
    initialize();
  else if(key == 'f')    //reinitializes space nullifying x rotation
    func_mode();
  else if(key == 'd')
    darkModeSwitch();
  else if(key == 'a')    //DrawAxis
    flags[0] = !flags[0];
  else if(key == 'o')    //DrawOrigin
    flags[1] = !flags[1];
  else if(key == 'r')    //GeneratePoints
    flags[2] = !flags[2];
  else if(key == 'l')    //DrawLines
    flags[3] = !flags[3];
  else if(key == 'v')    //DrawLabels
    flags[4] = !flags[4];
  else if(key == 'u')    //ReadFromFile
    readFromFile();
  else if(key == 't')    //hotkey for testing new functions
    print("debug");
  else if(key == CODED)  //Rotation
  {
    if(keyCode == UP)
      rotate_all_x(-single_rotation_degree);
    else if(keyCode == DOWN)
      rotate_all_x(single_rotation_degree);
    else if(keyCode == RIGHT)
      rotate_all_y(-single_rotation_degree);
    else if(keyCode == LEFT)
      rotate_all_y(single_rotation_degree);
    else if(keyCode == CONTROL)
      rotate_all_z(single_rotation_degree);
    else if(keyCode == SHIFT)
      rotate_all_z(-single_rotation_degree);
  }
  else if(key > '0' && key <= '9')
  {
    scale = float(key) - '0';
    
  }
    
  background(bg_color);
  draw_env();
}

void darkModeSwitch()
{
  if(bg_color == 0)
  {
    bg_color = 240;
    st_color = 75;
    line_color = 100;
  }else{
    bg_color = 0;
    st_color = 255;
    line_color = 240;
  }
}

void func_mode()
{
  initialize();
  scale=9f;
  rotate_all_x(-35f);
  rotate_all_y(-135f);
}


/* Parser functions */
void readFromFile()
{
  String[] _instr = loadStrings("desk.txt"), instr;
  for(int i=pc; i<_instr.length; i++)
  {
    instr = split(_instr[i], ' '); 
    switch(instr[0])
    {
      case "point":
        parse_point(reverse(shorten(reverse(instr))));  //[point] [x] [y] [z] -> [z] [y] [x] [point] -> [z] [y] [x] -> [x] [y] [z]
        break;
      case "line":
        parse_line(reverse(shorten(reverse(instr))));
        break;
      case "func":
        parse_func(reverse(shorten(reverse(instr))));
        break;
      case "diff":
        d = new diff_eq(reverse(shorten(reverse(instr))));
        break;
      default:
        println("Error at line "+pc);
    }
  }
}

void parse_func(String[] _lambda)
{
  int limit=_lambda.length;
  float z=0;
  float[] lambda;
  
  if(_lambda.length == 0) 
  {
    println("Error at line "+pc);
    return;
  }
  
  if(_lambda[_lambda.length-1].charAt(0) == 'z')
  {
    limit = _lambda.length-1;
    z = float(_lambda[_lambda.length-1].substring(2));
  }

    lambda = new float[limit];
    
    for(int i=0; i<limit; i++)
      lambda[i] = float(_lambda[i]);
  
  y_function(z, lambda);
}

void parse_point(String[] point)
{
  if(point.length < 3)  //a point needs at least 3 values: X Y and Z coordinates
  {
    println("Error at line "+pc);
    return;
  }
  point np = new point(float(point[0]), float(point[1]), float(point[2]));
  
  if(point.length > 3 && int(point[3])>0) //if it has a fourth value, that value is its attachment
    np.setAttachment(int(point[3])+4);    //the attachment is relative to the points added in the text file 
                                          //1 is the first point added in the text file, ad 1+4 is its index in <points>
  if(point.length > 4)      //if it has 5 values, the fifth one is its label
    np.setLabel(point[4]);
    
  add_point(np);  
  
  pc++;
}

void parse_line(String[] line)
{
  if(line.length < 6) //a lines needs at least 5 values: P(X, Y, Z) and v(X, Y Z)
  {
    println("Error at line "+pc);
    return;
  }
  
  r3_line(new PVector(float(line[0]), float(line[1]), float(line[2])), 
          new PVector(float(line[3]), float(line[4]), float(line[5])), 
          (line.length > 6) ? line[6] : "");
          
  pc++;
}


///*** Global Drawing Functions ***///
void draw_env()
{
  if(flags[0]) //DrawAxis
    draw_axis();
  if(flags[1]) //DrawOrigin
    points.get(0).drawpoint(1);
  if(flags[2]) //GeneratePoints
    add_point(new point (random(gen_dims + gen_dims)-gen_dims, 
                         random(gen_dims + gen_dims)-gen_dims, 
                         random(gen_dims + gen_dims)-gen_dims));
  draw_all();
}

void draw_axis()
{
  stroke(255,0,0);
  points.get(2).drawpoint(1);
  stroke(0,0,255);
  points.get(3).drawpoint(1);
  stroke(0,255,0);
  points.get(4).drawpoint(1);
  stroke(st_color);
}

void draw_all()
{
  point origin = points.get(0);
  for (int i = 5; i < points.size(); i++)
  {
     points.get(i).drawpoint(1);
     if(flags[3])
     {
       stroke(line_color);
       origin.drawline(i, 1);
       stroke(st_color);
     }
  }
}

void y_function(float _z, float[] lambda)
{
     // generates y values for the function with lambda parameters from [-limit, +limit) every step x 
     float limit = 200f, step=0.75f;
     float y, z=_z;
     String _label = "y = ";
     
     for(int k=0; k<lambda.length; k++)
     {
        _label += str(lambda[k]) + "x" + str(lambda.length-k-1) + " +";
     }
     _label = _label.substring(0, _label.length() - 2);
     
     //calculate y for every x from -100 to 100
     for(float x = -limit; x < limit; x+=step)
     {  
         y=0;
         
         for(int k=0; k<lambda.length; k++)
         {
            //for each coefficient value,
            // y += k * x^n 
            //where k is the coefficien and n is the (inverted) index of k
            y += lambda[k]*pow(x,lambda.length-k-1);
         }
         
         point np = new point(x, y, z);
         
         if((x>-limit)) //set the line to the current point from the previous one starting from the second
           np.setAttachment(points.size()-1);
         
         if(x >= 0f && x<= 0.6f)
           np.setLabel(_label);
         
         add_point(np);
     }    
}




///*** Shapes ***///
void r3_line(PVector p0, PVector dir, String tag)
{
  //r = (a, b, c) + t(x, y, z)
  add_point(new point(p0.x+dir.x*gen_dims, p0.y+dir.y*gen_dims, p0.z+dir.z*gen_dims));
  add_point(new point(p0.x+dir.x*-gen_dims, p0.y+dir.y*-gen_dims, p0.z+dir.z*-gen_dims));
  points.get(points.size()-2).setAttachment(points.size()-1);
  points.get(points.size()-1).setAttachment(points.size()-2);
  points.get(points.size()-2).setLabel(tag);
}


///*** Environment Management Functions ***///
void initialize()
{
  pc=0;
  scale=1f;
  rotation = new StringList();
  points = new ArrayList<point>(); 
  System.gc();
  flags[0] = true;  //DrawAxis
  flags[1] = false; //DrawOrigin
  flags[2] = false; //GeneratePoints
  flags[3] = false; //DrawLines
  flags[4] = true;  //DrawLabels
  
  point origin = new point(0, 0, 0);  
  origin.setLabel("o");
  //fundamental axis vectors
  point x_axis = new point(AxisLength,0,0);  
  point y_axis = new point(0,AxisLength,0);
  point z_axis = new point(0,0,AxisLength);  
  x_axis.setAttachment(0);
  y_axis.setAttachment(0);
  z_axis.setAttachment(0);
  x_axis.setLabel("x");
  y_axis.setLabel("y");
  z_axis.setLabel("z");
  //offest vector to offset the origin at the center of the window
  point offset = new point(float(width/2), -float(height/2), 0);
  
  //adding the 6 fundamental vectors to the list
  points.add(origin);   //0
  points.add(offset);   //1
  points.add(x_axis);   //2
  points.add(y_axis);   //3
  points.add(z_axis);   //4
  
  //rotating the axis
  rotate_all_y(135f);
  rotate_all_x(35f);
  
  //bisector lines
  //r3_line(origin.v_abs, new PVector(1, 1, 0), "b1");
  //r3_line(origin.v_abs, new PVector(1, 0, 1), "b2"); 
  //r3_line(origin.v_abs, new PVector(0, 1, 1), "b3"); 
}

//rotates all points starting from the fourth one (the first axis)
void rotate_all_y(float theta)
{
  //point rotation = points.get(2);
  for (int i = 2; i < points.size(); i++)
  {
     points.get(i).rotate_y(theta);
  }
  rotation.append("y"+theta);
}

void rotate_all_x(float theta)
{
  for (int i = 2; i < points.size(); i++)
  {
     points.get(i).rotate_x(theta);
  }
  rotation.append("x"+theta);
}

void rotate_all_z(float theta)
{
  for (int i = 2; i < points.size(); i++)
  {
     points.get(i).rotate_z(theta);
  }
  rotation.append("z"+theta);
}

//each new added point gets rotated according to the current rotation values
void add_point(point _p)
{
  rotate_absolute(_p);
  points.add(_p);
}

void rotate_absolute(point _p)
{
  for(int i=0;i<rotation.size();i++)
  {
    switch(rotation.get(i).charAt(0))
    {
      case 'x':
        _p.rotate_x(float(rotation.get(i).substring(1)));
        break;
      case 'y':
        _p.rotate_y(float(rotation.get(i).substring(1)));
        break;
      case 'z':
        _p.rotate_z(float(rotation.get(i).substring(1)));
        break;
    }
  }
}

//deletes all points aside from the 5 foundamental vectors
void remove_all()
{
  for(int i = points.size()-1; i>4; i--)
  {
    points.remove(i);
  }
  pc=0;
}


///*** Point Class ***//
public class point
{
  PVector v, v_abs;
  int attach;
  String label;
  
  point(float _x, float _y, float _z)
  {
    v = new PVector(_x, -_y, _z);
    v_abs = new PVector(v.x, v.y, v.z);
    attach=-1;
    label="";
  }
  
  void setAttachment(int _index)
  {
    attach=_index;
  }
  
  void setLabel(String _label)
  {
    label=_label;
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
  //every drawing function draws points at scale*coordinates to respect the user-selected scale
  void drawpoint(int off_ind)
  {
    point _offset = points.get(off_ind);
    point(scale*v.x+_offset.v.x, scale*v.y+_offset.v.y);
    if(attach>-1)
      this.drawline(attach, 1);
    if(flags[4] && label != "")
      this.drawlabel(1);
  }
  
  void drawline(int p_ind, int off_ind)
  {
    point _offset = points.get(off_ind);
    point _p = points.get(p_ind);
    line(scale*v.x+_offset.v.x, scale*v.y+_offset.v.y, scale*_p.v.x+_offset.v.y, scale*_p.v.y+_offset.v.y);
  }
  
  void drawlabel(int off_ind)
  {
    fill(st_color);
    point _offset = points.get(off_ind);
    text(label, scale*v.x+_offset.v.x, scale*v.y+_offset.v.y);
  }
}


//*** DIFFERENTIAL EQUATIONS ***//

public class diff_eq
{
  float z=0, scale=20;
  float g=9.8f, L = 2, mu=0.1f;
  float th = PI/3, th_dot = 0;
  float t=20, delta_t = 0.01f;
  
  diff_eq(String[] _param)
  {
    if(_param.length == 0)
    {
      theta();
      return;
    }
    
    if(_param.length != 9) 
    {
      println("Error at line "+pc+". Please look at the DESK documentation for 3ddiff rev.");
      return;
    }
    
    initialize(
     float(_param[0])*PI/float(_param[1]),
     float(_param[2]),
     float(_param[3]),
     float(_param[4]),
     float(_param[5]),
     float(_param[6]),
     float(_param[7]),
     float(_param[8])
    );
  }
  
  void initialize(float th, float th_dot, float t, float delta_t, float _g, float _mu, float _z, float _scale)
  {
    this.th = th;
    this.th_dot = th_dot;
    this.t = t;
    this.delta_t = delta_t;
    this.g = _g;
    this.mu = _mu;
    this.z = _z;
    this.scale = _scale;
    theta();
  }
  
  void theta()
  {
    point np;
    for(float i=0; i<=t; i+=delta_t)
    {
       np = new point(th*scale, th_dot*scale, z);
       if(i!=0) np.setAttachment(points.size()-1);
       add_point(np);
       
       th += th_dot * delta_t;
       th_dot += th_double_dot() * delta_t;
    }
    println(points.size());
  }

  float th_double_dot()
  {
    return -mu * th_dot - (g/L) * sin(th);
  }

}
