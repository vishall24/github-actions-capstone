# -------- Stage 1: Builder --------
  FROM node:20-alpine AS builder
  
  WORKDIR /app
  
  RUN apk update && apk upgrade --no-cache

  COPY package.json ./
  RUN npm ci
  
  COPY . .

# -------- Stage 2: Final --------
  FROM node:20-alpine
  
  WORKDIR /app
  
  RUN apk update && apk upgrade --no-cache

  # Create non-root user
  RUN adduser -D appuser
  
  # Copy only required files from builder
  COPY --from=builder /app /app
  
  # Fix permissions
  RUN chown -R appuser /app
  
  # Switch user
  USER appuser
  
  CMD ["node", "app.js"]