import React from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';
import JobListings from './components/JobListings';
import ApplyJob from './components/ApplyJob';

function App() {
  return (
    <Router>
      <div>
        <Switch>
          <Route path="/job_listings" component={JobListings} />
          <Route path="/apply_job/:id" component={ApplyJob} />
        </Switch>
      </div>
    </Router>
  );
}

export default App;
