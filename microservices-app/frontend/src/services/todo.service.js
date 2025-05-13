import axios from 'axios';
import authService from './auth.service';

// Base URLs for services - will be proxied by Nginx in production
const API_URL = process.env.NODE_ENV === 'production' 
  ? '' 
  : 'http://localhost:8080';

// Add token to API requests
const authAxios = axios.create();

authAxios.interceptors.request.use(
  (config) => {
    const user = authService.getCurrentUser();
    if (user && user.token) {
      config.headers.Authorization = `Bearer ${user.token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

const todoService = {
  getAllTodos: async () => {
    const response = await authAxios.get(`${API_URL}/api/todos`);
    return response.data;
  },
  
  getTodo: async (id) => {
    const response = await authAxios.get(`${API_URL}/api/todos/${id}`);
    return response.data;
  },
  
  createTodo: async (todoData) => {
    const response = await authAxios.post(`${API_URL}/api/todos`, todoData);
    return response.data;
  },
  
  updateTodo: async (id, todoData) => {
    const response = await authAxios.put(`${API_URL}/api/todos/${id}`, todoData);
    return response.data;
  },
  
  deleteTodo: async (id) => {
    const response = await authAxios.delete(`${API_URL}/api/todos/${id}`);
    return response.data;
  }
};

export default todoService;
