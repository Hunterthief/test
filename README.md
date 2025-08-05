# SoFlu - Modern Language Learning App

A modern, dynamic web application for interactive language learning designed for children. Built with React and featuring a complete content management system.

## 🚀 Features

- **Dynamic Content Management**: All content loaded from configuration files
- **Multilingual Support**: English, Arabic, and French with easy expansion
- **Audio Integration**: Click-to-play audio with automatic file matching
- **Responsive Design**: Works on all devices and screen sizes
- **Dark/Light Theme**: User preference with persistence
- **Progressive Web App**: Installable and works offline
- **Accessibility**: Full keyboard navigation and screen reader support

## 📁 Project Structure

```
src/
├── components/          # Reusable UI components
│   ├── AudioPlayer.js   # Audio playback component
│   ├── ImageGallery.js  # Dynamic image gallery
│   ├── NavigationButton.js # Styled navigation buttons
│   ├── PageTemplate.js  # Page layout template
│   └── ...
├── pages/              # Page components
│   ├── HomePage.js     # Main landing page
│   ├── SkillsPage.js   # Skills overview
│   ├── SkillCategoryPage.js # Individual skill categories
│   └── ...
├── utils/              # Utility functions
│   ├── contentScanner.js # Dynamic content discovery
│   ├── audioManager.js   # Audio playback management
│   └── routeGenerator.js # Dynamic route generation
├── contexts/           # React contexts
│   └── ThemeContext.js # Theme management
└── i18n/              # Internationalization
    ├── en.json        # English translations
    ├── ar.json        # Arabic translations
    ├── fr.json        # French translations
    └── index.js       # i18n configuration

public/content/
├── navigation.json     # Navigation structure
├── images/            # Image assets by category
│   ├── skills/
│   │   ├── animals/
│   │   ├── fruits/
│   │   └── ...
│   └── covers/        # Cover images for sections
└── audio/             # Audio assets by category
    ├── skills/
    │   ├── animals/
    │   ├── fruits/
    │   └── ...
    └── stories/       # Story narrations
```

## 🛠️ Setup Instructions

### Prerequisites
- Node.js 16+ and npm
- Modern web browser

### Installation

1. **Clone and install dependencies:**
```bash
git clone <repository-url>
cd soflu-web
npm install
```

2. **Set up content structure:**
```bash
# Create content directories
mkdir -p public/content/images/skills
mkdir -p public/content/audio/skills
mkdir -p public/content/images/covers

# Run content scanner to generate manifests
npm run content:scan
```

3. **Start development server:**
```bash
npm start
```

The app will open at `http://localhost:3000`

## 📝 Adding New Content

### Adding a New Skill Category

1. **Create image folder:**
```bash
mkdir public/content/images/skills/new-category
```

2. **Add images:**
   - Drop image files into the folder
   - Supported formats: `.jpg`, `.jpeg`, `.png`, `.gif`, `.webp`, `.svg`

3. **Add matching audio files:**
```bash
mkdir public/content/audio/skills/new-category
```
   - Audio files should match image names (e.g., `cat.jpg` → `cat.mp3`)
   - Supported formats: `.mp3`, `.wav`, `.ogg`, `.m4a`, `.aac`

4. **Update navigation configuration:**

Edit `public/content/navigation.json`:
```json
{
  "main": [
    {
      "id": "skills",
      "children": [
        {
          "id": "new-category",
          "labelKey": "skills.newCategory",
          "route": "/skills/new-category",
          "icon": "🆕",
          "coverImage": "/content/images/skills/new-category/cover.jpg"
        }
      ]
    }
  ]
}
```

5. **Add translations:**

In `src/i18n/en.json`:
```json
{
  "skills": {
    "newCategory": "New Category"
  }
}
```

In `src/i18n/ar.json`:
```json
{
  "skills": {
    "newCategory": "فئة جديدة"
  }
}
```

6. **Generate manifest:**
```bash
npm run content:scan
```

### Adding Stories

1. **Create story content file:**
```json
// public/content/stories/my-story.json
{
  "titleKey": "stories.myStory",
  "audioPath": "/content/audio/stories/my-story.mp3",
  "content": "Story content here..."
}
```

2. **Add to navigation and translations** (same process as above)

## 🎨 Customization

### Themes
Edit `src/contexts/ThemeContext.js` to customize colors and styling.

### Languages
Add new language files in `src/i18n/` and update the language switcher.

### Components
All components are modular and can be easily customized or extended.

## 🔧 Available Scripts

- `npm start` - Start development server
- `npm run build` - Build for production
- `npm test` - Run tests
- `npm run content:scan` - Scan content and generate manifests

## 🌐 Deployment

### Build for Production
```bash
npm run build
```

### Deploy to Static Hosting
The `build` folder can be deployed to any static hosting service:
- Netlify
- Vercel
- GitHub Pages
- AWS S3
- Firebase Hosting

## 📱 Progressive Web App

The app includes PWA capabilities:
- Installable on mobile devices
- Offline functionality
- App-like experience

## ♿ Accessibility

- Full keyboard navigation
- Screen reader support
- High contrast mode
- Focus indicators
- Semantic HTML structure

## 🔊 Audio Features

- Automatic audio file detection
- Multiple format support
- Preloading for better performance
- Volume control
- Error handling for missing files

## 🌍 Internationalization

- Right-to-left (RTL) support for Arabic
- Dynamic language switching
- Fallback to default language
- Browser language detection

## 🚀 Performance

- Lazy loading of images and components
- Audio preloading
- Content caching
- Optimized bundle splitting
- Progressive enhancement

## 📊 Content Management

The app features a sophisticated content management system:

- **Auto-discovery**: Automatically finds new content in folders
- **Manifest generation**: Creates metadata for efficient loading
- **Hot reloading**: New content appears without code changes
- **Validation**: Checks for missing files and reports errors
- **Optimization**: Automatic image and audio optimization

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Add your changes
4. Run tests and content scanner
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

## 🆘 Support

For technical support or questions:
- Create an issue in the repository
- Check the documentation
- Contact the development team

---

Built with ❤️ for children's education