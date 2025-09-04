# Solo Aviation Services Playbook

## Overview

This playbook provides standardized procedures for Solo Aviation Services Fixed Base Operator (FBO) operations at our small Midwest airport. We operate a 3,500-foot runway serving Part 91 general aviation operations, including our Part 61 flight school with aircraft ranging from single-engine trainers (Cessna 172, Piper Cherokee) to turboprop business aircraft (King Air, Pilatus, TBM series). The playbook follows organizational vocabulary standards emphasizing clients, team members, and operational excellence.

## 🚀 Quick Start

### Generate PDF Documentation

#### Main Playbook PDF
```bash
./build_playbook.sh
```

This creates: `solo-aviation-services-playbook.pdf` (287KB document)

**To open the PDF:**
```bash
open solo-aviation-services-playbook.pdf
```

#### Individual Section PDFs
```bash
./build_section_pdfs.sh
```

This creates individual PDF files for each procedure in: `./section-pdfs/`

**To view all generated PDFs:**
```bash
open ./section-pdfs/
```

**Benefits of Individual PDFs:**
- **Training Materials**: Distribute specific procedures to team members
- **Reference Documents**: Quick access to individual procedures  
- **Client Handouts**: Share specific procedures with clients
- **Compliance Documentation**: Provide specific procedures to auditors
- **Optimized Format**: No cover page or table of contents - just the procedure content
- **Page Numbers & Footers**: Professional page numbering and Solo Aviation branding
- **No Blank Pages**: Content starts immediately without useless first pages

See [SECTION-PDF-GENERATION.md](SECTION-PDF-GENERATION.md) for detailed documentation.

## Playbook Structure

### 📋 Main Categories

1. **[FBO Services](content/01-fbo-services/)** - Core client-facing operations and experience delivery
2. **[Maintenance Operations](content/02-maintenance-operations/)** - Aircraft maintenance and repair procedures  
3. **[Flight School Operations](content/03-flight-school-operations/)** - Training and education services
4. **[Safety and Compliance](content/04-safety-compliance/)** - Regulatory and safety procedures
5. **[Marketing and Client Retention](content/05-marketing-client-retention/)** - Business development and client engagement
6. **[Administrative and Financial](content/06-administrative-financial/)** - Business operations and financial management

### 📁 Directory Structure

```text
playbook/
├── content/                             # Main playbook procedures
│   ├── 01-fbo-services/                 # Client experience and service delivery
│   ├── 02-maintenance-operations/       # Aircraft maintenance and repair
│   ├── 03-flight-school-operations/     # Training and education services
│   ├── 04-safety-compliance/            # Safety and regulatory procedures
│   ├── 05-marketing-client-retention/   # Client engagement and retention
│   └── 06-administrative-financial/     # Business operations and finance
├── templates/                           # Procedure templates
├── assets/                              # Supporting materials
│   ├── forms/                           # Operational forms
│   ├── images/                          # Diagrams and photos
│   └── references/                      # Quick reference materials
├── kitabu/                              # PDF generation system
│   ├── config/                          # Book configuration
│   ├── text/                            # Processed content for PDF
│   └── output/                          # Generated PDF and HTML files
└── .cursor/rules/                       # Documentation and vocabulary standards
```

## Quick Navigation

### 🛩️ FBO Services

1. Aircraft Arrival and Departure Handling
2. Fueling Operations (Jet-A and Avgas)
3. Hangar and Ramp Space Allocation
4. Client Check-In and Concierge Services
5. Aircraft Marshalling and Parking
6. Ground Support Equipment (GSE) Management
7. Maintenance Coordination for Visiting Aircraft
8. Crew and Passenger Transportation
9. Billing and Invoicing for Services
10. Safety and Security Inspections
11. Facility Maintenance and Cleaning
12. Weather Briefing and Flight Planning Support
13. Catering and In-Flight Service Requests
14. Emergency Response and Incident Reporting

### 🔧 Maintenance Operations

