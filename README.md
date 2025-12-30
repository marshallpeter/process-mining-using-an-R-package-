# process-mining-using-an-R-package
How to do Process Mining in R using an in-built events log dataset

The dataset (hospital_billing) used for this demo is in-built within the BUPA package.
Hospital billing log
Description
The 'Hospital Billing' event log was obtained from the financial modules of the ERP system of a regional hospital. 
The event log contains events that are related to the billing of medical services that have been provided by the 
hospital. Each trace of the event log records the activities executed to bill a package of medical services that 
were bundled together. The event log does not contain information about the actual medical services provided by 
the hospital. The 100,000 traces in the event log are a random sample of process instances that were recorded 
over three years. Several attributes such as the 'state' of the process, the 'caseType', the underlying 
'diagnosis' etc. are included in the event log. Events and attribute values have been anonymized. 
The time stamps of events have been randomized for this purpose, but the time between events within a trace 
has not been altered. More information about the event log can be found in the related publications.

Process Mining package - bupaR
An open-source suite for the handling and analysis of business process data in 
R developed by the Business Informatics research group at Hasselt University, 
Belgium. It builds upon the concept of an event log which is a logbook of 
events which have happened and were recorded within the execution of a 
business process.