#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import pandas as pd
import networkx as nx

network_data=pd.read_csv("network_data.csv")
network_data.head()
# Create the network
settlement_graph=nx.from_pandas_edgelist(network_data, source="dest_mgrs",target="mgrs_code")

# Summary of the network 
nx.info(settlement_graph)

# Visualize the network

import matplotlib.pyplot as plt
%matplotlib inline

nx.draw(settlement_graph)
plt.figure(figsize=(10000,10000))
nx.draw_networkx(settlement_graph)
plt.show()

# Prepare the network data for visualization in gephi
nx.write_gexf(settlement_graph, "gephi.gexf")

# Analyze network metrics

# Calculate degree centrality
degree_centrality_score=nx.degree_centrality(settlement_graph)

# Convert the degree centrality dictionary into data frame
df_degree = pd.DataFrame(list(degree_centrality_score.items()), columns = ['dest_mgrs','degree_centrality'])

# Rank nodes in order with degree centrality
df_degree['rank_degree_centrality'] = df_degree['degree_centrality'].rank(ascending=False)

# Merge degree centrality with network data
df_merged_degree=network_data.merge(df_degree, on='dest_mgrs', how='left')


# Calculate betweennes centrality
betweenness_centrality_score=nx.betweenness_centrality(settlement_graph)

# Convert the betweenness centrality dictionary into data frame
df_betweenness = pd.DataFrame(list(betweenness_centrality_score.items()), columns = ['dest_mgrs','betweenness_centrality'])

# Rank nodes in order with betweenness centrality
df_betweenness['rank_betweenness_centrality'] = df_betweenness['betweenness_centrality'].rank(ascending=False)

# Merge betweenness centrality with network data
df_merged_degree_betweenness=df_merged_degree.merge(df_betweenness, on='dest_mgrs', how='left')


# Calculate closeness centrality
closeness_centrality_score=nx.closeness_centrality(settlement_graph)

# Convert the closeness centrality dictionary into data frame
df_closeness = pd.DataFrame(list(closeness_centrality_score.items()), columns = ['dest_mgrs','closeness_centrality'])

# Rank nodes in order with closeness centrality
df_closeness['rank_closeness_centrality'] = df_closeness['closeness_centrality'].rank(ascending=False)

# Merge betweenness centrality with network data
df_merged=df_merged_degree_betweenness.merge(df_closeness, on='dest_mgrs', how='left')

# Export to excell
df_merged.to_excel(r'network_data_sn_metrics.xlsx', index = False)


# Prepare work flow optimization #

import pandas as pd
import numpy as np
import math
import networkx as nx
import matplotlib.pyplot as plt
from itertools import permutations

network_data=pd.read_csv("network_data.csv")
network_data.head()

# Further reference: https://towardsdatascience.com/solving-the-travelling-salesman-problem-for-germany-using-networkx-in-python-2b181efd7b07
# Choose the settlement you want to begin, visit and return back to the starting point
# Start and end are both 34MCA9323_02
settlements = ['34MCA9323_02','34MCA9624_02','34MDA7554_01',
               '34MDA8550_01','34MCA9721_01','34MCA9323_02']
start, *rest, end = settlements

# We need to get permutation of rest of the settlements considering all of them
paths = [(start, *path,end) for path in permutations (rest,len(rest))]
paths

def make_tsp_tree (settlements):
    """
    Create all Hamilton paths from start to end city from a list of settlements.
    Creates a directed prefix tree from a list of the created paths. 
    Remove the root node and nil node.
    """
    start, *rest, end = settlements
    paths = [(start, *path, end) for path in permutations(rest)]
    
    # Create a directed prefix from a list of paths
    G = nx.prefix_tree(paths)
    
    # Remove synthetic root node (None) and nil node (NIL)
    G.remove_nodes_from([0, -1])
    
    return G

# Get graph object with all Hamilton paths
G = make_tsp_tree(settlements)

