//Tracing window file. Pressing n or N on the main window will open tracing window where you can trace your image
import g4p_controls.*;

boolean ftime = true;
boolean showImg = false, showEdg = false, UDraw = true;
float thld = 7;
GWindow window;


public void createWindows()
{
  //creating window using g4p
  window = GWindow.getWindow(this, "Trace", 500,500, img.width,img.height,P2D);
  window.addDrawHandler(this, "windowDraw"); // draw funvito for the Trace window
  window.addMouseHandler(this, "windowMouse"); // mouse event handling 
  window.addKeyHandler(this, "windowKey"); // key event handling
  window.setActionOnClose(G4P.CLOSE_WINDOW); //action when you press close cross on the window
}


public void windowMouse(PApplet appc, GWinData data, MouseEvent event)
{
  if(appc.mousePressed && appc.mouseButton == LEFT)
  {
    mpos.add(new PVector(appc.mouseX, appc.mouseY,0));
  }
  if(appc.mousePressed && appc.mouseButton == RIGHT)
  {
    mpos.remove(mpos.size()-1);
    if(showImg)drwImage(appc);
    else if(showEdg)drwEImage(appc);
  }
  //println(event.getAction());
}

public void windowKey(PApplet appc, GWinData data, KeyEvent event)
{
  
  switch(event.getAction())
  {
    case KeyEvent.PRESS:
      if(appc.key == 's' || appc.key == 'S')
      {
        drwImage(appc);
        showImg = true;
        showEdg = false;
        UDraw = false;
      }
      else if(appc.key == 'e' || appc.key == 'E')
      {
        drwEImage(appc);
        showImg = false;
        UDraw = false;
        showEdg = true;
      }
      else if(appc.key == 'w' || appc.key == 'W')
      {
        appc.background(0);
        showImg = false;
        showEdg = false;
        UDraw = true;
      }
      else if(appc.key == 'c' || appc.key == 'C')
      {
        for(int i=1; i<5; ++i)
        {
          if(mpos.size() > 0)
          {
            mpos.remove((mpos.size()-1));
            if(showImg)drwImage(appc);
            else if(showEdg)drwEImage(appc);
            else if(UDraw)appc.background(0);
          }
        }
      }
      else if(appc.key == 'x' || appc.key == 'X')
      {
        mpos.clear();
        if(showImg)drwImage(appc);
        else if(showEdg)drwEImage(appc);
        else if(UDraw)appc.background(0);
      }
      break;
  }
}

public void drwImage(PApplet appc)
{
  appc.background(img);
}

void drwEImage(PApplet appc)
{
  appc.background(0);
  appc.loadPixels();
  
  img.loadPixels();
  for(int y=0; y<img.height-1; ++y)
  {
    for(int x=0; x<img.width-1; ++x)
    {
      int loc = x + ((y) * img.width);
      int loc1 = (x+1) + (y * img.width);
      int loc2 = (x) + ((y+1) * img.width);
      
      
      float bright = abs(brightness(img.pixels[loc]) - brightness(img.pixels[loc1]));
      float bright2 = abs(brightness(img.pixels[loc]) - brightness(img.pixels[loc2]));
      
      if(bright > thld || bright2 > thld)
      {
        appc.stroke(255);
        appc.fill(255);
        appc.point(x,y);
      }
    }
  }
}


public void windowDraw(PApplet appc,GWinData data)
{
  if(ftime)
  {
    appc.background(0);
    ftime = false;
  }
  for(PVector pos: mpos)
  {
    appc.noStroke();
    appc.fill(255,0,0);
    appc.circle(pos.x,pos.y,5);
  }
}
