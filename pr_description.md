# Summary of Changes

This PR includes several major feature additions, improvements, and bug fixes across the API sessions, buyflow management, and UI components:

1. API Sessions and Logs Enhancement
   - Added multi-client selection support for logs and sessions
   - Implemented CSV export functionality with file management
   - Enhanced filter bar with searchable client dropdown
   - Added ability to delete export files
   - Improved date handling and logging in exports
   - Added exports list view with download and delete actions
   - Enhanced CSV export to support multiple clients
   - Added token-level filtering for API logs
   - Implemented multi-token filtering for logs and sessions
   - Added include_in_logs toggle for API tokens
   - Enhanced client search to include token names
   - Improved token selection with accordion and enhanced search

2. Buyflow Management Improvements
   - Added server-side URL preview generation
   - Implemented provider name search with debounced filtering
   - Enhanced parameter type determination and visual distinction
   - Improved UTM parameter handling and URL construction
   - Added parameter deletion with confirmation dialog
   - Simplified UTM parameter handling
   - Improved buyflow URL construction
   - Enhanced parameter priority in URL building
   - Improved error handling and removed console.log statements

3. UI/UX Enhancements
   - Upgraded to native Flowbite date range picker
   - Refined filter bar and date picker alignment
   - Replaced SVGs with Humicons
   - Improved component spacing and visual hierarchy
   - Enhanced client filter with searchable dropdown
   - Improved filter bar and date picker UI
   - Added internal padding to client cards
   - Enhanced search interface in filter bar dropdown
   - Improved visual grouping and spacing
   - Added border to search input

4. Dependency Updates
   - Updated Flowbite version
   - Upgraded multiple Ruby gems including:
     - aws-sdk-ecs (1.192.0)
     - bootsnap (1.18.6)
     - rubocop (1.75.6)
     - rack (3.1.15)
     - rubocop-rails (2.32.0)

## Modified Files

### Controllers
- `app/controllers/harmony/clients/api/logs_controller.rb`
  - Added multi-client support
  - Enhanced export functionality
  - Added file deletion capability
  - Added token-level filtering
- `app/controllers/harmony/clients/api/sessions_controller.rb`
  - Implemented multi-client filtering
  - Added CSV export capabilities
  - Updated client filter parameter support
- `app/controllers/harmony/marketing/buyflows_controller.rb`
  - Added provider name search
  - Improved parameter handling
  - Cleaned up error handling
  - Removed console.log statements

### Frontend Components
- `app/frontend/components/api/filter_bar/component.html.haml`
  - Updated for multi-client selection
  - Enhanced UI layout
  - Improved alignment and spacing
  - Added token selection support
- `app/frontend/components/api/filter_bar/component.rb`
  - Enhanced filter functionality
  - Added multi-client support
  - Added token filtering
- `app/frontend/components/widget/date_range_picker/component.html.haml`
  - Integrated Flowbite date picker
  - Improved UI/UX
- `app/javascript/controllers/client_select_controller.js`
  - Added new controller for client selection
  - Enhanced token selection
- `app/javascript/controllers/marketing/buyflows_controller.js`
  - Improved URL preview handling
  - Enhanced parameter management
  - Added confirmation dialog for deletion

### Models and Services
- `app/models/marketing/buyflow.rb`
  - Enhanced parameter handling
  - Improved type determination
- `app/services/harmony/clients/api/log_filter_service.rb`
  - Updated for multi-client support
  - Enhanced filtering capabilities
  - Added token filtering
- `app/services/harmony/clients/api/session_filter_service.rb`
  - Added multi-client filtering
  - Improved session management
- `lib/marketing/buyflow_url_builder.rb`
  - Improved URL construction
  - Enhanced parameter priority handling
- `lib/marketing/utm_params_builder.rb`
  - Simplified UTM parameter handling
  - Removed commented code
  - Improved parameter management

### Background Jobs
- `app/sidekiq/harmony/clients/api/generate_logs_csv_job.rb`
  - Enhanced date handling
  - Improved logging
  - Added private method prefix
- `app/sidekiq/harmony/clients/api/generate_sessions_csv_job.rb`
  - Implemented sessions CSV export
  - Added file management

### Views
- Added new export list partials for logs and sessions
- Updated session and log index views
- Enhanced buyflow management views
- Improved form components
- Added search form for buyflows
- Updated UTM parameters form
- Added token selection interface

### Configuration
- `config/importmap.rb`
  - Updated JavaScript dependencies
  - Added new controller imports
- `config/initializers/api_sessions.rb`
  - Added new initializer for API sessions
- `config/routes.rb`
  - Added routes for new functionality
  - Updated existing routes
  - Added toggle_include_in_logs route

## Testing Notes
- API Sessions
  - Verified multi-client selection
  - Tested CSV export functionality
  - Confirmed file deletion works
  - Validated export list view
  - Tested token-level filtering
  - Verified include_in_logs toggle
- Buyflow Management
  - Tested URL preview generation
  - Verified parameter handling
  - Confirmed search functionality
  - Validated parameter deletion
  - Tested token selection
- UI Components
  - Tested date picker across browsers
  - Verified client selection dropdown
  - Confirmed responsive design
  - Validated filter bar functionality
  - Tested token selection interface
  - Verified search functionality

## Dependencies
- Flowbite
  - Updated to latest version
  - Confirmed compatibility
  - Removed datepicker dependency
- Ruby Gems
  - All dependency updates tested
  - No breaking changes identified
  - Updated security patches applied

## Deployment Notes
- No database migrations required
- Clear Redis cache after deployment
- Update environment variables if needed
- Monitor CSV export performance
- Watch for any UI regression in client selection
- Verify Sidekiq job configurations
- Check API session initializer setup
- Monitor token filtering performance
- Verify include_in_logs toggle functionality