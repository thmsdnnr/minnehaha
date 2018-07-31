# thesht ∆ :cat:

![](https://raw.githubusercontent.com/thmsdnnr/minnehaha/master/lookingood.png)

This app helps you navigate the wilds of northern Minnesota.
The Superior Hiking Trail, to be specific.

# We've got this

![](https://i.kym-cdn.com/photos/images/original/000/906/511/595.jpg)

### challenges

Most difficult so far is cleaning up data: the GPX had a lot of sidetracks and tracks that were in the wrong direction, meaning the points did not proceed linearly in one direction. This meant calculating distances based on haversine's on adjacent waypoints led to loops and amplified the true distance of the trail. Manual cleanup was requried to generate the GPX here @ roughly 290 mi length, 1 track, with no loops.

This track was then cleaned up and the resolution decreased (recording only points every ~0.1 miles). The distances between each point was calculated in either direction: `dist_to_S` being the distance from this point to its adjacent points South and `dist_to_N` the distance from the point to its adjacent point north.

For points (SOUTH) A -> B -> C (NORTH), dist_to_N (A) = dist_to_S(B) and dist_to_S(C) = dist_to_N(B).

Using these two points we can find the distance along the trail between any given points in any direction of travel.

Distances calculated with good 'ol [Haversine's Formula](https://en.wikipedia.org/wiki/Haversine_formula)

### strategy for finding waypoints

To find distance between points, grab user location at any given time and find the nearest waypoint in waypoints.json

From there, can calculate the distance to any given trailpoint relative to waypoints. Given that we know the index of the closest waypoint (which, since waypoints are every .1 miles, we consider as one in the same with the waypoint itself), to find the distance from the user to the waypoint:

1. Find closest waypoint to user
2. Sum the `dist_to_N` or `dist_to_S` values (depending ono direction of travel) to the waypoint of interest

Given that we will be summing the same points many times to calculate the list, we can memoify the result of summing distances between the user's waypoint index and a given waypoint's index.

E.g., user is at point A with points 1 2 3 4 5 intervening between user and POI1. Another POI, POI2 is at 1 2 3 4 5 6 7 8 9. Instead of summing up 1 through 5 twice, we'll cache the result of calculating distance to point A, and then can calculate the result to POI2 as dist(POI1) + 6 + 7 + 8 + 9.

This way when calculating waypoints, we only have to generate the sum once in the direction of travel.

If this is expensive, could cache last position results and then calculate offsets from the stored positions, rather than recalculating each anew.

E.g., User moves to position 3 and checks screen again. Distance to POI1 is now previous distance - distance(1-3) and distance to POI2 is now previous distance - distance(1-3). If we keep track of the offset distance(1-3), we never have to reclaculate the distances to a given waypoint.