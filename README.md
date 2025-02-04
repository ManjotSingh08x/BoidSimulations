# Boids Simulation

## Introduction
This is a simulation of Boids (a type of flocking algorithm), demonstrating the emergent behaviors of a group of simple agents that move and interact with each other. The project simulates the movement of a flock of birds (or similar agents), where each agent follows basic rules to mimic real-life flocking behavior.
The simulation includes behaviors such as alignment, cohesion, and separation, which govern the way each Boid interacts with its neighbors, creating a more lifelike and dynamic movement pattern.
- **Alignment**: birds try to move in the direction of their flockmates
- **Cohesion**: birds try to move towards the centre of the flock
- **Seperation**: birds try to avoid being too close to other birds

Along with these fundamental rules, I have added 2 extra rules
- **Flow**: birds try to accelerate in the direction of flockmates, simulating faster motion
- **Mouse Follow**: when toggled, birds try to move towards the mouse
## Demo
Demo showing all features one by one

https://github.com/user-attachments/assets/00e04f9d-ada3-49da-a2d3-a0d698409671


## Usage
I have added a release file for windows binary that can be run to play the game. working on adding support for other architectures.

You can also clone this repo and add it as a project in godot and tweak the parameters.

## Acknowledgement
This project is based on the Boid simulation concept introduced by Craig Reynolds and inspired by Sebastian Lague's tutorial. You can find his tutorial on YouTube, which helped in building the foundational concepts of this simulation.

[Coding Adventure: Boids](https://youtu.be/bqtqltqcQhw?si=NwKUR8v4sMEllC95)
