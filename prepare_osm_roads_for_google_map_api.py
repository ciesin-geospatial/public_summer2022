#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import arcpy
from arcpy import env
from arcgis.features import SpatialDataFrame
from arcgis.features import GeoAccessor, GeoSeriesAccessor
import os
import pandas as pd
arcpy.env.overwriteOutput = True

# OSM data can be downlaoded for the countries in Africa:
# http://download.geofabrik.de/africa.html

# Input data
path_to_osm_roads=# add path that you saved osm data
get_directory=os.path.dirname(path_to_osm_roads)

# Column name to hold lenght of the roads
arcpy.AddField_management(path_to_osm_roads,"road_len_m","DOUBLE")
# Calculate lenght of the road segements in meters
arcpy.management.CalculateGeometryAttributes(path_to_osm_roads, "road_len_m LENGTH_GEODESIC", "METERS", '', None, "SAME_AS_INPUT")
# Get start and end nodes from roads
arcpy.management.FeatureVerticesToPoints(path_to_osm_roads,get_directory+"\\end_start_vertixs.shp", "BOTH_ENDS")
# Column name to hold longitude 
arcpy.AddField_management(get_directory+"\\end_start_vertixs.shp","x","DOUBLE")
# Column name to hold latitude
arcpy.AddField_management(get_directory+"\\end_start_vertixs.shp","y","DOUBLE")
# Conver start and end points of road
arcpy.CalculateGeometryAttributes_management(get_directory+"\\end_start_vertixs.shp", [['x', 'POINT_X'], ['y', 'POINT_Y']],coordinate_system = '4326')
# Convert feature layer to spatial dataframe
osm_road_vertixs=pd.DataFrame.spatial.from_featureclass(get_directory+"\\end_start_vertixs.shp")

# Get end and starting nodes

# Get starting nodes
start_node=osm_road_vertixs.drop_duplicates("ORIG_FID", keep="first").reset_index(drop=True)
start_node.rename({"x":"start_x","y":"start_y"}, axis=1, inplace=True)
# Get starting nodes
end_node=osm_road_vertixs.drop_duplicates("ORIG_FID", keep="last").reset_index(drop=True)
end_node.rename({"x":"end_x","y":"end_y"}, axis=1, inplace=True)
# Put start and end nodes to the same dataset
osm_road_nodes_sdf=start_node.merge(end_node, on="ORIG_FID", how="left")

osm_road_nodes_sdf=osm_road_nodes_sdf[['ORIG_FID','start_x', 'start_y', 'end_x', 'end_y']]

# Attach nodes to OSM roads

# Read osm roads as spatial dataframe
osm_road_sdf=pd.DataFrame.spatial.from_featureclass(path_to_osm_roads)
# Merge nodes to osm roads layer
osm_road_sdf=osm_road_sdf.merge(osm_road_nodes_sdf,left_on="FID", right_on="ORIG_FID", how="left")
# Export osm roads as shp file
osm_road_sdf.spatial.to_featureclass(path_to_osm_roads)
# Delete node layer
arcpy.Delete_management(get_directory+"\\end_start_vertixs.shp")


# Prepare the data for visualization

len_fclass_raw=pd.read_excel("len_fclass_raw.xlsx")
len_fclass_raw.head()

# Prepare the data have 250 samples each

# Attaching speed values for road types
def f(row):
    if row['fclass'] == 'primary':
        val = 80
    elif row['fclass'] == 'secondary':
        val = 50
    elif row['fclass'] == 'tertiary':
        val = 30
    elif row['fclass'] == 'track':
        val = 10
    elif row['fclass'] == 'trunk':
        val = 80
    elif row['fclass'] == 'unclassified':
        val = 40        
    return val

len_fclass_raw['mix_km_h'] = len_fclass_raw.apply(f, axis=1)


# Change column name of 'time' which is actually time from google api
len_fclass_raw['time_google'] = len_fclass_raw['time']
len_fclass_raw.drop("time", axis=1, inplace=True)

