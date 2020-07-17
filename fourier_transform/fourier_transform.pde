PImage img;
int epicycles;
boolean disp = false;
boolean done = false;
boolean shwEP = true;

//floating point variables
float diameter;
float amplitude;
float time;
float interval;
float frequency;
float phase;


float px = 100;
float py = 100;

//PVector variables
PVector pos;
PVector prev;

//arrays and arraylists
ArrayList<PVector> mpos;
ArrayList<PVector> path;
ArrayList<PVector> drawing;
ArrayList<Complex> x;
ArrayList<Complex> Fourier;

void setup()
{
 
  size(1000,720);
  
  pos = new PVector();
  prev = new PVector();
  img = loadImage("KL.png");
  
  //initialize the ArrayLists
  mpos = new ArrayList<PVector>();
  x = new ArrayList<Complex>();
  Fourier = new ArrayList<Complex>();
  path = new ArrayList<PVector>();
  drawing = new ArrayList<PVector>();
  background(0);
  fillDemo();
}


void draw()
{
  
  if(disp && !done)
  {
    background(0);
    stroke(255);
    noFill();
    PVector vertex = showfourier((width/2), height/2, Fourier);
  
    path.add(vertex.copy());
    stroke(0,255,255,255);
    strokeWeight(1);
    beginShape();
    for (int i = path.size()-1; i > 0; i--)
    {
      PVector p = path.get(i);
      vertex(p.x, p.y);
    }
    endShape();
  
    time += interval;
  
    if (time > TWO_PI)
    {
      done = true;
      time = 0;
    }
    stroke(255, 25);
  }
}




void keyPressed()
{
  if(key == 'd' || key == 'D')
  {
    done = false;
    disp = true;
    loadDraw();
  }
  else if(key == 'n' || key == 'N')
  {
    ftime = true;
    createWindows();
  }
  else if(key == 'o' || key == 'O')shwEP = !shwEP;
  else if(key == 'l' || key == 'L')
  {
    fillDemo();
    ftime = true
    background(0);
  }
}

//--shows the epicycles and the generates each point in the path drawn by them--//
PVector showfourier(float x, float y, ArrayList<Complex> fourier)
{
  pos.x = x;
  pos.y = y;
  interval = TWO_PI/fourier.size();

  for (int i = 0; i < fourier.size(); i++)
  {
    prev.x = pos.x;
    prev.y = pos.y;

    Complex epicycle = fourier.get(i);

    frequency = epicycle.freq;
    amplitude = epicycle.amp;
    phase = epicycle.phase;
    diameter = amplitude*2;

    float theta = frequency * time + phase;

    pos.x += amplitude * cos(theta);
    pos.y += amplitude * sin(theta); 
    if(shwEP)
    {
      noFill();
      strokeWeight(1);
      stroke(255,175);
      ellipse(prev.x, prev.y, diameter, diameter);
      stroke(255,175);
      line(prev.x, prev.y, pos.x, pos.y);
    }
  }
  return new PVector(pos.x, pos.y);
}


void qwerty()
{

  //the number of epicycles is the number of points in the drawing
  epicycles = drawing.size()-1;

  //increasing the skip reduces the resolution of the fourier drawn image
  int skip = 1;

  //Populate the x arraylist with all the points in the drawing
  if (skip > 0)
  {
    for (int i = 0; i <= epicycles; i += skip)
    {
      PVector point = drawing.get(i);
      Complex c = new Complex(point.x, point.y);
      x.add(c);
    }

    //perform discrete fourier transform on the x arraylist and sort it by amplitude
    Fourier = dft(x);
    SortComplex(Fourier);
  }
}



//selection sort algorithm for sorting complex numbers by amplitude
void SortComplex(ArrayList<Complex> c)
{
  int n = c.size();

  for (int i = 0; i < n-1; i++)
  {
    int mindex = i;

    for (int j = i+1; j < n; j++)
    {
      if (c.get(j).amp > c.get(mindex).amp)
        mindex = j;
    }
    swap(c, mindex, i);
  }
}

//simple algorithm to swap two items in an array
void swap(ArrayList<Complex> c, int i, int j)
{
  Complex temp = c.get(i);
  c.set(i, c.get(j));
  c.set(j, temp);
}

void reset()
{
  drawing.clear();
  path.clear();
  x.clear();
  Fourier.clear();
}

void loadDraw()
{
  
  reset();
  background(0);
  for(int i=0; i<mpos.size(); ++i)
  {
    drawing.add(new PVector(mpos.get(i).x - (width/2)+250, mpos.get(i).y - (height/2)+50));
  }  
  qwerty();
}

