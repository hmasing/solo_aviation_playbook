# FBO Operations Playbook Rules

## Document Structure Standards

### File Organization
- Use kebab-case naming: `aircraft-arrival-handling.md`
- Include section prefix: `01-aircraft-arrival-handling.md`
- Organize by operational category (01-06 sections)
- Store supporting materials in `assets/` directory

### Content Categories
1. **FBO Services** (01) - Customer-facing operations
2. **Maintenance Operations** (02) - Aircraft maintenance and repair
3. **Flight School Operations** (03) - Training and education services
4. **Safety and Compliance** (04) - Regulatory and safety procedures
5. **Marketing and Customer Retention** (05) - Business development
6. **Administrative and Financial** (06) - Business operations

## Procedure Generation Prompt

When creating new FBO procedures, use this prompt structure to generate comprehensive, standardized procedures:

### Input Requirements:
- **Procedure Name**: [Specific procedure title]
- **Section**: [One of: FBO Services, Maintenance Operations, Flight School Operations, Safety and Compliance, Marketing and Customer Retention, Administrative and Financial]
- **Brief Description**: [1-2 sentence overview of what this procedure accomplishes]

### Generation Instructions:
Create a complete procedure document following this exact structure:

1. **YAML Frontmatter**: Include title, section, procedure number, dates, author, reviewer, approver
2. **Process Name**: Clear, descriptive title with "Process" suffix
3. **Purpose**: 2-3 sentences explaining why this process exists and intended outcome
4. **Roles and Responsibilities**: 3-4 relevant aviation roles with specific responsibilities (2 lines each)
5. **Process Steps**: Up to 15 numbered steps with detailed actions, inputs, outputs, and tools
6. **Process Mapping**: Placeholder for flowchart description
7. **Tools and Resources**: Specific equipment, software, forms, or references needed
8. **Success Metrics**: 4 measurable indicators (Completion Time, Quality Standard, Safety Standard, Customer Satisfaction)
9. **Common Issues and Solutions**: 2-3 realistic problems with specific solutions
10. **Safety Considerations**: Aviation-appropriate WARNING, CAUTION, and NOTE items
11. **Regulatory References**: Relevant FAA, OSHA, and industry standards
12. **Notes Section**: Extensive blank space with line breaks
13. **Revision History**: Standard table format
14. **Footer**: Review date, procedure owner, emergency contact

### Document Structure Template

```markdown
---
title: "Process Name"
section: "Main Category"
procedure_number: "XX"
revision_date: "YYYY-MM-DD"
version: "1.0"
author: "FBO Operations Team"
reviewed_by: "[Reviewer Name]"
approved_by: "[Approver Name]"
effective_date: "YYYY-MM-DD"
---

# Process Name

Provide a clear, descriptive name for the process.

_____________________________________________________________________________________________

## Purpose

Explain why this process exists and its intended outcome.

_____________________________________________________________________________________________

## Roles and Responsibilities

List the roles involved and their specific responsibilities.

**Role 1 (e.g., Line Service Technician):**
________________________________________________________________
________________________________________________________________

**Role 2 (e.g., Operations Supervisor):**
________________________________________________________________
________________________________________________________________

## Process Steps

Detail each step in a clear, numbered sequence.

**Step 1:**
______________________________________________________________________________________

**Step 2:**
______________________________________________________________________________________

[Continue through Step 15]

## Process Mapping

Flowchart to show sequential steps

## Tools and Resources

List all tools, software, or templates required.

_____________________________________________________________________________________________

## Success Metrics

Define measurable indicators to evaluate process effectiveness.

**Completion Time:** Process completed within [X hours/days].
**Quality Standard:** [Specific quality measure]
**Safety Standard:** [Safety requirement met]
**Customer Satisfaction:** [Target satisfaction level]

## Common Issues and Solutions

Identify potential challenges and their resolutions.

**Issue:** [Problem description]
**Solution:** [Resolution steps]

## Safety Considerations
⚠️ **WARNING**: Critical safety information
⚡ **CAUTION**: Operational cautions
ℹ️ **NOTE**: Important operational information

## Regulatory References
- [FAA Regulation/Advisory Circular]
- [OSHA Standard]
- [Company Policy Reference]

## Notes:
___________________________________________________________________________________
[Multiple lines of blank space for notes]

## Revision History
| Date | Version | Changes | Author | Reviewer |
|------|---------|---------|--------|----------|
| YYYY-MM-DD | 1.0 | Initial creation | [Name] | [Name] |
```

