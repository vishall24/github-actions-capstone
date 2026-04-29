# -------- Stage 1: Builder --------
  FROM node:18-alpine AS builder
  
  WORKDIR /app
  
  COPY package.json ./
  RUN npm install
  
  COPY . .

# -------- Stage 2: Final --------
  FROM node:18-alpine
  
  WORKDIR /app
  
  # Create non-root user
  RUN adduser -D appuser
  
  # Copy only required files from builder
  COPY --from=builder /app /app
  
  # Fix permissions
  RUN chown -R appuser /app
  
  # Switch user
  USER appuser
  
  CMD ["node", "app.js"]