# Calculate our travel time for motorized vehicles
len_fclass_raw['time_our'] = (len_fclass_raw['road_len_m']/1000)*60 / len_fclass_raw['mix_km_h']

# Calculate the difference between our travel time and google
len_fclass_raw['difference_our_google'] = len_fclass_raw['time_our'] - len_fclass_raw['time_google']

# Calculate ratio of our time and google time
len_fclass_raw['ratio_our_google'] = len_fclass_raw['time_our'] / len_fclass_raw['time_google']

# Calculate percent of difference of our time and google time
len_fclass_raw['percent_difference_our'] = len_fclass_raw['difference_our_google']*100 / len_fclass_raw['time_our']

# Calculate speed google uses
len_fclass_raw['speed_google'] = (len_fclass_raw['distance']/1000) / (len_fclass_raw['time_google']/60)


# Prepare the data have OSM speed
maxspeed_len_fclass_raw=pd.read_excel("maxspeed_len_fclass_raw.xlsx")
maxspeed_len_fclass_raw.head()

# Attach speed values for road types
maxspeed_len_fclass_raw['mix_km_h'] = maxspeed_len_fclass_raw.apply(f, axis=1)

# Change column name of 'time' which is actually time from google api
maxspeed_len_fclass_raw['time_google'] = maxspeed_len_fclass_raw['time']
maxspeed_len_fclass_raw.drop("time", axis=1, inplace=True)

# Calculate our travel time for motorized vehicles
maxspeed_len_fclass_raw['time_our'] = (maxspeed_len_fclass_raw['road_len_m']/1000)*60 / maxspeed_len_fclass_raw['mix_km_h']

# Calculate OSM travel time
maxspeed_len_fclass_raw['time_osm'] = (maxspeed_len_fclass_raw['road_len_m']/1000)*60 / maxspeed_len_fclass_raw['maxspeed']

# Calculate the difference between our travel time and google
maxspeed_len_fclass_raw['difference_our_google'] = maxspeed_len_fclass_raw['time_our'] - maxspeed_len_fclass_raw['time_google']

# Calculate the difference between our travel time and OSM
maxspeed_len_fclass_raw['difference_our_osm'] = maxspeed_len_fclass_raw['time_our'] - maxspeed_len_fclass_raw['time_osm']

# Calculate the difference between OSM travel time and Google
maxspeed_len_fclass_raw['difference_osm_google'] = maxspeed_len_fclass_raw['time_osm'] - maxspeed_len_fclass_raw['time_google']

# Calculate ratio of our time and OSM
maxspeed_len_fclass_raw['ratio_our_osm'] = maxspeed_len_fclass_raw['time_our'] / maxspeed_len_fclass_raw['time_osm']

# Calculate ratio of our time and Google
maxspeed_len_fclass_raw['ratio_our_google'] = maxspeed_len_fclass_raw['time_our'] / maxspeed_len_fclass_raw['time_google']

# Calculate ratio of OSM time and google
maxspeed_len_fclass_raw['ratio_osm_google'] = maxspeed_len_fclass_raw['time_osm'] / maxspeed_len_fclass_raw['time_google']

# Calculate percent of difference of our time and OSM time
maxspeed_len_fclass_raw['percent_dour_dosm'] = maxspeed_len_fclass_raw['difference_our_osm']*100 / maxspeed_len_fclass_raw['time_our']

# Calculate percent of difference of our time and google time
maxspeed_len_fclass_raw['percent_dour_google'] = maxspeed_len_fclass_raw['difference_our_google']*100 / maxspeed_len_fclass_raw['time_our']

# Calculate percent of difference of OSM time and google time
maxspeed_len_fclass_raw['percent_dosm_dgoogle'] = maxspeed_len_fclass_raw['difference_osm_google']*100 / maxspeed_len_fclass_raw['time_osm']

# Calculate speed google uses
maxspeed_len_fclass_raw['speed_google'] = (maxspeed_len_fclass_raw['distance']/1000) / (maxspeed_len_fclass_raw['time_google']/60)














