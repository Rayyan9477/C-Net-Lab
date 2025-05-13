import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import todoService from '../services/todo.service';
import authService from '../services/auth.service';

const TodoList = () => {
  const [todos, setTodos] = useState([]);
  const [newTodo, setNewTodo] = useState({ title: '', description: '' });
  const [message, setMessage] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    // Check if user is logged in
    const user = authService.getCurrentUser();
    if (!user) {
      navigate('/login');
      return;
    }

    // Load todos
    fetchTodos();
  }, [navigate]);

  const fetchTodos = async () => {
    try {
      setLoading(true);
      const data = await todoService.getAllTodos();
      setTodos(data);
      setError('');
    } catch (err) {
      setError('Failed to fetch todos. Please try again later.');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setNewTodo({ ...newTodo, [name]: value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!newTodo.title.trim()) {
      setError('Title is required');
      return;
    }

    try {
      const createdTodo = await todoService.createTodo(newTodo);
      setTodos([createdTodo, ...todos]);
      setNewTodo({ title: '', description: '' });
      setMessage('Todo created successfully!');
      setTimeout(() => setMessage(''), 3000);
    } catch (err) {
      setError('Failed to create todo. Please try again.');
      console.error(err);
    }
  };

  const handleStatusChange = async (id, status) => {
    try {
      const updatedTodo = await todoService.updateTodo(id, { status });
      setTodos(todos.map(todo => todo._id === id ? updatedTodo : todo));
    } catch (err) {
      setError('Failed to update todo status.');
      console.error(err);
    }
  };

  const handleDelete = async (id) => {
    if (!window.confirm('Are you sure you want to delete this todo?')) return;
    
    try {
      await todoService.deleteTodo(id);
      setTodos(todos.filter(todo => todo._id !== id));
      setMessage('Todo deleted successfully!');
      setTimeout(() => setMessage(''), 3000);
    } catch (err) {
      setError('Failed to delete todo.');
      console.error(err);
    }
  };

  const handleLogout = () => {
    authService.logout();
    navigate('/login');
  };

  return (
    <div className="container mt-4">
      <div className="d-flex justify-content-between align-items-center mb-4">
        <h1>Todo List</h1>
        <button onClick={handleLogout} className="btn btn-outline-danger">Logout</button>
      </div>

      {message && (
        <div className="alert alert-success" role="alert">
          {message}
        </div>
      )}

      {error && (
        <div className="alert alert-danger" role="alert">
          {error}
        </div>
      )}

      <div className="card mb-4">
        <div className="card-header">
          <h4>Add New Todo</h4>
        </div>
        <div className="card-body">
          <form onSubmit={handleSubmit}>
            <div className="mb-3">
              <label htmlFor="title" className="form-label">Title</label>
              <input
                type="text"
                className="form-control"
                id="title"
                name="title"
                value={newTodo.title}
                onChange={handleInputChange}
                required
              />
            </div>
            <div className="mb-3">
              <label htmlFor="description" className="form-label">Description</label>
              <textarea
                className="form-control"
                id="description"
                name="description"
                value={newTodo.description}
                onChange={handleInputChange}
                rows="3"
              ></textarea>
            </div>
            <button type="submit" className="btn btn-primary">Add Todo</button>
          </form>
        </div>
      </div>

      {loading ? (
        <div className="text-center">
          <div className="spinner-border" role="status">
            <span className="visually-hidden">Loading...</span>
          </div>
        </div>
      ) : (
        <div className="row">
          {todos.length === 0 ? (
            <div className="col-12">
              <div className="alert alert-info">No todos found. Add your first todo above!</div>
            </div>
          ) : (
            todos.map(todo => (
              <div className="col-md-6 col-lg-4 mb-3" key={todo._id}>
                <div className="card h-100">
                  <div className="card-header d-flex justify-content-between align-items-center">
                    <h5 className="mb-0">{todo.title}</h5>
                    <div className="dropdown">
                      <button className="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id={`status-${todo._id}`} data-bs-toggle="dropdown" aria-expanded="false">
                        {todo.status}
                      </button>
                      <ul className="dropdown-menu" aria-labelledby={`status-${todo._id}`}>
                        <li><button className="dropdown-item" onClick={() => handleStatusChange(todo._id, 'pending')}>Pending</button></li>
                        <li><button className="dropdown-item" onClick={() => handleStatusChange(todo._id, 'in-progress')}>In Progress</button></li>
                        <li><button className="dropdown-item" onClick={() => handleStatusChange(todo._id, 'completed')}>Completed</button></li>
                      </ul>
                    </div>
                  </div>
                  <div className="card-body">
                    <p className="card-text">{todo.description || 'No description provided.'}</p>
                    <p className="card-text"><small className="text-muted">Created: {new Date(todo.createdAt).toLocaleString()}</small></p>
                  </div>
                  <div className="card-footer text-end">
                    <button onClick={() => handleDelete(todo._id)} className="btn btn-sm btn-danger">Delete</button>
                  </div>
                </div>
              </div>
            ))
          )}
        </div>
      )}
    </div>
  );
};

export default TodoList;
