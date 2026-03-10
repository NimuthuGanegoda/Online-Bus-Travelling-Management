
import React, { useState } from 'react';
import './Login.css';

const Login = () => {
  const [modal, setModal] = useState(true);

  const toggleModal = () => {
    setModal(!modal);
  };

  return (
    <div className="login-page">
      <div className="header">
        <h1>SL Bus Track</h1>
        <h2>Admin Control Panel</h2>
        <p>Authorised Personnel Only</p>
      </div>

      <div className="input-container">
        <label htmlFor="username">Admin ID / Username</label>
        <div className="input-field">
          <span>[Admin]</span>
          <input type="text" id="username" placeholder="Enter admin username" />
        </div>
      </div>

      <div className="input-container">
        <label htmlFor="password">Password</label>
        <div className="input-field">
          <span>[Lock]</span>
          <input type="password" id="password" placeholder="Enter password" />
        </div>
      </div>

      {modal && (
        <div className="modal">
          <div className="modal-content">
            <h3>Login</h3>
            <div className="form-group">
              <label htmlFor="modal-username">Username</label>
              <input type="text" id="modal-username" />
            </div>
            <div className="form-group">
              <label htmlFor="modal-password">Password</label>
              <input type="password" id="modal-password" />
            </div>
            <button onClick={toggleModal}>Login</button>
          </div>
        </div>
      )}
    </div>
  );
};

export default Login;
