# FBO Operations Playbook - Role Management System

This directory contains the role management system for the FBO Operations Playbook, which allows you to centralize role definitions and regenerate procedures with curated roles that match your actual team structure.

## Files Overview

### Configuration Files

- **`roles.yml`** - Complete extracted roles from all procedures (auto-generated)
- **`curated_roles.yml`** - Editable configuration defining which roles to use
- **`role_usage_analysis.yml`** - Analysis of role frequency and distribution
- **`detailed_role_usage.yml`** - Detailed breakdown of roles by procedure

### Reports (Generated)

- **`preview_report.yml`** - Preview of changes before regeneration
- **`regeneration_report.yml`** - Summary after regeneration is complete

## How to Use This System

### Phase 1: Role Extraction (Completed)

The system has already extracted all 84 unique roles from your procedures and analyzed their usage patterns.

**Key findings:**

- **Most used role:** Operations Leader (47 procedures)
- **84 total unique roles** across all procedures
- **145 role reduction** possible with curation

### Phase 2: Role Curation and Regeneration

#### Step 1: Edit Curated Roles

Edit `config/curated_roles.yml` to define your actual team structure:

```yaml
roles:
  "Operations Leader":
    active: true          # Keep this role
    maps_to: null        # Use as-is
    responsibilities:    # Customize responsibilities
      - Oversee daily operations
      - Coordinate between departments
      
  "Maintenance Scheduler":
    active: false        # Remove this role
    maps_to: "Client Service Representative"  # Map to this role instead
    note: "Scheduling handled by Client Service Representative"
```

**Configuration Options:**

- `active: true/false` - Whether to include this role in procedures
- `maps_to: "Role Name"` - Redirect responsibilities to another role
- `responsibilities: [...]` - Customize the role's responsibilities
- `note: "..."` - Document why changes were made

#### Step 2: Preview Changes

Before making changes, preview what will happen:

```bash
ruby regenerate_procedures.rb preview
```

This shows:

- Which procedures will be updated
- How many roles will be removed/changed
- Which roles will be mapped to others
- Total impact across all procedures

#### Step 3: Apply Changes

When you're ready to update all procedures:

```bash
ruby regenerate_procedures.rb regenerate
```

This will:

- Create a backup of your current content in `content_backup/`
- Update all procedure files with curated roles
- Generate a regeneration report

### Current Curation Status

The system is pre-configured with a recommended curation that reduces roles from 84 to 12 core roles:

**Active Roles (12) - Organized by Level:**

**Level 1 - Direct Service Providers (1 role):**

- Line Service Technician

**Level 2 - Technical Specialists (3 roles):**

- A&P Mechanic
- Avionics Technician  
- Flight Instructor

**Level 3 - Coordinators (4 roles):**

- Client Service Representative
- Safety Officer
- Finance Leader
- Marketing Leader

**Level 4 - Leaders (4 roles):**

- Operations Leader
- Business Leader
- Chief of Maintenance
- Chief Flight Instructor

**Mapped Roles:** Many specialized roles are mapped to these core roles
**Inactive Roles:** Generic roles like "Team Members (All)" are removed

## Role Level System

The system uses a 4-level taxonomy that organizes roles from hands-on execution to strategic leadership:

**Level 1 - Direct Service Providers**

- Hands-on execution and direct client/aircraft interaction
- Front-line service delivery and operational tasks
- Example: Line Service Technician

**Level 2 - Technical Specialists**

- Specialized skills and technical execution
- Quality assurance and technical problem-solving
- Examples: A&P Mechanic, Avionics Technician, Flight Instructor

**Level 3 - Coordinators**

- Cross-functional coordination and process oversight  
- Client relationships and resource management
- Examples: Client Service Representative, Safety Officer

**Level 4 - Leaders**

- Strategic oversight and resource allocation
- Regulatory compliance and final authority
- Examples: Operations Leader, Chief of Maintenance

### Role Ordering in Procedures

Roles appear in procedures ordered from Level 1 to Level 4, creating a natural flow from "doers" to "leaders" without traditional hierarchical language.

## Benefits

### Consistency

- Standardized role names across all procedures
- Consistent responsibilities for each role
- Eliminates duplicate or overlapping roles

### Team Alignment

- Roles match your actual organizational structure
- Clear accountability and responsibility assignment
- Natural progression from execution to oversight
- Easier training and onboarding

### Maintenance

- Single source of truth for role definitions
- Easy to update roles across all procedures
- Level-based organization for logical flow
- Automatic backup and change tracking

## Safety Notes

⚠️ **Always preview before regenerating** - Use the preview function to understand impact

💾 **Backups are automatic** - Original content is backed up to `content_backup/`

🔄 **Changes are reversible** - You can restore from backup if needed

📋 **Track changes** - All modifications are documented in reports

## Workflow Examples

### Adding a New Role

1. Add the role to `curated_roles.yml` with `active: true`
2. Preview changes to see impact
3. Regenerate procedures

### Consolidating Roles

1. Set the role to be removed as `active: false`
2. Set `maps_to:` to point to the target role
3. Preview and regenerate

### Updating Responsibilities

1. Edit the `responsibilities:` list in `curated_roles.yml`
2. Preview to see which procedures will be affected
3. Regenerate to apply changes

## File Regeneration Logic

The regeneration process:

1. **Reads original procedures** - Extracts existing roles and responsibilities
2. **Applies curation rules** - Filters based on `curated_roles.yml` configuration  
3. **Maps roles** - Redirects inactive roles to their mapped alternatives
4. **Preserves context** - Maintains procedure-specific role assignments
5. **Updates formatting** - Ensures consistent role section formatting
6. **Creates backups** - Preserves original content for safety

## Troubleshooting

**Problem:** Preview shows unexpected role counts
**Solution:** Check that role names in `curated_roles.yml` match exactly (case-sensitive)

**Problem:** Regeneration removes too many roles
**Solution:** Review the `maps_to` settings and ensure target roles are `active: true`

**Problem:** Need to revert changes
**Solution:** Copy files from `content_backup/` back to `content/`

---

**Last Updated:** 2025-08-22  
**System Version:** 1.0  
**Total Procedures:** 105  
**Role Reduction Capability:** 145 roles → 12 core roles
