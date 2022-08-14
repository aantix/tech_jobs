# TechJobs

Streamline the process of finding your next job.  Search for jobs that work with a specific technology, then find
the contact information for the CTO, Director/VP of engineering, etc.

## Installation

    $ gem install tech_jobs

    
## Requirements
Sign-up for Rapid API's Google Job search.  This provides the jobs listings for a given technology. 

https://rapidapi.com/letscrape-6bRBa3QguO5/api/google-jobs-search/

Export the listed `X-RapidAPI-Key` as

```
export RAPID_API_KEY='373fb80abmsh8b021e95e05934fr1fac8ajsnaf813176dd71'
```

Sign up for Apollo.io.  This service finds the appropriate contacts for a given job along with their full name and email.

https://www.apollo.io/signup/

Grab an Apollo API search key

https://developer.apollo.io/keys/

Export the listed key as 

```
export APOLLO_API_KEY='7Fm8p1XYZ4sWuB9zkb_4IQ'
```

## Usage

```
tech_jobs "node.js" "94132" "cto,vp of engineering,director of engineering"
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