G = nx.Graph()
nodes = np.arange(0,len(settlements))
G.add_nodes_from(nodes)

# Create a dictionary of node and capital for labels
labels = {node:capital for node, capital in zip(nodes, settlements) }

# Create all possible paths between any settlements
# This creates paths even if there is no path in real life
# so if the path doesn't exist in real, that path will get penalized heavily to avoid getting selected
'''
# A way to create dummy paths
for i in nodes:
    for j in nodes:
        if i!=j:
            G.add_edge(i, j)
'''

#Calculating the distances between the nodes as edge's weight.
# First for loop is for the settlement you travel 'from'
for i in range(len(settlements)):
# Second for loop is for the settlement you travel 'to'
     for j in range(i + 1, len(settlements)):
# Third for loop is for retrieving the data from our table     
         for z in range(len(network_data)):
# if 'from' and 'to' settlements we manually selected matches with our table          
             if settlements[i] == network_data['dest_mgrs'][z] and settlements [j] == network_data['mgrs_code'][z]:
# save the distance                 
                 dist=network_data['dist_min'][z]
# add an edge             
                 G.add_edge(i, j, weight=dist)
# if there is no connection in real penalize create an edge and heavily penalize
             else:
                 dist=9999999999999
                 G.add_edge(i, j, weight=dist)

# Start optimization algorithm
'''
The related networkx documentation 
https://networkx.org/documentation/stable/auto_examples/drawing/plot_tsp.html
'''

import networkx.algorithms.approximation as nx_app

cycle = nx_app.christofides(G, weight="weight")
edge_list = list(nx.utils.pairwise(cycle))

# Create a dictionary of node and settlements labels to plot the solution
labels = {node:settlements for node, settlements in zip(nodes, settlements) }
tap_cycle = [labels[value] for value in cycle]

# Print the shortest path
print (tap_cycle)


# Create Visualizations

import networkx as nx
from networkx.drawing.nx_agraph import graphviz_layout
import matplotlib.pyplot as plt

# Create directed graphs
G = nx.DiGraph()

# Add Root node
G.add_node("34MCA9323_02")

'''
The other nodes are 34MDA8550_01, 34MDA7554_01, 34MCA9721_01 but if their id is used
the graph becomes hard to read so 
X1 will be used for 34MDA8550_01
X2 will be used for 34MDA7554_01
X3 will be used for 34MCA9721_01
'''
# 
G.add_node("X1")
G.add_node("X2")
G.add_node("X3")

# Create dummy nodes to avoid confusion in graphs.If not created that the hirearchical visual cannont be made

# Create nodes that will visited after visiting X1
G.add_node("X2 ")
G.add_node("X3 ")

# Create nodes that will be visited after dummy X2 and X3
G.add_node(" X2")
G.add_node(" X3")

# Create the nodes that will visited after visiting X2         
G.add_node("X1 ")
G.add_node(" X3 ")

# Create nodes that will be visited after dummy X1 and X3
G.add_node(" X1 ")
G.add_node(" X3  ")

# Create the nodes that will visited after visiting X3         
G.add_node(" X1  ")
G.add_node(" X2 ")

# Create nodes that will be visited after dummy X1 and X2
G.add_node("  X2  ")
G.add_node("  X1 ")

          
# Add edges between nodes
G.add_edge("34MCA9323_02", "X1")
G.add_edge("34MCA9323_02", "X2")
G.add_edge("34MCA9323_02", "X3")

# Add edges to complete the cycle for X1
G.add_edge("X1", "X2 ")
G.add_edge("X1", "X3 ")

# Add edges to visit other dummy nodes after visiting the previous ones
G.add_edge("X2 "," X3")
G.add_edge("X3 "," X2")

# Add edges to return back to the origin
G.add_edge(" X3"," 34MCA9323_02 ")
G.add_edge(" X2"," 34MCA9323_02 ")

