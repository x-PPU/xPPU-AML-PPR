# xPPU-AML-PPR

The project demonstrates how relations between processes, products, and resources (PPR) can be extracted from AML files.
The connections are extracted in the form of triples (product,process,resource).

## Contents
* xPPU.aml - AML file for the extended Pick and Place Unit, includes products, processes, and resources
* Queries - xQueries for extracting PPR-connections
* QueryOutput - expected query outputs
* CSV - query outputs transformed to more readable csv files
* src/converter.py - convert xml query outputs to csv

## Prerequisites

Visualization:
[AutomationML Software](https://www.automationml.org/o.red.c/dateien.html) 
Filter for software to get the latest release

Software:
* BaseX 9.4.6+ for running xQueries
* Python 3.6+ recommended for converting query results to CSV

AutomationML Documentation:
[AutomationML Homepage](https://www.automationml.org/o.red.c/dateien.html)
Recommended articles:\
Whitepaper AutomationML Edition 2.1 2018

## xPPU Documentation

The [extended Pick and Place Unit (xPPU)](https://www.mw.tum.de/en/ais/research/equipment/ppu/) works as a demonstrator for complex industrial plants.
It stamps and sorts different kinds of workpieces. For every workpiece different processes require different resources.

## Walkthrough - information extraction

### Structure
All products, processes, and resources are stored in the InstanceHierarchy of the xPPU.aml file as InternalElements. The AutomationML Editor helps to get familiar with the structure of the xPPU. 
The connections between products, processes, and resources are modeled with Connectors, which are specified in the RoleClassLib. For instance, the connector "Connector_Product_Proces_instance_1" connects products to processes.
It is possible to see all connections by activationg the XML-Viewer (PlugIns/XMLViewer/activate)
<img width="1271" alt="screenshot" src="https://user-images.githubusercontent.com/21101473/106473675-56497180-64a4-11eb-88f7-f868658b7d0c.PNG">
The InternalLinks from line 28-31 show one connection of the BlackPlasticWP. Every Connection consists of a Name, a RefPartnerSideA, and a RefPartnerSideB. 
RefPartnerSideA is a unique ID, which identifies the InternalElement. The screenshot shows the connections of the BlackPlasticWP and therefore the ID of RefPartnerSideB is always the ID of the BlackPlasticWP.

### Connection extraction
The queries extract connections by looping over the products, processes, and resources and collect all InternalLinks. For better usability Name and ID are extracted. The output can only be structured as an xml file and therefore has to be preprocessed afterwards. The Queries can be run in BaseX or any other Query tool.

### Convert output to CSV
src/converter.py converts the output from BaseX to csv for better readability 

