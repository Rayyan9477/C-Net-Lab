import axios from 'axios';

// Base URLs for services - will be proxied by Nginx in production
const API_URL = process.env.NODE_ENV === 'production' 
  ? '' 
  : 'http://localhost:8080';

const authService = {
  register: async (userData) => {
    const response = await axios.post(`${API_URL}/api/auth/register`, userData);
    return response.data;
  },
  
  login: async (credentials) => {
    const response = await axios.post(`${API_URL}/api/auth/login`, credentials);
    if (response.data.token) {
      localStorage.setItem('user', JSON.stringify(response.data));
    }
    return response.data;
  },
  
  logout: () => {
    localStorage.removeItem('user');
  },
  
  getCurrentUser: () => {
    const userStr = localStorage.getItem('user');
    if (userStr) return JSON.parse(userStr);
    return null;
  },
  
  getProfile: async () => {
    const user = authService.getCurrentUser();
    if (!user) throw new Error('Not authenticated');
    
    const response = await axios.get(`${API_URL}/api/auth/profile`, {
      headers: {
        'Authorization': `Bearer ${user.token}`
      }
    });
    return response.data;
  }
};

export default authService;
