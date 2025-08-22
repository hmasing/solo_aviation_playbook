# Project Configuration

This directory contains project-wide configuration files for the Solo Aviation Services Playbook.

## Configuration Files

### Chapter Order Configuration (`chapter_order.yml`)

Controls the order and inclusion of chapters in the generated playbook. This configuration is used by the `kitabu/organize_content.rb` script.

#### Structure

```yaml
chapters:
  - directory: "content-directory-name"
    title: "Custom Chapter Title"
    enabled: true/false
    description: "Optional description"
```

#### Usage Examples

**Reorder chapters**: Move entries up or down in the list

```yaml
chapters:
  # Safety first!
  - directory: "safety-compliance"
    title: "Safety and Compliance"
    enabled: true
    
  # Then core services
  - directory: "fbo-services"
    title: "FBO Services"
    enabled: true
```

**Disable a chapter temporarily**:

```yaml
  - directory: "marketing-client-retention"
    title: "Marketing and Client Retention"
    enabled: false  # Will be excluded from playbook
```

**Custom chapter title**:

```yaml
  - directory: "maintenance-operations"
    title: "Aircraft Maintenance & Repair"  # Custom title
    enabled: true
```

#### Rebuilding After Changes

```bash
cd kitabu
ruby organize_content.rb
bundle exec kitabu export pdf
```

### Other Configuration Files

- `roles.yml` - Role definitions and hierarchies
- `curated_roles.yml` - Curated role assignments
- `detailed_role_usage.yml` - Detailed role usage analysis
- `role_usage_analysis.yml` - Role usage statistics

## File Organization

Configuration files in this directory affect the entire project, while `kitabu/config/` contains only Kitabu-specific settings like styling and book metadata.
