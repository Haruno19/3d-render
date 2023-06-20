# 3d-render in Processing

A Processing project to render $\mathbb{R}^3$ vectors.

<img width="32%" alt="Screenshot 2023-01-19 at 18 51 20" src="https://github.com/Haruno19/3d-render/assets/61376940/d342e450-520a-4e5b-b013-e5e49bb42e4c"> <img width="32%" alt="Screenshot 2023-01-19 at 18 51 10" src="https://github.com/Haruno19/3d-render/assets/61376940/89a0a979-9270-41e5-8573-04d02b407235"> <img width="32%" alt="Screenshot 2023-01-19 at 18 50 22" src="https://github.com/Haruno19/3d-render/assets/61376940/4ee437a5-61dc-4616-8019-e4c8c14c7bea"> 

# Versions

You'll find three different versions of the sketch in the `source` folder: codename `3daxis`, codenme `3dfunc` and codename `3ddiff`.  
- `3daxis` is the basic version that offers the capabilities to render simple concepts, points and lines, through the _Desk_ instructions, with basic navigation functionalities. 
- `3dfunc` is the first big revision, it includes all the capabilities of the `3daxis` version, plus the ability to define and plot _single variabile linear functions_ graphs through the _Desk_ instructions, with enhanced navigation functionalities.
- `3ddiff` is the latest revision, it includes all the capabilities of the `3dfunc` version, plus the ability to plot a graph of the differential equation that describes the mechanics of a pendulum using the $XY$ plane as a (sort of) [phase space](https://en.wikipedia.org/wiki/Phase_space) in which the $x$ coordinates represents the pendulum angle $\theta$, and the $y$ coordinates the angular velocity $\dot\theta$ of the pendulum.

The following specifications are referred to every versions, each section will include a separate paragraph for functionalities specific to the `3dfunc` and `3ddiff` versions.

# Gallery
<img width="32%" alt="Screenshot 2023-06-12 at 21 50 37" src="https://github.com/Haruno19/3d-render/assets/61376940/20a7c452-5bd0-4637-867e-c2c27ae2adfe"> <img width="32%" alt="Screenshot 2023-06-12 at 21 47 57" src="https://github.com/Haruno19/3d-render/assets/61376940/283d7872-7c0e-41b8-984e-d92827fc8ecf"> <img width="32%" alt="Screenshot 2023-06-12 at 21 46 36" src="https://github.com/Haruno19/3d-render/assets/61376940/f33c5922-55a3-47a4-82ca-959a16f70f09">
<img width="32%" alt="Screenshot 2023-06-12 at 21 35 14" src="https://github.com/Haruno19/3d-render/assets/61376940/a1851f47-6d76-4ce5-9f48-bd36533a860a"> <img width="32%" alt="Screenshot 2023-06-12 at 22 12 35" src="https://github.com/Haruno19/3d-render/assets/61376940/c42c7706-d88a-4957-8516-f3d982882230"> <img width="32%" alt="Screenshot 2023-06-12 at 22 04 49" src="https://github.com/Haruno19/3d-render/assets/61376940/ac4cb9d1-e49c-4fdc-bc39-a60aa1c74691">
<img width="32%" alt="Screenshot 2023-06-20 at 22 35 05" src="https://github.com/Haruno19/3d-render/assets/61376940/de524fde-b88a-47e0-9726-f347c3c1b7cc"> <img width="32%" alt="Screenshot 2023-06-20 at 22 52 16" src="https://github.com/Haruno19/3d-render/assets/61376940/41e3aa22-0d53-4692-b0a0-9a85c06421db"> <img width="32%" alt="Screenshot 2023-06-20 at 22 31 21" src="https://github.com/Haruno19/3d-render/assets/61376940/7a9e648f-68e8-4b2f-9f3b-bd2d35726571"> 

# Usage  

By default, this sketch renders the three axis $x$, $y$ and $z$ rotated around the $y$ axis by $135°$, and around the $x$ axis by $35°$.  
You can interact with the space using the following hotkeys:
  - `r` : start and stop generating random points within the a certain scope.
  - `a` : hide and show the axis.
  - `o` : hide and show the origin.
  - `d` : switch between themes.
  - `l` : render the points as vectors (show a line connecting them with the origin).
  - `c` : delete all points except the axis and the other fundamental vectors.
  - `i` : reset to default values.
  - `u` : parse _Desk_ instructions.
  - `ARROW UP` : rotate everything around the $x$ axis by $3,6°$.
  - `ARROW DOWN` : rotate everything around the $x$ axis by $-3,6°$.
  - `ARROW LEFT` : rotate everything around the $y$ axis by $3,6°$.
  - `ARROW RIGHT` : rotate everything around the $y$ axis by $-3,6°$.
  - `CONTROL` : rotate everything around the $z$ axis by $3,6°$.
  - `SHIFT` : rotate everything around the $z$ axis by $-3,6°$.

#### [ _3dfunc rev. specific_ ]
  - `v` : hide and show labels globally
  - `f` : enable _function mode_, resets the space to default values, then sets the rotation at $0°$ around every axis, thus facing the $XY$ plane parallelly, with maximum zoom value
  - `1 ... 9` : sets the zoom to a value from `1` (farthest away from the origin) to `9` (closest to the origin). Zoom values can be set at any time without resetting the space, every entity already on display will be scaled accordingly to the new zoom value  

## Runtime User Inputs - _Desk_

You can interact with the 3D space at runtime by adding objects to it.
To do so, you'll have to write a _Desk_ file at path `cdw\desk.txt`, and use the designated hotkey to load contents from it.  
_Desk_ can be thought of as a decriptive languange made up of instructions and parameters that can be parsed by the rendering system. Parameters are order-sensitive. A _Desk_ file must contain every instruction separated by a new line (empty lines are skipped). Bad syntaxt will result in an error message followed by the number of line where the parsing error occourred. 

## Instruction set
- `point X Y Z [Att Lab]`  
The `point` instruction adds a point to the 3D space.  
This instruction takes up to 5 arguments:  
  - `X`, `Y` and `Z` are floats, they represent the absolute coordinates of the point you want to add.  
  - `Att` is an [optional] intager, it representes the index of the point you want to attach to this new point. Index 0 means no attachment, index 1 is the first point in the file. You cannot attach a point to fundamental vectors. 
  - `Lab` is an [optional] string, it representes the label of the point.
- `line A B C VX VY VZ [Lab]`  
The `line` instruction adds a line to the 3D space.  
A line in ℝ³ is a set of points determinted by a point $(a, b, c)$ and a directional vector $v = (x, y, z)$ as such ${(x, y, z) = (a, b, c) + tv}$.  
This instruction takes up to 7 arguments:  
  - `A`, `B` and `C` are floats, they represents the coordinates of the point $P$
  - `VX`, `VY` and `VZ` are floats, they represents the compontents of the directional vector $v$
  - `Lab` is an [optional] string, it representes the label of the point.

#### [ _3dfunc rev. specific_ ]
- `func an ... a0 [z=Z]`  
  The `func` instructions plots the graph of the single variable linear function defined in the following form: $y=a_nx^n + ... + a_0x^0 $.
  This instructions has a variable number of parameters:
  - `an ... a0` are floats, they represent the coefficient of the $x$. You need to specify at least one coefficient.
  - `Z` is an [optional] float, it represents the costant $z$ value to plot the function to. If no `Z` value is specified, all the points will have their $z$ coordinate set to $0$.  
  
  Each plotted function will show a label of its equation.  
  Note that every function is plotted by calculating its $y=a_nx^n + ... + a_0x^0$ $\forall x \in [-200, +200)$ with $x=k \frac{3}{4}$ with $k \in \mathbb{N}$ (basically between $-200$ and $200$ every $0.75$). To change this behaviour, you can set your own values for the `limit` and `step` variables in the `void y_function(float _z, float[] lambda)` method.

#### [ _3ddiff rev. specific_ ]
- `diff [th1 th2 th_dot t delta_t g mu z scale]`  
  The `diff` instruction plots the graph of the differential equation that describes the pendulum mechanics $\ddot\theta(t) = -\mu\dot\theta(t)-\frac{g}{L}sin(\theta(t))$ on the $XY$ plane as a (sort of) phase space. You can use the parameters to tweak the graph. If no additional parameter is specified, the default values are set as follows: $\theta_0=\frac{\pi}{3}, \dot\theta_0=0, t=20, \Delta t=0.01, g=9.8, L=2, z=0, scale=20$. Please note that you can either specify no parameter at all or _all_ of them.
  - `th1` and `th2` are a floats, they represents respectively the $k$ and $j$ coefficents in the initial $\theta$ value $\frac{k\pi}{j}$. This value represents the angle of the pendulum in radiants, and it's the $x$ component of the vector.
  - `th_dot` is a float, it represents the initial $\dot\theta$ value. This value represents the angular velocity of the pendulum, and it's the $y$ component of the vector.
  - `t` is a float, it represents the total time of observation; the bigger `t`, the more points the graph will have with a given `delta_t` value.
  - `delta_t` is a float, it represents the step of time at which each observation (or calculation) is executed; the lower the `delta_t`, the more points the graph will have with a given `t` value. The `delta_t` value has a huge impact on the graph's precision, it's recommended to use values $<0.10$. 
  - `g` is a float, it represents the gravity force in $m/s^2$.
  - `mu` is a float, it represents the air resistance in $N$.
  - `z` is a float, it represents the fixed $z$ value each vector in the differential equation will have.
  - `scale` is a float, it represents the value to scale the $x$ and $y$ coordinates of all the vectors in the differential equation by.

  Each plotted differential equation will result in `t` \ `delta_t` points. While a huge quantity of points won't necessarily be a problem per se, please note that large quantities of points can result in slow downs while using the navigation functionalities such as real-time rescaling and rotation, as well as and increase of the process' memory usage. 
  
Please have a look at the [Desk Example section](https://github.com/Haruno19/3d-render#desk-example).

# Modularity
My intent with this project is to create a generalized and modular system to project ℝ³ vectors into a 2D plane, and play around with them.  
### Vectors in ℝ³
Any ℝ³ vector is represented by an object of the `point` class; the `point` class contains a `PVector v` that stores the point's coordinates, and a bunch of methods, its rotation functions and its drawing functions.

## Main structure
For the purpose of keeping it all simple, there's only one ArrayList structure `points` that stores every ℝ³ vector.  
This means of course, that `points` stores also fundamental points, such as:
- `[index 0]` the Origin vector 
- `[index 1]` the Offset vecotr, that is the vector containing the $x$ and $y$ offset to logically "move" the origin of reference to the center of the window, instead of the default top-left conrner
- `[index 2]` the $x$ Axis
- `[index 3]` the $y$ Axis
- `[index 4]` the $z$ Axis
I believe this design choice significantly reduces complexity by removing the need for other global variables.

# Goal
My goal with this project is to keep adding new features, like rendering function graphs or shapes, and creating a full fledged ℝ³ environemnt.  
Every major functionality upgrade will come in as a separate revision of the sketch.

# Desk Example

<table>
  <tr>
    <td>
      Basic instruction set
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
      <code>3dfunc</code>-only instruction set
    </td>
    <td>
       <i>Function mode view</i>
    </td>
  </tr>
  <tr>
    <td>
      <code>func 0.1 1 1 z=10</code><br>
      <code>func -0.1 1 8 z=-10</code><br>
      <code>func 0.4 3</code><br>
    </td>
    <td>
      <img width="400" align="left" alt="Screenshot 2023-01-27 at 17 21 46" src="https://github.com/Haruno19/3d-render/assets/61376940/e22ad7da-0603-4fe4-b248-4fa669a341dd"> 
    </td>
  </tr>
  <tr>
    <td>
      <code>3ddiff</code>-only instruction set
    </td>
    <td>
       <i>Function mode view (2x scale)</i>
    </td>
  </tr>
  <tr>
    <td>
      <code>diff</code><br>
      <code>diff -3.2 3 0 20 0.05 9.8 0.1 0 20</code><br>
      <code>diff -1 3 4.5 20 0.05 9.8 0.1 50 20</code><br>
    </td>
    <td>
      <img width="400" align="left" src="https://github.com/Haruno19/3d-render/assets/61376940/4ba376f9-c406-437b-a4cd-9621a6e532c8"> 
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

##### _The above demostration video shows and overview of the functionalities included with the `3daxis` version of the sketch. Please refer to the [Gallery](https://github.com/Haruno19/3d-render#Gallery) section to see screenshots of the functionalities specific to the `3dfunc` and `3ddiff` revisions._
