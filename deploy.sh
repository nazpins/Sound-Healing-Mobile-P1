#!/bin/bash

echo "🚀 Starting Deployment..."

# Ensure Git is initialized
git init
git remote add origin https://github.com/nazpins/Sound-Healing-Mobile-P1.git || true
git pull origin main --allow-unrelated-histories

# Create project folders
mkdir -p mobile web backend docs models sounds deployment

# Setup Web App (Next.js)
echo "Setting up Next.js Web App..."
cd web || exit
npm init -y
npm install next react react-dom
echo "{
  \"scripts\": { \"dev\": \"next dev\" }
}" > package.json
cd ..

# Setup Backend (FastAPI)
echo "Setting up FastAPI Backend..."
cd backend || exit
pip install fastapi uvicorn
echo "from fastapi import FastAPI

app = FastAPI()

@app.get('/')
def read_root():
    return {\"message\": \"Sound Healing API is running\"}" > main.py
cd ..

# Setup Mobile (Flutter)
echo "Setting up Flutter Mobile App..."
cd mobile || exit
flutter create .
cd ..

# Commit and push everything
echo "Pushing to GitHub..."
git add .
git commit -m "Auto-deploy setup"
git push origin main

# Deploy Web App to Vercel
echo "Deploying Web App to Vercel..."
npm install -g vercel
vercel deploy --prod

echo "✅ Deployment Complete!"