import React from 'react';
import { Link } from 'react-router-dom';

const Home = () => {
  return (
    <div className="container mt-5">
      <div className="jumbotron text-center">
        <h1 className="display-4">Welcome to Todo Microservices App</h1>
        <p className="lead">
          A production-grade microservices application built with Node.js, React, and Docker
        </p>
        <hr className="my-4" />
        <p>
          This application demonstrates a complete microservices architecture with authentication,
          data management, and a responsive frontend.
        </p>
        <div className="mt-4">
          <Link to="/login" className="btn btn-primary me-3">
            Login
          </Link>
          <Link to="/register" className="btn btn-success">
            Register
          </Link>
        </div>
      </div>

      <div className="row mt-5">
        <div className="col-md-4">
          <div className="card mb-4">
            <div className="card-body">
              <h5 className="card-title">Authentication Service</h5>
              <p className="card-text">
                Secure user authentication and authorization with JWT tokens.
              </p>
            </div>
          </div>
        </div>
        <div className="col-md-4">
          <div className="card mb-4">
            <div className="card-body">
              <h5 className="card-title">Todo Service</h5>
              <p className="card-text">
                Manage your tasks with full CRUD operations.
              </p>
            </div>
          </div>
        </div>
        <div className="col-md-4">
          <div className="card mb-4">
            <div className="card-body">
              <h5 className="card-title">React Frontend</h5>
              <p className="card-text">
                Responsive and intuitive user interface built with React.
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Home;
