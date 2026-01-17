#!/bin/bash

# KidzView GitHub Deployment Script
# Run this script to deploy your website to GitHub Pages

echo "🚀 KidzView GitHub Deployment"
echo "=============================="
echo ""

# Get GitHub username
read -p "Enter your GitHub username: " GITHUB_USERNAME

if [ -z "$GITHUB_USERNAME" ]; then
    echo "❌ Error: GitHub username is required!"
    exit 1
fi

echo ""
echo "📦 Repository will be created at: https://github.com/$GITHUB_USERNAME/kidzview"
echo "🌐 Your site will be available at: https://$GITHUB_USERNAME.github.io/kidzview/"
echo ""
read -p "Continue? (y/n): " CONTINUE

if [ "$CONTINUE" != "y" ]; then
    echo "Deployment cancelled."
    exit 0
fi

echo ""
echo "⚙️  Setting up Git remote..."
git remote add origin https://github.com/$GITHUB_USERNAME/kidzview.git

echo "📤 Pushing to GitHub..."
git branch -M main
git push -u origin main

echo ""
echo "✅ Code pushed successfully!"
echo ""
echo "📋 Next steps:"
echo "1. Go to https://github.com/$GITHUB_USERNAME/kidzview"
echo "2. Click 'Settings' → 'Pages'"
echo "3. Set Source to: Branch 'main', Folder '/docs'"
echo "4. Click 'Save'"
echo ""
echo "⏰ Your site will be live in 2-5 minutes at:"
echo "   https://$GITHUB_USERNAME.github.io/kidzview/"
echo ""
echo "🎉 Deployment complete!"
