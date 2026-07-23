Business Idea / SRS
        ↓
Requirement Discovery & PRD
        ↓
Domain Modeling & Event Storming
        ↓
Architecture & ADRs
        ↓
Module Decomposition
        ↓
Contracts + Engineering Guardrails
        ↓
Golden Module
        ↓
Module Handover + Task Decomposition
        ↓
Parallel AI Development (Implement → Review → Test)
        ↓
Integration → Hardening → Deployment → Change Management



                Business Idea
                      │
                      ▼
         ┌─────────────────────────┐
         │ Requirement Agent        │
         └─────────────────────────┘
                      │
                      ▼
         ┌─────────────────────────┐
         │ PRD Generator           │
         └─────────────────────────┘
                      │
                      ▼
         ┌─────────────────────────┐
         │ Domain Modeling Agent   │
         └─────────────────────────┘
                      │
                      ▼
         ┌─────────────────────────┐
         │ Architecture Agent      │
         └─────────────────────────┘
                      │
                      ▼
         ┌─────────────────────────┐
         │ Guardrail Generator     │
         └─────────────────────────┘
                      │
                      ▼
         ┌─────────────────────────┐
         │ Golden Module Agent     │
         └─────────────────────────┘
                      │
                      ▼
         ┌─────────────────────────┐
         │ Contract Generator      │
         └─────────────────────────┘
                      │
                      ▼
         ┌─────────────────────────┐
         │ Handover Generator      │
         └─────────────────────────┘
                      │
                      ▼
         ┌─────────────────────────┐
         │ Task Planner            │
         └─────────────────────────┘
                      │
                      ▼
            Conductor / Multi-Agent
                      │
        ┌─────────────┼─────────────┐
        ▼             ▼             ▼
   Module A      Module B      Module C
        │             │             │
        └─────────────┼─────────────┘
                      ▼
               Review Agent
                      ▼
               Testing Agent
                      ▼
             Integration Agent
                      ▼
             Security Agent
                      ▼
             Deployment Agent