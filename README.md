# 3d-render in Processing

A processing sketch to render ℝ³ vectors in a 2D space.

<img width="32%" alt="Screenshot 2023-01-19 at 18 50 22" src="https://user-images.githubusercontent.com/61376940/213523701-3229a566-d5a7-4027-b941-3558ed3f9b88.png"> <img width="32%" alt="Screenshot 2023-01-19 at 18 51 10" src="https://user-images.githubusercontent.com/61376940/213523677-a5dacf1f-8c1b-4add-a194-6c552a8308b4.png"> <img width="32%" alt="Screenshot 2023-01-19 at 18 51 20" src="https://user-images.githubusercontent.com/61376940/213523692-253090af-8e97-49c8-b60d-6202b4390635.png">

## Usage  

By default, this sketch renders the 3 axis X, Y and Z rotated around the Y axis by 135°, and around the X axis by 35°.  
The user can interact with the window using some hotkeys:
  - `r` : start and stop generating random points within the specified scope.
  - `a` : hide and show the axis.
  - `o` : hide and show the origin.
  - `d` : switches between dark and light mode.
  - `l` : render the points as vectors (show a line connecting them with the Origin).
  - `c` : delete all points except the axis and the other fundamental vectors.
  - `i` : reset to default values.
  - `u` : reads input form `desk.txt` file.
  - `ARROW UP` : rotate everything around the X axis by 3,6°.
  - `ARROW DOWN` : rotate everything around the X axis by -3,6°.
  - `ARROW LEFT` : rotate everything around the Y axis by 3,6°.
  - `ARROW RIGHT` : rotate everything around the Y axis by -3,6°.
  - `CONTROL` : rotate everything around the Z axis by 3,6°.
  - `SHIFT` : rotate everything around the Z axis by -3,6°.

### Runtime User Inputs - _Desk_

The user can interact with the 3D system and add objects to it, for now either _lines_ or _points_. 
How? That's simple! Just by editing a txt file! Place in the `cdw\desk.txt` file all the instructions you need. 

### Instruction set
- `point X Y Z [Att Lab]`  
The point instruction adds a point to the 3D space.  
This instruction takes up to 5 arguments:  
  - `X`, `Y` and `Z` are floats, they represent the absolute coordinates of the point you want to add.  
  - `Att` is an [optional] intager, it representes the index of the point you want to attach to this new point. Index 0 means no attachment, index 1 is the first point in the file. You cannot attach a point to fundamental vectors. 
  - `Lab` is an [optional] string, it representes the label of the point.
- `line A B C VX VY VZ [Lab]`  
The line instruction adds a line to the 3D space.  
A line in ℝ³ is a set of points determinted by a point $(a, b, c)$ and a directional vector $v = (x, y, z)$ as such ${(x, y, z) = (a, b, c) + tv}$.  
This instruction takes up to 7 arguments:  
  - `A`, `B` and `C` are floats, they represents the coordinates of the point $P$
  - `VX`, `VY` and `VZ` are floats, they represents the compontents of the directional vector $v$
  - `Lab` is an [optional] string, it representes the label of the point.
  
Please have a look at the [Desk Example section](https://github.com/Haruno19/3d-render/edit/main/README.md#desk-example).

## Modularity
My intent with this project is to create a generalized and modular system to project ℝ³ vectors into a 2D plane, and play around with them.  
### Vectors in ℝ³
Any ℝ³ vector is represented by an object of the `point` class; the `point` class contains a `PVector v` that stores the point's coordinates, and a bunch of methods, its rotation functions and its drawing functions.

### Main structure
For the purpose of keeping it all simple, there's only one ArrayList structure `points` that stores every ℝ³ vector.  
This means of course, that `points` stores also fundamental points, such as:
- `[index 0]` the Origin vector 
- `[index 1]` the Offset vecotr, that is the vector containing the X and Y offset to logically "move" the origin of reference to the center of the window, instead of the default top-left conrner
- `[index 2]` the X Axis
- `[index 3]` the Y Axis
- `[index 4]` the Z Axis
I believe this design choice significantly reduces complexity by removing the need for other global variables.

## Goal
My goal with this project is to keep adding new features, like rendering function graphs or shapes, and creating a full fledged ℝ³ environemnt.

## Desk Example
Here's an example of _desk_:  

<table><tr>
<td>
  <code>point 75 75 0 3 p0</code><br>
  <code>point 0 75 -90 1 p1</code><br>
  <code>point 175 175 30 2 p2</code><br>
  <code>line 50 50 50 2 3 2 r1</code>
</td>
<td>
  <img width="400" align="left" alt="Screenshot 2023-01-27 at 17 21 46" src="https://user-images.githubusercontent.com/61376940/215144163-2b13a30f-9cf3-4931-bade-6756ac2af021.png"> 
</td>
</tr></table>


  
## Demo
https://user-images.githubusercontent.com/61376940/215154314-eb326c37-a95e-4946-baa4-356dee113c8d.mov
