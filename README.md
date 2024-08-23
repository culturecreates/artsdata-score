## Revised weighting proposal
Taking into account all the excellent feedback provided so far, I would like to propose this revised weighting. It introduces a new category worth 4 points for properties that are deemed useful for disambiguation. Required properties are given a weight of 8 points and recommended properties are brought down to a weight of 2 points to address concerns that recommended properties may collectively have a higher cumulative value than required properties. I also propose to integrate @christianroy's proposal to give a null score if an event does not have all three required properties. 

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

### Other properties: 1 point

- Any other property with an expected value (including "location.address.type", which I'm proposing to bump down for simplicity's sake and to balance the total weighting of _space_ attributes compared to _time_ attributes).

Under this proposal:
- An event with all three required properties would have a score of 12 + (2 x 8) = 28. 
    - If any of the three required properties is missing, the score would be 0 (zero), no matter how good the rest of the structured data is.
- An event with all three disambiguation properties would have 12 additional points, for a sub-total of 40.
- An event with all 11 recommended properties would have 22 additional points. If other contributors wished to keep the weight of recommended properties to 3, the total would be 33, which is in the same ball park as the value of required properties.