# Fourier_transform
Applying Fourier transform on hand drawn continuous curves and traced images, and displaying it as epicycles.

This Application allows you to draw free hand continuous loops or trace images to form an continuous outline of the image. The path then is passed
to the DFT(Discrete Fourier transform) fuction, which then is converted to set of epicycles, and these epicycles draw the loop. This can be seen below:

# Hand Drawn curve
![Demo](https://github.com/sumqwerty/Fourier_transform/blob/master/fourier_transform/exampleGif/handDrawn.gif)

# Tracing Image
![Demo](https://github.com/sumqwerty/Fourier_transform/blob/master/fourier_transform/exampleGif/imgTrace.gif)

The red dots are the nodes which join to form the traced path. The path is stored as a arraylist of postion vectors, and fed to the DFT function as a 
complex number. 

# Contorls
## There are 2 windows one is the epicycle(EC) window and other is the Trace(T) window
### For EC window
pressing 'd' or 'D' -------------------------- Start the epicycles which will trace the path. 
                                               BY DEFAULT A TRACE PATH IS ALREADY THERE (A TRACED PATH OF MY FRIEND'S PIC)
                                               If the user doesn't draw anything on the T widow, press 'd' or 'D' and the default path will be traced.
                                               Each time a curve is drawn or the image is traced, 'd' or 'D', is to be pressed to display the new traced epicycles
                                       
pressing 'l' or 'L' -------------------------- Clears all the path and sets it back to defalut path.

pressing 'n' or 'N' -------------------------- Opens the T(Trace) window, showing the nodes in red(if there's already a path), and new path can be drawn.

### For Trace window
pressing LEFT mouse button -------------------------- Adds a node to the path.(Basically a pen to draw the path)

pressing RIGHT mouse button -------------------------- Removes the last added node.(Works like an eraser)

pressing 'x' or 'X' -------------------------- Clears the whole path and gives a clean window to trace or draw a new curve.

pressing 'c' or 'C' -------------------------- Clears last 5 nodes from the path.

pressnig 's' or 'S' -------------------------- Shows the image to be traced.(Toggles to tracing image mode)

pressing 'e' or 'E' -------------------------- Shows the image with an edge filter, which helps in tracing outlines further 

pressing 'w' or 'W' -------------------------- Clears the widow for free hand curves.(Toggles to freehand mode)
# Simple starting steps
1. Run the code and press 'd' or 'D'. The epicycles will start traceing.
2. Press 'n' or 'N'. This will open the trace window, and you'll see the defualt path(if this the 1st time to open the trace window after running the code)
3. Press 'x' or 'X' to clear the path.
4. Start drawig the loop with the mouse.
5. Shift the focus to EC(epicycle) window and press 'd' or 'D'. You'll see you free hand drawn path traced.
6. Shift to Trace window, clear it by pressing 'x'.
7. Press 's' and it will show you the image, now you can trace the image by drawing on top of the image, 'e' can also be pressed for applying the edge flter which 
   helps in tracing.
8. Then shift to EC window and press 'd', and you'll see you image traced by the epipcycles.
### By pressing 'l' or 'L' in the EC window, the path can be reset to default.
