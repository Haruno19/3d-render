# 3d-render in Processing

A processing sketch to render ℝ³ vectors in a 2D space.

<img width="32%" alt="Screenshot 2023-01-19 at 18 50 22" src="https://user-images.githubusercontent.com/61376940/213523701-3229a566-d5a7-4027-b941-3558ed3f9b88.png"> <img width="32%" alt="Screenshot 2023-01-19 at 18 51 10" src="https://user-images.githubusercontent.com/61376940/213523677-a5dacf1f-8c1b-4add-a194-6c552a8308b4.png"> <img width="32%" alt="Screenshot 2023-01-19 at 18 51 20" src="https://user-images.githubusercontent.com/61376940/213523692-253090af-8e97-49c8-b60d-6202b4390635.png">

## Usage  

By default, this sketch renders the 3 axis X, Y and Z rotated around the Y axis by 135°, and around the X axis by 35°.  
The user can interact with the window using some hotkeys:
  - `r` : start and stop generating random points within the specified scope.
  - `a` : hide and show the axis.
  - `l` : render the points as vectors (show a line connecting them with the Origin).
  - `c` : delete all points except the axis and the other fundamental vectors.
  - `o` : reset to default values.
  - `ARROW UP` : rotate everything around the X axis by 3,6°.
  - `ARROW DOWN` : rotate everything around the X axis by -3,6°.
  - `ARROW LEFT` : rotate everything around the Y axis by 3,6°.
  - `ARROW RIGHT` : rotate everything around the Y axis by -3,6°.
  - `CONTROL` : rotate everything around the Z axis by 3,6°.
  - `SHIFT` : rotate everything around the Z axis by -3,6°.

## Modularity
My intent with this project is to create a generalized and modular system to project ℝ³ vectors into a 2D plane, and play around with them.  
### Vectors in ℝ³
Any ℝ³ vector is represented by an object of the `point` class; the `point` class contains a `PVector v` that stores the point's coordinates, and a bunch of methods, its rotation functions and its drawing functions.

### Main structure
For the purpose of keeping it all simple, there's only one ArrayList structure `points` that stores every ℝ³ vector.  
This means of course, that `points` stores also fundamental points, such as:
- `[index 0]` the Origin vector 
- `[index 1]` the Offset vecotr, that is the vector containing the X and Y offset to logically "move" the origin of reference to the center of the window, instead of the default top-left conrner
- `[index 2]` the Rotation vector, a vector which purpose is to take account of all the rotation that occour in the system, in order to rotate new points accordingly
- `[index 3]` the X Axis
- `[index 4]` the Y Axis
- `[index 5]` the Z Axis
I believe this design choice significantly reduces complexity by removing the need for other global variables.

## Goal
My goal with this project is to keep adding new features, like rendering function graphs or shapes, and creating a full fledged ℝ³ environemnt.

## Demo
https://user-images.githubusercontent.com/61376940/213522787-46e1ab07-3b53-4a7f-8b50-fe505463039f.mov