1. Work Order Creation and Scheduling
2. Pre-Maintenance Aircraft Inspection
3. 100-Hour and Annual Inspection Execution
4. Scheduled Maintenance (Airframe, Engine, Avionics)
5. Unscheduled Repair and Troubleshooting
6. Parts Inventory Management and Ordering
7. Maintenance Logbook Updates and Documentation
8. FAA Regulatory Compliance and Reporting
9. Quality Control and Post-Maintenance Checks
10. Tool and Equipment Calibration and Maintenance
11. Technician Training and Certification Tracking
12. Client Communication and Work Approval
13. Hazardous Materials Handling and Disposal
14. Shop Safety and Cleanliness Protocols
15. Billing and Invoicing for Maintenance Services

### 🎓 Flight School Operations

1. Student Enrollment and Onboarding
2. Flight Lesson Scheduling
3. Aircraft Maintenance and Inspection
4. Student Progress Tracking and Certification
5. Safety Incident Reporting
6. Ground School Curriculum Delivery
7. Instructor Scheduling and Certification Renewal
8. Flight Simulator Session Management
9. TSA Security Clearance for International Students
10. Billing and Payment Processing
11. Pre-Flight Briefing and Checklist Execution
12. Post-Flight Debriefing and Logbook Updates
13. Emergency Response and Evacuation Procedures
14. Fuel Management and Refueling Operations
15. Client Feedback and Satisfaction Surveys

### 🛡️ Safety and Compliance

1. Safety Incident Reporting and Investigation
2. Aircraft Fueling Safety Procedures
3. Ground Handling Safety Protocols
4. FAA and OSHA Compliance Audits
5. Emergency Response Plan Execution
6. Fire Safety and Hazardous Materials Handling
7. Ramp and Hangar Safety Inspections
8. Employee Safety Training and Certification
9. Security Screening for Personnel and Visitors
10. TSA Compliance for International Flight Operations
11. Environmental Compliance (Spill Prevention and Response)
12. Equipment Maintenance and Safety Checks
13. Runway Incursion Prevention Training
14. Safety Management System (SMS) Implementation
15. Regulatory Documentation and Record-Keeping

### 📈 Marketing and Client Retention

1. Client Segmentation and Targeting
2. Digital Marketing Campaign Management
3. Promotional Offer Development
4. Event Hosting and Sponsorship
5. Client Feedback Collection and Analysis
6. Loyalty Program Management
7. Personalized Client Follow-Up
8. Referral Program Administration
9. Content Creation
10. Partnership Development with Local Businesses
11. Client Complaint Resolution
12. Social Media Engagement and Reputation Management
13. Pilot Community Outreach
14. Seasonal Marketing Campaigns
15. Client Retention Analytics and Reporting

### 💼 Administrative and Financial

1. Client Billing and Invoicing
2. Payment Processing and Collections
3. Budget Planning and Monitoring
4. Expense Tracking and Approval
5. Payroll Administration for Team Members
6. Vendor and Supplier Contract Management
7. Financial Reporting and Reconciliation
8. Tax Filing and Compliance
9. Insurance Policy Management
10. Team Member Scheduling and Timekeeping
11. Record-Keeping for Regulatory Compliance
12. Inventory Management for Fuel and Supplies
13. Client Account Management in CRM
14. Purchase Order Processing
15. Audit Preparation and Support

## Organizational Standards

### Vocabulary and Language

This playbook follows Solo Aviation Services vocabulary standards:

- **Clients** (not customers) - Individuals or organizations we serve
- **Team Members** (not employees/staff) - Our valued workforce
- **Leaders** (not managers/supervisors) - Those who guide and develop team members
- **Experience** (not just service) - What we create for clients
- **Opportunities** (not problems) - Challenges that present improvement potential
- **Excellence** - Our standard approach to all operations

### Documentation Standards