void fillDemo() // Default path //
{
  mpos.clear();
  reset();
  
  mpos.add(new PVector( 71.0 , 529.0 , 0.0 ));
  mpos.add(new PVector( 75.0 , 493.0 , 0.0 ));
  mpos.add(new PVector( 77.0 , 483.0 , 0.0 ));
  mpos.add(new PVector( 73.0 , 454.0 , 0.0 ));
  mpos.add(new PVector( 75.0 , 418.0 , 0.0 ));
  mpos.add(new PVector( 77.0 , 393.0 , 0.0 ));
  mpos.add(new PVector( 83.0 , 360.0 , 0.0 ));
  mpos.add(new PVector( 91.0 , 318.0 , 0.0 ));
  mpos.add(new PVector( 106.0 , 302.0 , 0.0 ));
  mpos.add(new PVector( 122.0 , 288.0 , 0.0 ));
  mpos.add(new PVector( 152.0 , 278.0 , 0.0 ));
  mpos.add(new PVector( 186.0 , 266.0 , 0.0 ));
  mpos.add(new PVector( 201.0 , 249.0 , 0.0 ));
  mpos.add(new PVector( 205.0 , 236.0 , 0.0 ));
  mpos.add(new PVector( 203.0 , 224.0 , 0.0 ));
  mpos.add(new PVector( 202.0 , 219.0 , 0.0 ));
  mpos.add(new PVector( 199.0 , 216.0 , 0.0 ));
  mpos.add(new PVector( 196.0 , 213.0 , 0.0 ));
  mpos.add(new PVector( 194.0 , 209.0 , 0.0 ));
  mpos.add(new PVector( 193.0 , 206.0 , 0.0 ));
  mpos.add(new PVector( 190.0 , 201.0 , 0.0 ));
  mpos.add(new PVector( 187.0 , 197.0 , 0.0 ));
  mpos.add(new PVector( 186.0 , 192.0 , 0.0 ));
  mpos.add(new PVector( 183.0 , 189.0 , 0.0 ));
  mpos.add(new PVector( 178.0 , 186.0 , 0.0 ));
  mpos.add(new PVector( 176.0 , 181.0 , 0.0 ));
  mpos.add(new PVector( 172.0 , 176.0 , 0.0 ));
  mpos.add(new PVector( 172.0 , 170.0 , 0.0 ));
  mpos.add(new PVector( 168.0 , 159.0 , 0.0 ));
  mpos.add(new PVector( 164.0 , 149.0 , 0.0 ));
  mpos.add(new PVector( 164.0 , 145.0 , 0.0 ));
  mpos.add(new PVector( 163.0 , 140.0 , 0.0 ));
  mpos.add(new PVector( 167.0 , 134.0 , 0.0 ));
  mpos.add(new PVector( 172.0 , 140.0 , 0.0 ));
  mpos.add(new PVector( 178.0 , 148.0 , 0.0 ));
  mpos.add(new PVector( 183.0 , 176.0 , 0.0 ));
  mpos.add(new PVector( 183.0 , 182.0 , 0.0 ));
  mpos.add(new PVector( 184.0 , 177.0 , 0.0 ));
  mpos.add(new PVector( 178.0 , 147.0 , 0.0 ));
  mpos.add(new PVector( 179.0 , 134.0 , 0.0 ));
  mpos.add(new PVector( 179.0 , 120.0 , 0.0 ));
  mpos.add(new PVector( 172.0 , 133.0 , 0.0 ));
  mpos.add(new PVector( 178.0 , 112.0 , 0.0 ));
  mpos.add(new PVector( 205.0 , 108.0 , 0.0 ));
  mpos.add(new PVector( 230.0 , 110.0 , 0.0 ));
  mpos.add(new PVector( 242.0 , 112.0 , 0.0 ));
  mpos.add(new PVector( 253.0 , 110.0 , 0.0 ));
  mpos.add(new PVector( 274.0 , 107.0 , 0.0 ));
  mpos.add(new PVector( 297.0 , 110.0 , 0.0 ));
  mpos.add(new PVector( 302.0 , 123.0 , 0.0 ));
  mpos.add(new PVector( 300.0 , 133.0 , 0.0 ));
  mpos.add(new PVector( 296.0 , 143.0 , 0.0 ));
  mpos.add(new PVector( 276.0 , 148.0 , 0.0 ));
  mpos.add(new PVector( 259.0 , 145.0 , 0.0 ));
  mpos.add(new PVector( 256.0 , 149.0 , 0.0 ));
  mpos.add(new PVector( 259.0 , 154.0 , 0.0 ));
  mpos.add(new PVector( 262.0 , 159.0 , 0.0 ));
  mpos.add(new PVector( 260.0 , 164.0 , 0.0 ));
  mpos.add(new PVector( 255.0 , 167.0 , 0.0 ));
  mpos.add(new PVector( 247.0 , 161.0 , 0.0 ));
  mpos.add(new PVector( 241.0 , 161.0 , 0.0 ));
  mpos.add(new PVector( 235.0 , 165.0 , 0.0 ));
  mpos.add(new PVector( 230.0 , 167.0 , 0.0 ));
  mpos.add(new PVector( 225.0 , 163.0 , 0.0 ));
  mpos.add(new PVector( 223.0 , 159.0 , 0.0 ));
  mpos.add(new PVector( 222.0 , 195.0 , 0.0 ));
  mpos.add(new PVector( 240.0 , 182.0 , 0.0 ));
  mpos.add(new PVector( 245.0 , 186.0 , 0.0 ));
  mpos.add(new PVector( 250.0 , 181.0 , 0.0 ));
  mpos.add(new PVector( 268.0 , 189.0 , 0.0 ));
  mpos.add(new PVector( 249.0 , 193.0 , 0.0 ));
  mpos.add(new PVector( 225.0 , 195.0 , 0.0 ));
  mpos.add(new PVector( 242.0 , 204.0 , 0.0 ));
  mpos.add(new PVector( 252.0 , 203.0 , 0.0 ));
  mpos.add(new PVector( 267.0 , 191.0 , 0.0 ));
  mpos.add(new PVector( 250.0 , 180.0 , 0.0 ));
  mpos.add(new PVector( 245.0 , 186.0 , 0.0 ));
  mpos.add(new PVector( 240.0 , 181.0 , 0.0 ));
  mpos.add(new PVector( 223.0 , 194.0 , 0.0 ));
  mpos.add(new PVector( 223.0 , 159.0 , 0.0 ));
  mpos.add(new PVector( 223.0 , 154.0 , 0.0 ));
  mpos.add(new PVector( 226.0 , 150.0 , 0.0 ));
  mpos.add(new PVector( 223.0 , 146.0 , 0.0 ));
  mpos.add(new PVector( 233.0 , 130.0 , 0.0 ));
  mpos.add(new PVector( 233.0 , 112.0 , 0.0 ));
  mpos.add(new PVector( 232.0 , 130.0 , 0.0 ));
  mpos.add(new PVector( 223.0 , 145.0 , 0.0 ));
  mpos.add(new PVector( 205.0 , 149.0 , 0.0 ));
  mpos.add(new PVector( 187.0 , 145.0 , 0.0 ));
  mpos.add(new PVector( 179.0 , 112.0 , 0.0 ));
  mpos.add(new PVector( 181.0 , 96.0 , 0.0 ));
  mpos.add(new PVector( 182.0 , 81.0 , 0.0 ));
  mpos.add(new PVector( 182.0 , 77.0 , 0.0 ));
  mpos.add(new PVector( 184.0 , 72.0 , 0.0 ));
  mpos.add(new PVector( 187.0 , 67.0 , 0.0 ));
  mpos.add(new PVector( 191.0 , 62.0 , 0.0 ));
  mpos.add(new PVector( 197.0 , 56.0 , 0.0 ));
  mpos.add(new PVector( 203.0 , 53.0 , 0.0 ));
  mpos.add(new PVector( 213.0 , 45.0 , 0.0 ));
  mpos.add(new PVector( 228.0 , 40.0 , 0.0 ));
  mpos.add(new PVector( 243.0 , 37.0 , 0.0 ));
  mpos.add(new PVector( 254.0 , 37.0 , 0.0 ));
  mpos.add(new PVector( 265.0 , 40.0 , 0.0 ));
  mpos.add(new PVector( 279.0 , 46.0 , 0.0 ));
  mpos.add(new PVector( 294.0 , 56.0 , 0.0 ));
  mpos.add(new PVector( 299.0 , 69.0 , 0.0 ));
  mpos.add(new PVector( 304.0 , 84.0 , 0.0 ));
  mpos.add(new PVector( 305.0 , 102.0 , 0.0 ));
  mpos.add(new PVector( 306.0 , 112.0 , 0.0 ));
  mpos.add(new PVector( 297.0 , 106.0 , 0.0 ));
  mpos.add(new PVector( 287.0 , 94.0 , 0.0 ));
  mpos.add(new PVector( 275.0 , 92.0 , 0.0 ));
  mpos.add(new PVector( 257.0 , 93.0 , 0.0 ));
  mpos.add(new PVector( 267.0 , 103.0 , 0.0 ));
  mpos.add(new PVector( 253.0 , 108.0 , 0.0 ));
  mpos.add(new PVector( 241.0 , 111.0 , 0.0 ));
  mpos.add(new PVector( 232.0 , 109.0 , 0.0 ));
  mpos.add(new PVector( 226.0 , 96.0 , 0.0 ));
  mpos.add(new PVector( 211.0 , 95.0 , 0.0 ));
  mpos.add(new PVector( 199.0 , 99.0 , 0.0 ));
  mpos.add(new PVector( 188.0 , 106.0 , 0.0 ));
  mpos.add(new PVector( 206.0 , 104.0 , 0.0 ));
  mpos.add(new PVector( 220.0 , 105.0 , 0.0 ));
  mpos.add(new PVector( 232.0 , 106.0 , 0.0 ));
  mpos.add(new PVector( 242.0 , 112.0 , 0.0 ));
  mpos.add(new PVector( 242.0 , 112.0 , 0.0 ));
  mpos.add(new PVector( 256.0 , 109.0 , 0.0 ));
  mpos.add(new PVector( 262.0 , 103.0 , 0.0 ));
  mpos.add(new PVector( 276.0 , 102.0 , 0.0 ));
  mpos.add(new PVector( 289.0 , 102.0 , 0.0 ));
  mpos.add(new PVector( 296.0 , 105.0 , 0.0 ));
  mpos.add(new PVector( 307.0 , 110.0 , 0.0 ));
  mpos.add(new PVector( 308.0 , 122.0 , 0.0 ));
  mpos.add(new PVector( 310.0 , 132.0 , 0.0 ));
  mpos.add(new PVector( 316.0 , 133.0 , 0.0 ));
  mpos.add(new PVector( 320.0 , 131.0 , 0.0 ));
  mpos.add(new PVector( 325.0 , 137.0 , 0.0 ));
  mpos.add(new PVector( 321.0 , 151.0 , 0.0 ));
  mpos.add(new PVector( 323.0 , 161.0 , 0.0 ));
  mpos.add(new PVector( 318.0 , 167.0 , 0.0 ));
  mpos.add(new PVector( 318.0 , 176.0 , 0.0 ));
  mpos.add(new PVector( 316.0 , 182.0 , 0.0 ));
  mpos.add(new PVector( 311.0 , 183.0 , 0.0 ));
  mpos.add(new PVector( 309.0 , 182.0 , 0.0 ));
  mpos.add(new PVector( 311.0 , 161.0 , 0.0 ));
  mpos.add(new PVector( 309.0 , 135.0 , 0.0 ));
  mpos.add(new PVector( 310.0 , 158.0 , 0.0 ));
  mpos.add(new PVector( 308.0 , 182.0 , 0.0 ));
  mpos.add(new PVector( 308.0 , 189.0 , 0.0 ));
  mpos.add(new PVector( 306.0 , 196.0 , 0.0 ));
  mpos.add(new PVector( 298.0 , 208.0 , 0.0 ));
  mpos.add(new PVector( 291.0 , 215.0 , 0.0 ));
  mpos.add(new PVector( 285.0 , 223.0 , 0.0 ));
  mpos.add(new PVector( 278.0 , 227.0 , 0.0 ));
  mpos.add(new PVector( 272.0 , 231.0 , 0.0 ));
  mpos.add(new PVector( 266.0 , 236.0 , 0.0 ));
  mpos.add(new PVector( 259.0 , 238.0 , 0.0 ));
  mpos.add(new PVector( 252.0 , 238.0 , 0.0 ));
  mpos.add(new PVector( 243.0 , 237.0 , 0.0 ));
  mpos.add(new PVector( 234.0 , 236.0 , 0.0 ));
  mpos.add(new PVector( 226.0 , 233.0 , 0.0 ));
  mpos.add(new PVector( 221.0 , 231.0 , 0.0 ));
  mpos.add(new PVector( 215.0 , 228.0 , 0.0 ));
  mpos.add(new PVector( 209.0 , 226.0 , 0.0 ));
  mpos.add(new PVector( 204.0 , 220.0 , 0.0 ));
  mpos.add(new PVector( 206.0 , 238.0 , 0.0 ));
  mpos.add(new PVector( 201.0 , 252.0 , 0.0 ));
  mpos.add(new PVector( 205.0 , 260.0 , 0.0 ));
  mpos.add(new PVector( 233.0 , 291.0 , 0.0 ));
  mpos.add(new PVector( 249.0 , 292.0 , 0.0 ));
  mpos.add(new PVector( 274.0 , 260.0 , 0.0 ));
  mpos.add(new PVector( 293.0 , 237.0 , 0.0 ));
  mpos.add(new PVector( 299.0 , 226.0 , 0.0 ));
  mpos.add(new PVector( 312.0 , 248.0 , 0.0 ));
  mpos.add(new PVector( 303.0 , 272.0 , 0.0 ));
  mpos.add(new PVector( 292.0 , 301.0 , 0.0 ));
  mpos.add(new PVector( 255.0 , 295.0 , 0.0 ));
  mpos.add(new PVector( 234.0 , 292.0 , 0.0 ));
  mpos.add(new PVector( 199.0 , 312.0 , 0.0 ));
  mpos.add(new PVector( 193.0 , 286.0 , 0.0 ));
  mpos.add(new PVector( 188.0 , 264.0 , 0.0 ));
  mpos.add(new PVector( 200.0 , 254.0 , 0.0 ));
  mpos.add(new PVector( 206.0 , 224.0 , 0.0 ));
  mpos.add(new PVector( 188.0 , 200.0 , 0.0 ));
  mpos.add(new PVector( 180.0 , 183.0 , 0.0 ));
  mpos.add(new PVector( 172.0 , 172.0 , 0.0 ));
  mpos.add(new PVector( 165.0 , 140.0 , 0.0 ));
  mpos.add(new PVector( 169.0 , 130.0 , 0.0 ));
  mpos.add(new PVector( 161.0 , 102.0 , 0.0 ));
  mpos.add(new PVector( 159.0 , 94.0 , 0.0 ));
  mpos.add(new PVector( 162.0 , 91.0 , 0.0 ));
  mpos.add(new PVector( 159.0 , 80.0 , 0.0 ));
  mpos.add(new PVector( 162.0 , 72.0 , 0.0 ));
  mpos.add(new PVector( 164.0 , 59.0 , 0.0 ));
  mpos.add(new PVector( 170.0 , 51.0 , 0.0 ));
  mpos.add(new PVector( 169.0 , 39.0 , 0.0 ));
  mpos.add(new PVector( 176.0 , 27.0 , 0.0 ));
  mpos.add(new PVector( 191.0 , 18.0 , 0.0 ));
  mpos.add(new PVector( 213.0 , 4.0 , 0.0 ));
  mpos.add(new PVector( 225.0 , 1.0 , 0.0 ));
  mpos.add(new PVector( 251.0 , 7.0 , 0.0 ));
  mpos.add(new PVector( 261.0 , 4.0 , 0.0 ));
  mpos.add(new PVector( 276.0 , 19.0 , 0.0 ));
  mpos.add(new PVector( 278.0 , 13.0 , 0.0 ));
  mpos.add(new PVector( 275.0 , 7.0 , 0.0 ));
  mpos.add(new PVector( 294.0 , 13.0 , 0.0 ));
  mpos.add(new PVector( 304.0 , 28.0 , 0.0 ));
  mpos.add(new PVector( 301.0 , 38.0 , 0.0 ));
  mpos.add(new PVector( 311.0 , 44.0 , 0.0 ));
  mpos.add(new PVector( 314.0 , 58.0 , 0.0 ));
  mpos.add(new PVector( 322.0 , 72.0 , 0.0 ));
  mpos.add(new PVector( 326.0 , 95.0 , 0.0 ));
  mpos.add(new PVector( 322.0 , 103.0 , 0.0 ));
  mpos.add(new PVector( 322.0 , 118.0 , 0.0 ));
  mpos.add(new PVector( 322.0 , 126.0 , 0.0 ));
  mpos.add(new PVector( 324.0 , 145.0 , 0.0 ));
  mpos.add(new PVector( 323.0 , 156.0 , 0.0 ));
  mpos.add(new PVector( 319.0 , 173.0 , 0.0 ));
  mpos.add(new PVector( 308.0 , 186.0 , 0.0 ));
  mpos.add(new PVector( 305.0 , 194.0 , 0.0 ));
  mpos.add(new PVector( 301.0 , 202.0 , 0.0 ));
  mpos.add(new PVector( 295.0 , 212.0 , 0.0 ));
  mpos.add(new PVector( 298.0 , 226.0 , 0.0 ));
  mpos.add(new PVector( 312.0 , 247.0 , 0.0 ));
  mpos.add(new PVector( 335.0 , 263.0 , 0.0 ));
  mpos.add(new PVector( 367.0 , 277.0 , 0.0 ));
  mpos.add(new PVector( 399.0 , 293.0 , 0.0 ));
  mpos.add(new PVector( 410.0 , 304.0 , 0.0 ));
  mpos.add(new PVector( 423.0 , 322.0 , 0.0 ));
  mpos.add(new PVector( 433.0 , 345.0 , 0.0 ));
  mpos.add(new PVector( 432.0 , 368.0 , 0.0 ));
  mpos.add(new PVector( 439.0 , 409.0 , 0.0 ));
  mpos.add(new PVector( 443.0 , 459.0 , 0.0 ));
  mpos.add(new PVector( 443.0 , 499.0 , 0.0 ));
  mpos.add(new PVector( 440.0 , 524.0 , 0.0 ));
  mpos.add(new PVector( 444.0 , 533.0 , 0.0 ));
  mpos.add(new PVector( 74.0 , 531.0 , 0.0 ));
  
  mpos.add(new PVector( 440.0 , 532.0 , 0.0 ));
  mpos.add(new PVector( 61.0 , 530.0 , 0.0 ));
  mpos.add(new PVector( 68.0 , 500.0 , 0.0 ));
  mpos.add(new PVector( 72.0 , 463.0 , 0.0 ));
  mpos.add(new PVector( 73.0 , 445.0 , 0.0 ));
  mpos.add(new PVector( 73.0 , 423.0 , 0.0 ));
  mpos.add(new PVector( 76.0 , 399.0 , 0.0 ));
  mpos.add(new PVector( 83.0 , 369.0 , 0.0 ));
  mpos.add(new PVector( 89.0 , 334.0 , 0.0 ));
  mpos.add(new PVector( 94.0 , 322.0 , 0.0 ));
  mpos.add(new PVector( 102.0 , 306.0 , 0.0 ));
  mpos.add(new PVector( 126.0 , 288.0 , 0.0 ));
  mpos.add(new PVector( 158.0 , 272.0 , 0.0 ));
  mpos.add(new PVector( 177.0 , 265.0 , 0.0 ));
  mpos.add(new PVector( 196.0 , 250.0 , 0.0 ));
  mpos.add(new PVector( 204.0 , 246.0 , 0.0 ));
  mpos.add(new PVector( 201.0 , 217.0 , 0.0 ));
  mpos.add(new PVector( 195.0 , 210.0 , 0.0 ));
  mpos.add(new PVector( 190.0 , 204.0 , 0.0 ));
  mpos.add(new PVector( 187.0 , 197.0 , 0.0 ));
  mpos.add(new PVector( 180.0 , 146.0 , 0.0 ));
  mpos.add(new PVector( 181.0 , 139.0 , 0.0 ));
  mpos.add(new PVector( 180.0 , 132.0 , 0.0 ));
  mpos.add(new PVector( 179.0 , 118.0 , 0.0 ));
  mpos.add(new PVector( 178.0 , 111.0 , 0.0 ));
  mpos.add(new PVector( 207.0 , 108.0 , 0.0 ));
  mpos.add(new PVector( 232.0 , 111.0 , 0.0 ));
  mpos.add(new PVector( 240.0 , 111.0 , 0.0 ));
  mpos.add(new PVector( 249.0 , 110.0 , 0.0 ));
  mpos.add(new PVector( 269.0 , 107.0 , 0.0 ));
  mpos.add(new PVector( 283.0 , 108.0 , 0.0 ));
  mpos.add(new PVector( 297.0 , 110.0 , 0.0 ));
  mpos.add(new PVector( 302.0 , 118.0 , 0.0 ));
  mpos.add(new PVector( 300.0 , 132.0 , 0.0 ));
  mpos.add(new PVector( 298.0 , 142.0 , 0.0 ));
  mpos.add(new PVector( 294.0 , 146.0 , 0.0 ));
  mpos.add(new PVector( 281.0 , 149.0 , 0.0 ));
  mpos.add(new PVector( 263.0 , 148.0 , 0.0 ));
  mpos.add(new PVector( 255.0 , 141.0 , 0.0 ));
  mpos.add(new PVector( 251.0 , 129.0 , 0.0 ));
  mpos.add(new PVector( 245.0 , 119.0 , 0.0 ));
  mpos.add(new PVector( 239.0 , 119.0 , 0.0 ));
  mpos.add(new PVector( 232.0 , 131.0 , 0.0 ));
  mpos.add(new PVector( 226.0 , 145.0 , 0.0 ));
  mpos.add(new PVector( 212.0 , 148.0 , 0.0 ));
  mpos.add(new PVector( 197.0 , 149.0 , 0.0 ));
  mpos.add(new PVector( 186.0 , 146.0 , 0.0 ));
  mpos.add(new PVector( 179.0 , 126.0 , 0.0 ));
  mpos.add(new PVector( 180.0 , 120.0 , 0.0 ));
  mpos.add(new PVector( 173.0 , 132.0 , 0.0 ));
  mpos.add(new PVector( 169.0 , 131.0 , 0.0 ));
  mpos.add(new PVector( 166.0 , 121.0 , 0.0 ));
  mpos.add(new PVector( 167.0 , 115.0 , 0.0 ));
  mpos.add(new PVector( 165.0 , 108.0 , 0.0 ));
  mpos.add(new PVector( 168.0 , 102.0 , 0.0 ));
  mpos.add(new PVector( 169.0 , 96.0 , 0.0 ));
  mpos.add(new PVector( 162.0 , 99.0 , 0.0 ));
  mpos.add(new PVector( 164.0 , 93.0 , 0.0 ));
  mpos.add(new PVector( 159.0 , 80.0 , 0.0 ));
  mpos.add(new PVector( 166.0 , 69.0 , 0.0 ));
  mpos.add(new PVector( 165.0 , 64.0 , 0.0 ));
  mpos.add(new PVector( 171.0 , 56.0 , 0.0 ));
  mpos.add(new PVector( 168.0 , 53.0 , 0.0 ));
  mpos.add(new PVector( 165.0 , 45.0 , 0.0 ));
  mpos.add(new PVector( 168.0 , 39.0 , 0.0 ));
  mpos.add(new PVector( 171.0 , 38.0 , 0.0 ));
  mpos.add(new PVector( 174.0 , 31.0 , 0.0 ));
  mpos.add(new PVector( 178.0 , 25.0 , 0.0 ));
  mpos.add(new PVector( 186.0 , 24.0 , 0.0 ));
  mpos.add(new PVector( 183.0 , 19.0 , 0.0 ));
  mpos.add(new PVector( 191.0 , 17.0 , 0.0 ));
  mpos.add(new PVector( 197.0 , 14.0 , 0.0 ));
  mpos.add(new PVector( 207.0 , 17.0 , 0.0 ));
  mpos.add(new PVector( 213.0 , 18.0 , 0.0 ));
  mpos.add(new PVector( 210.0 , 9.0 , 0.0 ));
  mpos.add(new PVector( 210.0 , 4.0 , 0.0 ));
  mpos.add(new PVector( 221.0 , 2.0 , 0.0 ));
  mpos.add(new PVector( 225.0 , 6.0 , 0.0 ));
  mpos.add(new PVector( 227.0 , 12.0 , 0.0 ));
  mpos.add(new PVector( 233.0 , 14.0 , 0.0 ));
  mpos.add(new PVector( 232.0 , 7.0 , 0.0 ));
  mpos.add(new PVector( 237.0 , 4.0 , 0.0 ));
  mpos.add(new PVector( 247.0 , 10.0 , 0.0 ));
  mpos.add(new PVector( 250.0 , 12.0 , 0.0 ));
  mpos.add(new PVector( 249.0 , 2.0 , 0.0 ));
  mpos.add(new PVector( 256.0 , 4.0 , 0.0 ));
  mpos.add(new PVector( 277.0 , 9.0 , 0.0 ));
  mpos.add(new PVector( 280.0 , 6.0 , 0.0 ));
  mpos.add(new PVector( 287.0 , 10.0 , 0.0 ));
  mpos.add(new PVector( 296.0 , 19.0 , 0.0 ));
  mpos.add(new PVector( 295.0 , 28.0 , 0.0 ));
  mpos.add(new PVector( 301.0 , 31.0 , 0.0 ));
  mpos.add(new PVector( 301.0 , 41.0 , 0.0 ));
  mpos.add(new PVector( 310.0 , 48.0 , 0.0 ));
  mpos.add(new PVector( 315.0 , 62.0 , 0.0 ));
  mpos.add(new PVector( 323.0 , 72.0 , 0.0 ));
  mpos.add(new PVector( 325.0 , 84.0 , 0.0 ));
  mpos.add(new PVector( 324.0 , 101.0 , 0.0 ));
  mpos.add(new PVector( 324.0 , 117.0 , 0.0 ));
  mpos.add(new PVector( 321.0 , 131.0 , 0.0 ));
  mpos.add(new PVector( 324.0 , 136.0 , 0.0 ));
  mpos.add(new PVector( 324.0 , 154.0 , 0.0 ));
  mpos.add(new PVector( 324.0 , 164.0 , 0.0 ));
  mpos.add(new PVector( 318.0 , 173.0 , 0.0 ));
  mpos.add(new PVector( 316.0 , 184.0 , 0.0 ));
  mpos.add(new PVector( 310.0 , 182.0 , 0.0 ));
  mpos.add(new PVector( 306.0 , 199.0 , 0.0 ));
  mpos.add(new PVector( 298.0 , 209.0 , 0.0 ));
  mpos.add(new PVector( 294.0 , 215.0 , 0.0 ));
  mpos.add(new PVector( 295.0 , 222.0 , 0.0 ));
  mpos.add(new PVector( 309.0 , 240.0 , 0.0 ));
  mpos.add(new PVector( 310.0 , 249.0 , 0.0 ));
  mpos.add(new PVector( 309.0 , 263.0 , 0.0 ));
  mpos.add(new PVector( 293.0 , 299.0 , 0.0 ));
  mpos.add(new PVector( 272.0 , 299.0 , 0.0 ));
  mpos.add(new PVector( 243.0 , 330.0 , 0.0 ));
  mpos.add(new PVector( 227.0 , 330.0 , 0.0 ));
  mpos.add(new PVector( 243.0 , 332.0 , 0.0 ));
  mpos.add(new PVector( 250.0 , 351.0 , 0.0 ));
  mpos.add(new PVector( 254.0 , 388.0 , 0.0 ));
  mpos.add(new PVector( 255.0 , 419.0 , 0.0 ));
  mpos.add(new PVector( 253.0 , 451.0 , 0.0 ));
  mpos.add(new PVector( 260.0 , 532.0 , 0.0 ));
  mpos.add(new PVector( 208.0 , 533.0 , 0.0 ));
  mpos.add(new PVector( 210.0 , 470.0 , 0.0 ));
  mpos.add(new PVector( 212.0 , 437.0 , 0.0 ));
  mpos.add(new PVector( 215.0 , 399.0 , 0.0 ));
  mpos.add(new PVector( 221.0 , 370.0 , 0.0 ));
  mpos.add(new PVector( 229.0 , 338.0 , 0.0 ));
  mpos.add(new PVector( 230.0 , 328.0 , 0.0 ));
  mpos.add(new PVector( 220.0 , 306.0 , 0.0 ));
  mpos.add(new PVector( 222.0 , 302.0 , 0.0 ));
  mpos.add(new PVector( 237.0 , 303.0 , 0.0 ));
  mpos.add(new PVector( 246.0 , 300.0 , 0.0 ));
  mpos.add(new PVector( 255.0 , 296.0 , 0.0 ));
  mpos.add(new PVector( 272.0 , 298.0 , 0.0 ));
  mpos.add(new PVector( 291.0 , 297.0 , 0.0 ));
  mpos.add(new PVector( 310.0 , 262.0 , 0.0 ));
  mpos.add(new PVector( 312.0 , 251.0 , 0.0 ));
  mpos.add(new PVector( 334.0 , 260.0 , 0.0 ));
  mpos.add(new PVector( 347.0 , 264.0 , 0.0 ));
  mpos.add(new PVector( 365.0 , 274.0 , 0.0 ));
  mpos.add(new PVector( 388.0 , 284.0 , 0.0 ));
  mpos.add(new PVector( 406.0 , 294.0 , 0.0 ));
  mpos.add(new PVector( 417.0 , 309.0 , 0.0 ));
  mpos.add(new PVector( 427.0 , 325.0 , 0.0 ));
  mpos.add(new PVector( 431.0 , 339.0 , 0.0 ));
  mpos.add(new PVector( 431.0 , 366.0 , 0.0 ));
  mpos.add(new PVector( 436.0 , 387.0 , 0.0 ));
  mpos.add(new PVector( 439.0 , 415.0 , 0.0 ));
  mpos.add(new PVector( 440.0 , 444.0 , 0.0 ));
  mpos.add(new PVector( 443.0 , 484.0 , 0.0 ));
  mpos.add(new PVector( 439.0 , 532.0 , 0.0 ));
  
  mpos.add(new PVector( 444.0 , 490.0 , 0.0 ));
  mpos.add(new PVector( 442.0 , 447.0 , 0.0 ));
  mpos.add(new PVector( 436.0 , 398.0 , 0.0 ));
  mpos.add(new PVector( 431.0 , 368.0 , 0.0 ));
  mpos.add(new PVector( 431.0 , 338.0 , 0.0 ));
  mpos.add(new PVector( 424.0 , 322.0 , 0.0 ));
  mpos.add(new PVector( 413.0 , 305.0 , 0.0 ));
  mpos.add(new PVector( 391.0 , 284.0 , 0.0 ));
  mpos.add(new PVector( 355.0 , 268.0 , 0.0 ));
  mpos.add(new PVector( 324.0 , 256.0 , 0.0 ));
  mpos.add(new PVector( 315.0 , 254.0 , 0.0 ));
  mpos.add(new PVector( 310.0 , 245.0 , 0.0 ));
  
  mpos.add(new PVector( 310.0 , 163.0 , 0.0 ));
  mpos.add(new PVector( 311.0 , 149.0 , 0.0 ));
  mpos.add(new PVector( 310.0 , 132.0 , 0.0 ));
  mpos.add(new PVector( 304.0 , 116.0 , 0.0 ));
  mpos.add(new PVector( 299.0 , 133.0 , 0.0 ));
  mpos.add(new PVector( 294.0 , 145.0 , 0.0 ));
  mpos.add(new PVector( 277.0 , 148.0 , 0.0 ));
  mpos.add(new PVector( 260.0 , 145.0 , 0.0 ));
  mpos.add(new PVector( 262.0 , 151.0 , 0.0 ));
  mpos.add(new PVector( 264.0 , 156.0 , 0.0 ));
  mpos.add(new PVector( 263.0 , 159.0 , 0.0 ));
  mpos.add(new PVector( 259.0 , 163.0 , 0.0 ));
  mpos.add(new PVector( 257.0 , 165.0 , 0.0 ));
  mpos.add(new PVector( 253.0 , 165.0 , 0.0 ));
  mpos.add(new PVector( 248.0 , 163.0 , 0.0 ));
  mpos.add(new PVector( 245.0 , 160.0 , 0.0 ));
  mpos.add(new PVector( 242.0 , 159.0 , 0.0 ));
  mpos.add(new PVector( 239.0 , 162.0 , 0.0 ));
  mpos.add(new PVector( 237.0 , 165.0 , 0.0 ));
  mpos.add(new PVector( 234.0 , 167.0 , 0.0 ));
  mpos.add(new PVector( 228.0 , 166.0 , 0.0 ));
  mpos.add(new PVector( 225.0 , 163.0 , 0.0 ));
  mpos.add(new PVector( 224.0 , 159.0 , 0.0 ));
  mpos.add(new PVector( 225.0 , 153.0 , 0.0 ));
  mpos.add(new PVector( 227.0 , 150.0 , 0.0 ));
  mpos.add(new PVector( 226.0 , 145.0 , 0.0 ));
  mpos.add(new PVector( 232.0 , 130.0 , 0.0 ));
  mpos.add(new PVector( 238.0 , 118.0 , 0.0 ));
  mpos.add(new PVector( 247.0 , 118.0 , 0.0 ));
  mpos.add(new PVector( 252.0 , 109.0 , 0.0 ));
  mpos.add(new PVector( 273.0 , 106.0 , 0.0 ));
  mpos.add(new PVector( 298.0 , 109.0 , 0.0 ));
  mpos.add(new PVector( 306.0 , 108.0 , 0.0 ));
  mpos.add(new PVector( 307.0 , 119.0 , 0.0 ));
  mpos.add(new PVector( 313.0 , 131.0 , 0.0 ));
  mpos.add(new PVector( 311.0 , 148.0 , 0.0 ));
  mpos.add(new PVector( 309.0 , 163.0 , 0.0 ));
  mpos.add(new PVector( 306.0 , 180.0 , 0.0 ));
  mpos.add(new PVector( 306.0 , 190.0 , 0.0 ));
  mpos.add(new PVector( 300.0 , 201.0 , 0.0 ));
  mpos.add(new PVector( 292.0 , 211.0 , 0.0 ));
  mpos.add(new PVector( 297.0 , 222.0 , 0.0 ));
  mpos.add(new PVector( 303.0 , 231.0 , 0.0 ));
  mpos.add(new PVector( 314.0 , 253.0 , 0.0 ));
  mpos.add(new PVector( 323.0 , 254.0 , 0.0 ));
  mpos.add(new PVector( 353.0 , 267.0 , 0.0 ));
  mpos.add(new PVector( 371.0 , 278.0 , 0.0 ));
  mpos.add(new PVector( 392.0 , 283.0 , 0.0 ));
  mpos.add(new PVector( 400.0 , 293.0 , 0.0 ));
  mpos.add(new PVector( 418.0 , 312.0 , 0.0 ));
  mpos.add(new PVector( 428.0 , 327.0 , 0.0 ));
  mpos.add(new PVector( 434.0 , 353.0 , 0.0 ));
  mpos.add(new PVector( 432.0 , 380.0 , 0.0 ));
  mpos.add(new PVector( 437.0 , 415.0 , 0.0 ));
  mpos.add(new PVector( 440.0 , 433.0 , 0.0 ));
  mpos.add(new PVector( 440.0 , 468.0 , 0.0 ));
  mpos.add(new PVector( 442.0 , 515.0 , 0.0 ));
  mpos.add(new PVector( 441.0 , 534.0 , 0.0 ));
  mpos.add(new PVector( 71.0 , 532.0 , 0.0 ));
}
