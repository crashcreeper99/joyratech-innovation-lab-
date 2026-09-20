# Joyratech Innovation Lab

Joyratech's development lab for turning original ideas into working prototypes through embedded systems, hardware, software, robotics, and disciplined experimentation.

> **Current stage:** early research and prototyping. The projects in this repository are works in progress, not finished products.

## Mission

Joyratech exists to bring joy by turning useful ideas into reality. This repository documents the engineering process: defining real problems, learning from potential users, testing assumptions, building prototypes, recording failures, and improving each design.

## Current focus

| Project area | Purpose | Current phase |
| --- | --- | --- |
| [Universal Connectivity Controller](projects/universal-connectivity-controller/README.md) | Explore a controller and audio system that can switch smoothly across many devices and connection standards | Problem validation |
| [Assistive Communication Interface](projects/assistive-communication-interface/README.md) | Explore low-effort ways for people with limited ability to type to communicate | User discovery |
| [Prototype Apps](projects/prototype-apps/README.md) | Build companion apps and interfaces for Joyratech hardware | Planning |
| [Robotics & Custom Builds](projects/robotics-custom-builds/README.md) | Combine electronics, firmware, mechanics, and controls into useful systems | Skill building |
| [PCB & Embedded Systems](projects/pcb-embedded-systems/README.md) | Progress from breadboards to reliable custom embedded hardware | Skill building |
| [Experiments](experiments/README.md) | Run focused tests that reduce risk in the larger projects | Active |

## How work moves forward

1. **Problem** — Identify a specific person and problem worth solving.
2. **Evidence** — Interview potential users and study existing solutions.
3. **Requirements** — Define what a first useful version must do.
4. **Experiment** — Test the riskiest assumption with the smallest build.
5. **Prototype** — Integrate only the features needed for a demonstration.
6. **Evaluate** — Record results, failures, safety concerns, and feedback.
7. **Iterate** — Improve the design or change direction based on evidence.

See the [roadmap](docs/ROADMAP.md) for the current sequence and the [project template](docs/PROJECT_TEMPLATE.md) for starting new work.

## Repository structure

```text
.
├── docs/           Roadmap, research guidance, and reusable templates
├── experiments/    Small tests that support larger projects
└── projects/       Major Joyratech concepts and prototypes
```

Each active project should eventually contain:

```text
project-name/
├── README.md
├── docs/
├── firmware/
├── hardware/
├── software/
├── tests/
└── media/
```

Folders are added when real work exists; empty folders are not used as decoration.

## Documentation standard

Every experiment or prototype update should answer:

- What problem or question was tested?
- What was built?
- What worked and what failed?
- What evidence was collected?
- What is the next smallest useful step?
- Are there safety, privacy, accessibility, or intellectual-property concerns?

Use [BUILD_LOG_TEMPLATE.md](docs/BUILD_LOG_TEMPLATE.md) to keep entries consistent.

## Intellectual property

Public files describe goals, learning, and non-confidential results. Potentially novel architectures, schematics, algorithms, manufacturing details, and unpublished inventions should remain private until an appropriate intellectual-property strategy has been considered. See [IP_GUIDELINES.md](docs/IP_GUIDELINES.md).

## About

Created by **Lamar Holloway**, an electrical and computer engineering student building toward becoming an architect of creation: someone who can bring together the people, knowledge, hardware, software, and design needed to turn ambitious ideas into reality.

---

This repository is an engineering portfolio and development record. It does not claim that listed concepts are complete, clinically validated, universally compatible, or commercially available.