- Procedures follow standardized templates with consistent formatting
- Safety warnings use clear hierarchy: ⚠️ WARNING, ⚡ CAUTION, ℹ️ NOTE, ✅ BEST PRACTICE
- Aviation terminology follows industry standards with acronyms defined on first use
- Regulatory references include current FAA, OSHA, and industry standards

### Content Management

- **Source Content**: Located in `content/` directory with section-based organization
- **PDF Generation**: Automated using Kitabu system in `kitabu/` directory
- **Templates**: Standardized procedure templates in `templates/` directory
- **Quality Control**: Procedures reviewed by qualified personnel before publication

## Usage Guidelines

### For Operations Team Members

- Each procedure includes step-by-step instructions
- Safety warnings and cautions are clearly marked
- Cross-references link to related procedures
- Forms and checklists are readily accessible

### For Leaders

- Procedures include quality control checkpoints
- Compliance requirements are clearly identified
- Performance metrics and KPIs are integrated
- Training requirements are specified

### For Training

- New team member onboarding procedures
- Certification tracking and renewal requirements
- Safety training protocols
- Performance evaluation criteria

## Document Management

### PDF Generation Workflow

The playbook uses an automated PDF generation system with two output options:

#### Main Playbook PDF
1. **Content Creation**: Write procedures in Markdown format in `content/` directories
2. **Template Compliance**: Follow standardized procedure templates in `templates/`
3. **Vocabulary Standards**: Apply Solo Aviation vocabulary from `.cursor/rules/vocabulary-standards.mdc`
4. **PDF Generation**: Run `./build_playbook.sh` or `ruby build_playbook.rb` to generate PDF
5. **Output**: PDF created as `solo-aviation-services-playbook.pdf` in root directory

#### Individual Section PDFs
1. **Content Discovery**: System scans `content/` directories for chapters and procedures
2. **Individual Processing**: Each procedure generates its own PDF file
3. **Custom Templates**: Uses specialized templates that exclude cover and table of contents
4. **PDF Generation**: Run `./build_section_pdfs.sh` or `ruby build_section_pdfs.rb`
5. **Output**: Individual PDFs created in `./section-pdfs/` directory with page numbering starting from 1
6. **Reporting**: Generation report created at `./section-pdfs/generation_report.md`

### Build Process Details

- **Content Organization**: `kitabu/organize_content.rb` processes source files
- **Format Conversion**: Kitabu system converts Markdown to PDF with professional styling
- **Asset Management**: Images and forms automatically included from `assets/` directory
- **Version Control**: Generated PDF reflects latest content changes automatically

### File Management Best Practices

- Keep source content in `content/` directories organized by section
- Use consistent naming: `##-descriptive-procedure-name.md`
- Follow YAML frontmatter standards for metadata
- Reference assets using relative paths: `../../assets/category/file-name`
- Maintain cross-references between related procedures

### Keyword Index Generation

The playbook includes an automated keyword index that provides comprehensive cross-references to aviation and operational terms throughout the document:

- **Automatic Generation**: Index is generated automatically during PDF build process
- **Comprehensive Coverage**: Includes 2,650+ aviation terms, operational concepts, and regulatory references
- **Page References**: PDF version includes automatic page number references for each term
- **Regulatory Cross-Reference**: Special sections for FAA regulations, OSHA standards, and other regulatory sources
- **Aviation Acronyms**: Dedicated section explaining common aviation abbreviations

#### Manual Index Generation

To regenerate just the keyword index:

```bash
ruby generate_index.rb
```

#### Index Features

- **Aviation Terms**: Aircraft types, navigation, weather, fuel specifications
- **Operational Terms**: FBO services, maintenance procedures, safety protocols
- **Regulatory References**: 14 CFR parts, FAA publications, OSHA standards
- **Alphabetical Organization**: Terms grouped by first letter for easy navigation
- **Chapter References**: Shows which chapters contain each term with occurrence counts

### Quality Assurance

- Procedures must be reviewed by qualified subject matter experts
- Safety-related content requires safety officer approval
- Regulatory content needs compliance officer verification
- Final approval required from department leaders before publication
