# Content Guidelines for FBO Operations Playbook

## Aviation Industry Standards

### Terminology and Acronyms
**Always use standard aviation terminology consistently:**

#### Aircraft Types
- Use proper manufacturer designations: `Cessna 172`, `Piper Cherokee`, `King Air 350`
- Include model variants when relevant: `Cessna 172S`, `Beechcraft Bonanza A36`
- Use ICAO aircraft type codes when appropriate: `C172`, `PA28`, `BE20`

#### Aviation Acronyms (Define on first use)
- **FAA**: Federal Aviation Administration
- **ICAO**: International Civil Aviation Organization
- **FBO**: Fixed Base Operator
- **ARFF**: Aircraft Rescue and Fire Fighting
- **TSA**: Transportation Security Administration
- **NOTAM**: Notice to Airmen
- **METAR**: Meteorological Aerodrome Report
- **TAF**: Terminal Aerodrome Forecast
- **IFR**: Instrument Flight Rules
- **VFR**: Visual Flight Rules

#### Fuel Specifications
- **Jet A**: Turbine engine fuel (specify Jet A-1 for international)
- **100LL**: 100 Low Lead aviation gasoline
- **Mogas**: Motor gasoline (automotive fuel approved for aircraft use)

#### Radio Communications
Use standard phraseology:
```
"Podunk Ground, Cessna 123AB, ready to taxi with Information Alpha"
"Cessna 123AB, Podunk Ground, taxi to Runway 27 via Alpha, contact Tower 118.1"
```

### Regulatory References
**Always reference current regulations:**
- **14 CFR** (Code of Federal Regulations) - Use specific part numbers
- **FAA Advisory Circulars (AC)** - Include AC number and title
- **OSHA Standards** - Reference specific standard numbers
- **EPA Regulations** - Include relevant environmental standards

### Safety Language Standards

#### Warning Levels
Use consistent hierarchy:

**⚠️ WARNING**: Immediate danger to life or limb
- Use for: Fire hazards, toxic exposure, electrical dangers, aircraft prop/engine hazards
- Example: "⚠️ **WARNING**: Never approach a running aircraft engine from the front or sides"

**⚡ CAUTION**: Risk of equipment damage or operational problems  
- Use for: Equipment misuse, procedural errors, minor safety concerns
- Example: "⚡ **CAUTION**: Ensure fuel nozzle is properly grounded before connecting"

**ℹ️ NOTE**: Important operational information
- Use for: Best practices, reminders, clarifications
- Example: "ℹ️ **NOTE**: Always verify fuel type before beginning fuel operations"

**✅ BEST PRACTICE**: Recommended approaches for optimal results
- Use for: Industry standards, efficiency tips, quality improvements
- Example: "✅ **BEST PRACTICE**: Complete marshalling signals training annually"

## Writing Style Guidelines

### Tone and Voice
- **Professional but approachable**: Clear, direct communication
- **Action-oriented**: Use active voice and imperative mood
- **Precise**: Avoid ambiguous language; be specific about requirements
- **Consistent**: Use the same terms for the same concepts throughout

### Procedure Writing
1. **Start with the end goal**: What should be accomplished?
2. **List prerequisites clearly**: What's needed before starting?
3. **Use numbered steps for sequence**: When order matters
4. **Use bullets for options**: When order doesn't matter
5. **Include verification steps**: How to confirm completion
6. **Address common problems**: What to do when things go wrong

### Formatting Standards

#### Headers and Structure
```markdown
# Main Title (H1) - Procedure name
## Overview (H2) - Purpose and scope  
### Major Steps (H3) - Main procedure phases
#### Detailed Actions (H4) - Specific tasks
##### Sub-actions (H5) - Detailed steps
###### References (H6) - Additional details
```

#### Lists and Checklists
- **Sequential procedures**: Use numbered lists (1, 2, 3...)
- **Non-sequential items**: Use bullet points (-)
- **Verification items**: Use checkboxes (- [ ])
- **Sub-items**: Indent consistently (use 2 or 4 spaces)

#### Tables for Reference Data
```markdown
| Aircraft Type | Fuel Type | Capacity | Notes |
|---------------|-----------|----------|-------|
| Cessna 172 | 100LL | 56 gal | Standard trainer |
| King Air 350 | Jet A | 539 gal | Turboprop |
```

#### Code Blocks for Examples
Use for radio calls, forms, or structured data:
```
FUEL ORDER EXAMPLE:
Aircraft: N123AB (Cessna 172)
Fuel Type: 100LL  
Quantity: Full tanks (56 gallons)
Special Instructions: Check for water contamination
```

## Quality Standards

### Accuracy Requirements
- **Technical specifications**: Verify with manufacturer data
- **Regulatory information**: Confirm with current CFR/FAA sources
- **Contact information**: Verify all phone numbers and extensions
- **Cross-references**: Ensure all links work and point to correct content

### Review Process
1. **Technical review**: Subject matter expert verification
2. **Safety review**: Safety officer approval for safety-related content
3. **Regulatory review**: Compliance officer verification
4. **Editorial review**: Grammar, style, and consistency check
5. **Management approval**: Final authorization for publication

### Maintenance Standards
- **Annual review**: All procedures reviewed yearly minimum
- **Event-driven updates**: Changes due to regulation updates, equipment changes, or incident lessons learned
- **Version control**: Track all changes with date, author, and reason
- **Distribution control**: Ensure all users have current versions

## Content Organization

### File Naming
- Use kebab-case: `aircraft-arrival-handling.md`
- Include section prefix: `01-aircraft-arrival-handling.md`
- Keep names descriptive but concise
- Avoid special characters and spaces

### Cross-Referencing
- **Internal links**: `[Procedure Name](../section/procedure-name.md)`
- **External links**: `[FAA Regulation](https://www.faa.gov/...)`
- **Form references**: `[Form Name](../../assets/forms/form-name.pdf)`
- **Image references**: `![Description](../../assets/images/image-name.jpg)`

### Metadata Requirements
All procedures must include frontmatter with:
```yaml
```

## Subject Matter Expertise

### Required Reviewers by Category
- **FBO Services**: Operations Manager, Customer Service Lead
- **Maintenance**: Chief of Maintenance, Quality Assurance Manager
- **Flight Training**: Chief Flight Instructor, Training Manager
- **Safety**: Safety Officer, Compliance Manager
- **Marketing**: Marketing Manager, Customer Relations Manager
- **Administrative**: Business Manager, Finance Manager

### Regulatory Expertise
Ensure procedures involving these areas have appropriate regulatory review:
- **Aircraft maintenance**: A&P mechanic or IA review
- **Flight operations**: Commercial pilot or CFI review
- **Fuel operations**: Fuel safety specialist review
- **Security**: TSA compliance officer review
- **Environmental**: Environmental compliance officer review

---
**Document Owner**: Operations Management  
**Review Frequency**: Annual or as regulations change  
**Distribution**: All department heads and content creators