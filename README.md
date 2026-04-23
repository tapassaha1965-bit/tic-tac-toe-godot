# Tic-Tac-Toe Web Game (Godot)

A browser-playable Tic-Tac-Toe game built using Godot Engine with multiple gameplay modes, AI difficulty levels, UI enhancements, animations, and sound integration. The project demonstrates structured game logic design, interactive UI implementation, and web deployment using GitHub Pages.

🔗 Live Demo:
https://tapassaha1965-bit.github.io/tic-tac-toe-godot/

---

## Features

- Player vs Player mode
- Player vs AI mode
- Easy, Medium, Hard AI difficulty levels
- Smart move selection logic (win / block / positional priority)
- Interactive main menu interface
- Difficulty selection system
- Animated winning highlights
- Score tracking system
- Sound effects for moves and wins
- Background music with toggle control
- Custom fonts and styled UI components
- Responsive layout for browser play
- Deployed using GitHub Pages

---

## Project Structure

tic-tac-toe-godot/
│
├── Main.tscn
├── Main.gd
├── project.godot
│
├── assets/
│   ├── images/
│   ├── sounds/
│   └── fonts/
│
├── docs/
│   ├── index.html
│   ├── *.js
│   ├── *.wasm
│   └── *.pck
│
└── README.md

---

## AI Difficulty Logic

The AI opponent uses layered decision rules:

Easy:
Random valid move selection

Medium:
Detects and blocks player winning moves

Hard:
Prioritizes winning moves → blocks opponent → prefers center → fallback strategic placement

---

## Technologies Used

- Godot Engine (GDScript)
- WebAssembly (HTML5 export)
- GitHub Pages deployment
- Theme Overrides for UI styling
- AudioStreamPlayer for sound integration

---

## How to Run Locally

1. Open the project in Godot Engine (standard version)
2. Run Main.tscn

---

## Deployment

Exported using Godot Web export and deployed through the docs/ directory via GitHub Pages.

---

## AI Usage Disclosure

The game logic, feature structure, UI flow design, and difficulty system were designed by me.

AI tools were used only to assist with accelerating portions of GDScript implementation, debugging workflow issues, and refining documentation formatting.

---

## Future Improvements

- Implement Minimax-based unbeatable AI mode
- Add multiplayer support over network
- Add theme switching (dark / light / neon modes)
- Improve animation transitions and sound layering
- Add persistent score saving using browser storage
- Add mobile-specific UI scaling improvements
