import React from 'react';
import { useParams } from 'react-router-dom';
import axios from 'axios';

function ApplyJob() {
  const { id } = useParams();

  const applyForJob = () => {
    axios.post('/applied_jobs', { job_listing_id: id })
      .then(response => alert('Applied successfully'))
      .catch(error => console.log(error));
  };

  return (
    <div>
      <h1>Apply for Job</h1>
      <button onClick={applyForJob}>Apply</button>
    </div>
  );
}

export default ApplyJob;
