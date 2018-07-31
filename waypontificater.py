#!/usr/bin/python
import os
import math

def radiansFromDegrees(degrees):
    res = degrees * (math.pi / 180.0)
    return res

def haversine(A, B):
    lat1 = A["rLat"]
    lon1 = A["rLon"]
    lat2 = B["rLat"]
    lon2 = B["rLon"]
    EarthRadius = 6371000.0 * 0.000621371
    distance = 2 * EarthRadius * math.asin(
            math.sqrt(
                math.pow(math.sin(lat2 - lat1) / 2, 2)
                    + math.cos(lat1)
                    * math.cos(lat2)
                    * math.pow(math.sin(lon2 - lon1) / 2, 2))
                )
    return distance

# Create points and measure distances
line_list = []

with open("latlon", "r") as f:
    for line in f:
        spl = line.strip().split(" ")
        if len(spl) < 2:
            continue
        lat = spl[0].split("=")[1]
        lon = spl[1].split("=")[1]
        line_list.append({
            "rLat": radiansFromDegrees(float(lat)),
            "rLon": radiansFromDegrees(float(lon)),
            "lat": float(lat),
            "lon": float(lon)
        })

sum_distance = 0

for i in range(1, len(line_list) - 1):
    dist = haversine(line_list[i-1], line_list[i])
    line_list[i]["distance"] = dist
    sum_distance = sum_distance + dist

for i in range(1, len(line_list) - 1):
    line_list[i]["dist_to_N"] = line_list[i+1].get("distance", 0)
    line_list[i]["dist_to_S"] = line_list[i].get("distance", 0)

desired_interval = 0.15
current_traversed = 0
new_points = []
i = 1
indices = []
for i in range(1, len(line_list) - 1):
    current_traversed = current_traversed + line_list[i]["dist_to_N"]
    if current_traversed >= desired_interval:
        indices.append(i)
        current_traversed = 0

for i in indices:
    new_points.append(line_list[i])

for i in range(1, len(new_points) - 1):
    new_points[i]["dist"] = haversine(new_points[i-1], new_points[i])
for i in range(1, len(new_points) - 1):
    new_points[i]["dist_to_N"] = new_points[i+1].get("dist", 0)
    new_points[i]["dist_to_S"] = new_points[i].get("dist", 0)
with open("/Users/thmsdnnr/Desktop/FINAL", "w") as f:
    f.write("[")
    for i in range(1, len(new_points)):
      i = new_points[i]
      f.write('{"lat": %f, "lon": %f, "dist_to_N": %f, "dist_to_S": %f},' % (i["lat"], i["lon"], i["dist_to_N"], i["dist_to_S"]) + "\n")
    f.write("]")