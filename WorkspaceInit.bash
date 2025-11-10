#!/bin/bash

# Stop if anything fails
set -e
# Create folder structure
mkdir -p src/ts src/js src/html src/css
# Create index.html
cat > src/html/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>TypeScript Starter</title>
  <link rel="stylesheet" href="../css/styles.css" />
  <script src="../js/script.js"></script>
</head>
<body>
  <h1>Hello, TypeScript!</h1>
</body>
</html>
EOF

# Create CSS file
cat > src/css/styles.css <<'EOF'
body {
  font-family: Arial, sans-serif;
  background-color: #111;
  color: #eee;
  text-align: center;
  margin-top: 10%;
}
EOF

# Create TypeScript entry
cat > src/ts/script.ts <<'EOF'
const heading = document.querySelector('h1');
if (heading) heading.textContent = "Hello from TypeScript!";
console.log("TypeScript is working.");
EOF

# Initialize Node project
npm init -y >/dev/null

# Add TypeScript dependency
npm install --save-dev typescript >/dev/null

# Create tsconfig.json
cat > tsconfig.json <<'EOF'
{
  "compilerOptions": {
    "target": "es6",
    "outDir": "./src/js",
    "rootDir": "./src/ts",
    "strict": true
  },
  "include": ["src/**/*", "ts/script.ts", "js/"]
}
EOF

# Add NPM scripts
echo "Adding build script!"
npx npm-add-script -k "build" -v "tsc" -y >/dev/null
echo "Adding watch script!"
npx npm-add-script -k "watch" -v "tsc --watch" >/dev/null
echo "Adding start script!"
npx npm-add-script -k "start" -v "npx serve" >/dev/null || true

# Initial compile
npx tsc

echo "Workspace ready!"
echo "Run:"
echo "  npm run watch   # auto-compile TypeScript"
echo "  npm start       # serve locally"
