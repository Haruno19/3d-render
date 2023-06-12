# 3d-render in Processing

A processing sketch to render ℝ³ vectors.

<img width="32%" alt="Screenshot 2023-01-19 at 18 50 22" src="https://user-images.githubusercontent.com/61376940/213523701-3229a566-d5a7-4027-b941-3558ed3f9b88.png"> <img width="32%" alt="Screenshot 2023-01-19 at 18 51 10" src="https://user-images.githubusercontent.com/61376940/213523677-a5dacf1f-8c1b-4add-a194-6c552a8308b4.png"> <img width="32%" alt="Screenshot 2023-01-19 at 18 51 20" src="https://user-images.githubusercontent.com/61376940/213523692-253090af-8e97-49c8-b60d-6202b4390635.png">

# Versions

You'll find two different versions of the sketch in the `source` folder: codename `3daxis` and codenme `3dfunc`.  
- `3daxis` is the basic version that offers the capabilities to render simple concepts, points and lines, through the _Desk_ instructions, plus basic navigation functionalities. 
- `3dfunc` is the latest revision, includes all the capabilities of the `3daxis` version, and the ability to define and plot _single variabile linear functions_ graphs through the _Desk_ instructions, plus enhanced navigation functionalities.  

The following specifications are referred to both versions, each section will include a separate paragraph for functionalities specific to the `3dfunc` version.

# Usage  

By default, this sketch renders the 3 axis X, Y and Z rotated around the Y axis by 135°, and around the X axis by 35°.  
The user can interact with the window using some hotkeys:
  - `r` : start and stop generating random points within the specified scope.
  - `a` : hide and show the axis.
  - `o` : hide and show the origin.
  - `d` : switches between themes.
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

### [ _3dfunc rev. specific_ ]
  - `f` : enables _function mode_, resets the space to default values, then sets the rotation at 0° around any axis, thus facing the XY plane parallelly, with maximum zoom value
  - `1 ... 9` : sets the zoom to values from `1` (farthest away from the origin) to `9` (closest to the origin). Zoom values can be set at any time without resetting the space, every entity already rendered will immediately scale accordingly to the new zoom value  

## Runtime User Inputs - _Desk_

You can interact with the 3D space at runtime by adding objects to it, either _lines_ or _points_.  
To do that, write a _Desk_ file at `cdw\desk.txt`, and use the designated hotkey to load contents from it.  
_Desk_ can be thought of as a decriptive languange made up of instructions and parameters that can be parsed by the render. Parameters are order-sensitive. A _Desk_ file must contain every instruction separated by a new line (empty lines are skipped). Bad syntaxt will result in an error message followed by the number of line where the error occourred. 

## Instruction set
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

### [ _3dfunc rev. specific_ ]
- `func an ... a0 [z=Z]`  
  The func instructions plots the graph of the single variable linear function defined in the following form: $y=a_nx^n + ... + a_0x^0 $.
  This instructions has a variable number of parameters:
  - `an ... a0` are floats, they represent the coefficient of the $x$. You need to specify at least one coefficient.
  - `Z` is an [optional] float, it represents the costant $z$ value to plot the function to. If no `Z` value is specified, all the points will have their $z$ coordinate set to $0$.

Please have a look at the [Desk Example section](https://github.com/Haruno19/3d-render#desk-example).

# Modularity
My intent with this project is to create a generalized and modular system to project ℝ³ vectors into a 2D plane, and play around with them.  
### Vectors in ℝ³
Any ℝ³ vector is represented by an object of the `point` class; the `point` class contains a `PVector v` that stores the point's coordinates, and a bunch of methods, its rotation functions and its drawing functions.

## Main structure
For the purpose of keeping it all simple, there's only one ArrayList structure `points` that stores every ℝ³ vector.  
This means of course, that `points` stores also fundamental points, such as:
- `[index 0]` the Origin vector 
- `[index 1]` the Offset vecotr, that is the vector containing the X and Y offset to logically "move" the origin of reference to the center of the window, instead of the default top-left conrner
- `[index 2]` the X Axis
- `[index 3]` the Y Axis
- `[index 4]` the Z Axis
I believe this design choice significantly reduces complexity by removing the need for other global variables.

# Goal
My goal with this project is to keep adding new features, like rendering function graphs or shapes, and creating a full fledged ℝ³ environemnt.  
Every major functionality upgrade will come in as a separate revision of the sketch.

# Desk Example
Example of _Desk_ file:  

<table>
  <tr>
    <td>
      <code>Basic instruction set</code>
    </td>
  </tr>
  <tr>
    <td>
      <code>point 75 75 0 3 p0</code><br>
      <code>point 0 75 -90 1 p1</code><br>
      <code>point 175 175 30 2 p2</code><br>
      <code>line 50 50 50 2 3 2 r1</code>
    </td>
    <td>
      <img width="400" align="left" alt="Screenshot 2023-01-27 at 17 21 46" src="https://user-images.githubusercontent.com/61376940/215144163-2b13a30f-9cf3-4931-bade-6756ac2af021.png"> 
    </td>
  </tr>
  <tr>
    <td>
      <code>3dfunc only instruction set</code>
    </td>
  </tr>
  <tr>
    <td>
      <code>func 0.1 1 1 z=10</code><br>
      <code>func -0.1 1 8 z=-10</code><br>
      <code>func 0.4 3</code><br>
    </td>
    <td>
      <img width="400" align="left" alt="Screenshot 2023-01-27 at 17 21 46" src="https://user-images.githubusercontent.com/61376940/215144163-2b13a30f-9cf3-4931-bade-6756ac2af021.png"> 
    </td>
  </tr>
</table>

# Themes
<table><tr>
<td>
  <h3 align="center">Chalkboard</h3><img alt="Screenshot 2023-01-27 at 21 53 48" src="https://user-images.githubusercontent.com/61376940/215195370-5d74c921-975d-41f4-bdba-f9ad149f4c17.png">
</td>
<td>
  <h3 align="center">Papersheet</h3><img alt="Screenshot 2023-01-27 at 21 53 14" src="https://user-images.githubusercontent.com/61376940/215195400-061a9b08-6b48-47da-85bc-e3997165c939.png">
</td>
</tr></table>

  
# Demo
https://user-images.githubusercontent.com/61376940/215154314-eb326c37-a95e-4946-baa4-356dee113c8d.mov

##### _The demostration video shows all the functionalities included with the `3daxis` version only. Please refer to the Gallery section to see the functionalities specific to the `3dfunc` revision._