-- Creating the User table
CREATE TABLE "User" (
  user_id SERIAL PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  username VARCHAR(100) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Creating the Profile table
CREATE TABLE "Profile" (
  profile_id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  bio TEXT,
  profile_picture VARCHAR(255),
  privacy_settings JSONB,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES "User" (user_id) ON DELETE CASCADE
);

-- Creating the Post table
CREATE TABLE "Post" (
  post_id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  is_hidden BOOLEAN DEFAULT FALSE,
  FOREIGN KEY (user_id) REFERENCES "User" (user_id) ON DELETE CASCADE
);

-- Creating the Comment table
CREATE TABLE "Comment" (
  comment_id SERIAL PRIMARY KEY,
  post_id INT NOT NULL,
  user_id INT NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (post_id) REFERENCES "Post" (post_id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES "User" (user_id) ON DELETE CASCADE
);

-- Creating the Reaction table
CREATE TABLE "Reaction" (
  reaction_id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  post_id INT,
  comment_id INT,
  reaction_type VARCHAR(50) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES "User" (user_id) ON DELETE CASCADE,
  FOREIGN KEY (post_id) REFERENCES "Post" (post_id) ON DELETE
  SET
    NULL,
    FOREIGN KEY (comment_id) REFERENCES "Comment" (comment_id) ON DELETE
  SET
    NULL
);