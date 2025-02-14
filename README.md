Artsdata JSON-LD Event Score
==============
For the history of this project see discussion thread https://github.com/culturecreates/artsdata-data-model/discussions/120 

## Scoring individual webpages

You can score event's JSON-LD on individual webpages:

1. Browse to [kg.artsdata.ca](https://kg.artsdata.ca/);
2. Click on the menu icon and log in using GitHub (the feature is only accessible to logged in users);
3. In the top right search box, paste a webpage URL;
4. In the options for "External resources", click on *<span style="color:blue;">Dereference</span>* to crawl, retrieve and view the available JSON-LD on the webpage;
5. At the top of the screen, click on the *Plugins* icon and then on *Compute score*;

![image](https://github.com/user-attachments/assets/5bb99b82-c28d-4a45-9f6e-827396fc7dd7)

7. Keep scrolling down until you see a property called to "ex:score" – you will see the absolute score followed by a breakdown of the score for each property;

![image](https://github.com/user-attachments/assets/9e44c57c-e29b-4b9c-ad1c-cf91666e9f29)

8. Scroll further down to "ex:scorePercent" – you will see the score expressed as a percentage.

![image](https://github.com/user-attachments/assets/40e486e0-e9f7-45e5-80aa-5a00287495d7)

## Batch scoring multiple webpages
You can score a batch of events across a website, provided that you can find a webpage that lists the events to score.  

The tool supports JSON-LD that is injected by javascript with the option "headless: true"

Prerequisite:
- you need to be a team member of this repo

Steps:
1. Log-in to Github
1. Go to [Actions](https://github.com/culturecreates/artsdata-score/actions)
1. Click "Run Workflow", enter the parameters and click the green "Run workflow" button. Or you can save the parameters in a workflow file [here](https://github.com/culturecreates/artsdata-score/blob/main/.github/workflows)
1. After a few minutes the workflow will complete and a report will be generated
1. View the CSV table in the [reports directory](https://github.com/culturecreates/artsdata-score/blob/main/reports/). For example the report from [sandersoncentre-ca](https://github.com/culturecreates/artsdata-score/blob/main/reports/sandersoncentre-ca_report.csv)

### Parameters
- URL of the webpage listing all events
- CSS to identify individual event webpages
- File name. Enter any file name with extension `.csv`. Please include the domain of the website. For example: `sandersoncentre-ca_report.csv`
- Is the page paginated? Enter true or false.
- Run in headless mode? Enter true or false.
  
<img width="388" alt="Screenshot 2025-02-14 at 12 46 35 PM" src="https://github.com/user-attachments/assets/64ffed13-d03c-4d51-8d1f-48ee632443e2" />



## To contribute

1. clone the repo
2. cd into the project
3. `bundle install`
4. `rake test`
5. make changes to the SHACL partials, SPARQL and update tests
7. `rake build` to merge all the SHACL partials into a single file


## Revised weighting proposal

As of January 8, 2025

### Required + disambiguation property: 8+4= 12 points

1. startDate with a value that passes Artsdata SHACL validation (proper ISO-8601 syntax or minimal errors that are tolerated by the SHACL validation)

### Required properties: 8 points

2. name
3. location.type with expected object value (i.e. Place object or subtype)

### Disambiguation properties: 4 points
4. location.name
5. location.address.postalCode with valid postal code.
6. location.sameAs with a URI constituting a unique identifier for the object

### Recommended properties: 2 points
7. id with a proper URI constituting a unique identifier for the Event (within the website domain, but distinct from the `url` value)
8. url
9. additionalType
10. description
11. image with a proper url value OR nested ImageObject with a proper image.url value
12. organizer.type with expected object value for the property 
13. organizer.sameAs with a URI constituting a unique identifier for the object
14. performer.type with expected object value for the property 
15. performer.sameAs with a URI constituting a unique identifier for the object
16. offers.type with expected object value for the property (Offer or AggregateOffer)
17. offers.url

### Optional properties: 1 point
18. location.address.type
19. location.url
20. location.address.streetAddress
21. location.address.addressLocality
22. location.address.addressRegion
23. location.address.addressCountry
24. doorTime
29. duration
25. endDate
26. [eventStatus](https://schema.org/eventStatus)
27. [eventAttendanceMode](https://schema.org/eventAttendanceMode)
28. mainEntityOfPage.url

### Minimum and maximum score
| **Status** | **Absolute score** | **Percentage score** |
| -------- | ------- | ------- |
| Event does not have all required properties  | 0 | 0 % |
| Event has all required properties | 28 | 50 % |
| Event has required and reconciliation properties | 40 | 63% |
| Event has required, reconciliation and recommended properties | 62 | 87% |
| Maximum score | 74 | 100% |

## TODO  
- support more schema:Event sub-types. Currently only schema:Event, schema:MusicEvent, schema:TheaterEvent.
