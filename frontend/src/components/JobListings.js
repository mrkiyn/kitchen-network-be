import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import axios from 'axios';

function JobListings() {
  const [jobListings, setJobListings] = useState([]);

  useEffect(() => {
    axios.get('/job_listings')
      .then(response => setJobListings(response.data))
      .catch(error => console.log(error));
  }, []);

  return (
    <div>
      <h1>Job Listings</h1>
      <ul>
        {jobListings.map(job => (
          <li key={job.id}>
            <Link to={`/apply_job/${job.id}`}>{job.title}</Link>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default JobListings;