# Add edges to complete the cycle for X2
G.add_edge("X2", "X1 ")
G.add_edge("X2", " X3 ")

# Add edges to visit other dummy nodes after visiting the previous ones
G.add_edge("X1 "," X3  " )
G.add_edge(" X3 "," X1 ")

# Add edges to return back to the origin
G.add_edge(" X3  " ," 34MCA9323_02 ")
G.add_edge(" X1 "," 34MCA9323_02 ")

# Add edges to complete the cycle for X3
G.add_edge("X3", " X1  ")
G.add_edge("X3", " X2 ")

# Add edges to visit other dummy nodes after visiting the previous ones
G.add_edge(" X1  ","  X2  " )
G.add_edge(" X2 ","  X1 ")

# Add edges to return back to the origin
G.add_edge("  X2  " ," 34MCA9323_02 ")
G.add_edge("  X1 " ," 34MCA9323_02 ")


# write dot file to use with graphviz
# run "dot -Tpng test.dot >test.png"
nx.nx_agraph.write_dot(G,'test.dot')

# same layout using matplotlib with no labels
plt.title('Paths for starting in a settlement and visiting all and returning back')
pos=graphviz_layout(G, prog='dot')
nx.draw(G, pos, with_labels=True, arrows=True)
plt.savefig('nx_test.png')

# Visualize the best route
H = nx.DiGraph()

# Add base node
H.add_node("34MCA9323_02")
# Add the nodes that will be visited
H.add_node("34MDA8550_01")
H.add_node("34MDA7554_01")
H.add_node("34MCA9721_01")

# Add edges between them
H.add_edge("34MCA9323_02", "34MDA8550_01")
H.add_edge("34MDA8550_01", "34MDA7554_01")
H.add_edge("34MDA7554_01", "34MCA9721_01")
H.add_edge("34MCA9721_01", "34MCA9323_02 ")
nx.nx_agraph.write_dot(G,'test.dot')

# Same layout using matplotlib with no labels
plt.title('Best Route')
pos=graphviz_layout(H, prog='dot')
nx.draw(H, pos, with_labels=True, arrows=True)


# Create graph using coordinates

# Get coordinates to use visualization
import geopandas as gpd
df = gpd.read_file('/Users/0ox/Desktop/settlement_coordinates/settlement_coordinates/kasai_sett_extent_point.shp')

# Coordinates of the node 34MCA9323_02
df[df["mgrs_code"]=='34MCA9323_02']['lat']
df[df["mgrs_code"]=='34MCA9323_02']['long']

# Coordinates of the node 34MDA8550_01
df[df["mgrs_code"]=='34MDA8550_01']['lat']
df[df["mgrs_code"]=='34MDA8550_01']['long']

# Coordinates of the node 34MDA7554_01
df[df["mgrs_code"]=='34MDA7554_01']['lat']
df[df["mgrs_code"]=='34MDA7554_01']['long']

# Coordinates of the node 34MCA9721_01
df[df["mgrs_code"]=='34MCA9721_01']['lat']
df[df["mgrs_code"]=='34MCA9721_01']['long']

# Create the graph based on coordinates
import networkx as nx

# Create the base graph
H = nx.Graph()

# Create nodes using the coordinates
H.add_node('34MCA9323_02', pos=(-4.314714, 20.042427))
H.add_node('34MDA8550_01', pos=(-4.06352, 20.868049))
H.add_node('34MDA7554_01', pos=(-4.026776, 20.782139))
H.add_node('34MCA9721_01', pos=(-4.332491, 20.076641))

# Add edges
H.add_edge('34MCA9323_02', '34MDA8550_01')
H.add_edge('34MDA8550_01', '34MDA7554_01')
H.add_edge('34MDA7554_01', '34MCA9721_01')
H.add_edge('34MCA9721_01', '34MCA9323_02')

# Print the graph
nx.draw(H, with_labels=True, arrows=True)

