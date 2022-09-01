#!/usr/bin/env python
# coding: utf-8

import googlemaps
import ast
import pandas as pd
import arcpy
from arcpy import env
from arcgis.features import SpatialDataFrame


# Connect to Google API

gmaps = googlemaps.Client(key = 'Key') 

# Prepare data frames to use 
# Get a sample that has maxspeed (OSM Speed), length>1000 and roadtypes of interest

# Get all obs that has maxspeed (since there are not many)
new_sample_maxspeed=osm_road_sdf[osm_road_sdf['maxspeed']>0]

# Get observations longer than 1000m
new_sample_roadlen=new_sample_maxspeed[new_sample_maxspeed['road_len_m']>1000]

# Get obs for each road category of interest
sample_len_maxpseed_fclass= new_sample_roadlen[(new_sample_roadlen['fclass']=='primary') 
                                             | (new_sample_roadlen['fclass']=='secondary')
                                             | (new_sample_roadlen['fclass']=='tertiary')
                                             | (new_sample_roadlen['fclass']=='unclassified')
                                             | (new_sample_roadlen['fclass']=='track')
                                             | (new_sample_roadlen['fclass']=='trunk') ]

# Get a sample with length>1000 and road types

# Get observations longer than 1000m
new_sample_len=osm_road_sdf[osm_road_sdf['road_len_m']>=1000]

# Get equal sized samples for each road category of interest
new_sample_len_primary= new_sample_len[new_sample_len['fclass']=='primary']
new_sample_len_primary=new_sample_len_primary.sample(250)

new_sample_len_secondary= new_sample_len[new_sample_len['fclass']=='secondary']
new_sample_len_secondary=new_sample_len_secondary.sample(250)

new_sample_len_tertiary= new_sample_len[new_sample_len['fclass']=='tertiary']
new_sample_len_tertiary=new_sample_len_tertiary.sample(250)

new_sample_len_unclassified= new_sample_len[new_sample_len['fclass']=='unclassified']
new_sample_len_unclassified=new_sample_len_unclassified.sample(250)

new_sample_len_track= new_sample_len[new_sample_len['fclass']=='track']
new_sample_len_track=new_sample_len_track.sample(250)

new_sample_len_trunk= new_sample_len[new_sample_len['fclass']=='trunk']
new_sample_len_trunk=new_sample_len_trunk.sample(238)#Since there is only 238 obs


# Merge each category
new_sample_len_road_types = pd.concat([new_sample_len_primary,new_sample_len_secondary
                                             ,new_sample_len_tertiary,new_sample_len_unclassified
                                             ,new_sample_len_track,new_sample_len_trunk], axis=0)

# Get travel times from Google API

'''
#Original Google API code that is not adjusted for our dataframe

# iterate over the rows, passing the latlongs to the gmaps API and extracting the distance and time
for index, row in subset_df.iterrows():
    
    try:
    disTime = gmaps.distance_matrix([str(row['start_y']) +" "+ str(row['start_x'])],
                                        [str(row['end_y']) +" "+ str(row['end_x'])],
                                        mode='driving')['rows'][0]['elements'][0]
    subset_df.at[index, ['distance', 'time']] = [disTime['distance']['value'], disTime['duration']['text']]
             
   except:
        pass

'''

# iterate over the rows, passing the latlongs to the gmaps API and extracting the distance and time
for index, row in sample_len_maxpseed_fclass.iterrows():
    
    try:
        disTime = gmaps.distance_matrix([str(row['start_y_y']) +" "+ str(row['start_x_x'])],
                                        [str(row['end_y_y']) +" "+ str(row['end_x_x'])],
                                        mode='driving')['rows'][0]['elements'][0]
        sample_len_maxpseed_fclass.at[index, ['distance', 'time']] = [disTime['distance']['value'], disTime['duration']['text']]
             
    except:
        pass 


'''

# save the final file in local drive
new_sample.spatial.to_featureclass(r"test.shp")

print ("Complete!")
disTime
'''

# Export the dataframe into excell for further analysis


sample_len_maxpseed_fclass.to_excel(r'sample_len_maxpseed_fclass.xlsx', index = False)