## Aviation Industry Requirements

### Terminology Standards
- Use proper aviation terminology and acronyms
- Define acronyms on first use: `Federal Aviation Administration (FAA)`
- Use standard aircraft designations: `Cessna 172`, `King Air 350`
- Include ICAO aircraft type codes when appropriate: `C172`, `BE20`

### Safety Language Hierarchy
- **⚠️ WARNING**: Immediate danger to life or limb
- **⚡ CAUTION**: Risk of equipment damage or operational problems  
- **ℹ️ NOTE**: Important operational information
- **✅ BEST PRACTICE**: Recommended approaches for optimal results

### Regulatory References
Always reference current regulations:
- **14 CFR** (Code of Federal Regulations) - Use specific part numbers
- **FAA Advisory Circulars (AC)** - Include AC number and title
- **OSHA Standards** - Reference specific standard numbers
- **EPA Regulations** - Include relevant environmental standards

### Fuel Specifications
- **Jet A**: Turbine engine fuel (specify Jet A-1 for international)
- **100LL**: 100 Low Lead aviation gasoline
- **Mogas**: Motor gasoline (automotive fuel approved for aircraft use)

### Radio Communications
Use standard phraseology:
```
"Podunk Ground, Cessna 123AB, ready to taxi with Information Alpha"
"Cessna 123AB, Podunk Ground, taxi to Runway 27 via Alpha, contact Tower 118.1"
```

## Content Quality Standards

### Writing Requirements
- Steps must be actionable and specific
- Include realistic success metrics with target values
- Address common operational challenges
- Maintain professional aviation industry tone
- Ensure regulatory compliance considerations
- Include cross-references to related procedures
- Use consistent formatting with horizontal line separators
- Provide comprehensive but practical guidance

### Aviation-Specific Considerations
- Include relevant safety warnings for airport operations
- Reference appropriate FAA regulations (14 CFR parts)
- Consider OSHA workplace safety standards
- Include emergency contact protocols where relevant
- Address quality control and compliance requirements
- Use realistic timeframes for aviation operations
- Consider weather, equipment, and regulatory dependencies

### Review Requirements
All procedures must be reviewed by qualified personnel:
- **FBO Services**: Operations Manager, Customer Service Lead
- **Maintenance**: Chief of Maintenance, Quality Assurance Manager
- **Flight Training**: Chief Flight Instructor, Training Manager
- **Safety**: Safety Officer, Compliance Manager
- **Marketing**: Marketing Manager, Customer Relations Manager
- **Administrative**: Business Manager, Finance Manager

### Regulatory Expertise Required
Procedures involving these areas need appropriate regulatory review:
- **Aircraft maintenance**: A&P mechanic or IA review
- **Flight operations**: Commercial pilot or CFI review
- **Fuel operations**: Fuel safety specialist review
- **Security**: TSA compliance officer review
- **Environmental**: Environmental compliance officer review

## Maintenance Standards
- **Annual review**: All procedures reviewed yearly minimum
- **Event-driven updates**: Changes due to regulation updates, equipment changes, or incident lessons learned
- **Version control**: Track all changes with date, author, and reason
- **Distribution control**: Ensure all users have current versions

---
**Document Owner**: Operations Management  
**Review Frequency**: Annual or as regulations change  
**Distribution**: All department heads and content creators
