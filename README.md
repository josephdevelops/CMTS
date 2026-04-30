# CMTS Godot Project

## What it includes

- Main menu
- Scenario selection screen
- Classroom scenario prompt
- Teacher response choices
- Feedback/results screen
- JSON scenario data
- Scripts matching the planned architecture:
  - `ScenarioManager.gd`
  - `StudentBehavior.gd`
  - `ResponseOption.gd`
  - `FeedbackSystem.gd`

## How to open it in Godot

1. Unzip the project folder.
2. Open Godot 4.6.x.
3. Click **Import**.
4. Select the `project.godot` file inside this folder.
5. Open the project and press **Play**.

## Where to add more scenarios

Edit:

`data/scenarios.json`

Add more scenario objects using the same format as the existing examples.

## Capstone alignment

This prototype supports the capstone architecture:

`UI → Simulation Engine → Scenario Data → Results/Feedback`

It can be used as a small playable slice while the Milestone 2 documentation focuses on requirements, technical specifications, logical design, and UI design.
