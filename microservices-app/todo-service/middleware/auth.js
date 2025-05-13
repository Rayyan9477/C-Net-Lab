const axios = require('axios');

// Authentication middleware that verifies JWT with auth service
const authMiddleware = async (req, res, next) => {
  try {
    // Get token from header
    const token = req.headers.authorization;
    
    if (!token) {
      return res.status(401).json({ message: 'Authentication required' });
    }

    // Verify token with auth service
    const response = await axios.post(
      `${process.env.AUTH_SERVICE_URL}/api/auth/verify`,
      {},
      { headers: { Authorization: token } }
    );

    if (!response.data.valid) {
      return res.status(401).json({ message: 'Invalid token' });
    }

    // Add user data to request
    req.user = {
      userId: response.data.userId,
      username: response.data.username
    };
    
    next();
  } catch (error) {
    console.error('Auth verification error:', error.message);
    res.status(401).json({ message: 'Authentication failed' });
  }
};

module.exports = { authMiddleware };
