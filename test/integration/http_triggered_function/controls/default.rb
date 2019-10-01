# encoding: utf-8
# copyright: 2018, The Authors

title 'GCP HTTP Cloud Function Test'

gcp_project_id = attribute('gcp_project_id')
cloud_function = attribute('cloud_function')
location       = attribute('location')
# you add controls here
control 'gcp-http-cloud-function-1.0' do
  impact 1.0
  title 'HTTP Cloud Function'
  describe google_cloudfunctions_cloud_function(project: gcp_project_id, name: cloud_function, location: location) do
    it { should exist }
  end
end
