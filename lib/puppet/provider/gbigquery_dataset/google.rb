# Copyright 2018 Google Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    AUTO GENERATED CODE     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by Magic Modules and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in README.md and
#     CONTRIBUTING.md located at the root of this package.
#
# ----------------------------------------------------------------------------

require 'google/bigquery/network/delete'
require 'google/bigquery/network/get'
require 'google/bigquery/network/post'
require 'google/bigquery/network/put'
require 'google/bigquery/property/dataset_access'
require 'google/bigquery/property/dataset_dataset_reference'
require 'google/bigquery/property/dataset_view'
require 'google/bigquery/property/enum'
require 'google/bigquery/property/integer'
require 'google/bigquery/property/namevalues'
require 'google/bigquery/property/string'
require 'google/hash_utils'
require 'puppet'

Puppet::Type.type(:gbigquery_dataset).provide(:google) do
  mk_resource_methods

  def self.instances
    debug('instances')
    raise [
      '"puppet resource" is not supported at the moment:',
      'TODO(nelsonjr): https://goto.google.com/graphite-bugs-view?id=167'
    ].join(' ')
  end

  def self.prefetch(resources)
    debug('prefetch')
    resources.each do |name, resource|
      project = resource[:project]
      debug("prefetch #{name}") if project.nil?
      debug("prefetch #{name} @ #{project}") unless project.nil?
      fetch = fetch_resource(resource, self_link(resource), 'bigquery#dataset')
      resource.provider = present(name, fetch) unless fetch.nil?
    end
  end

  def self.present(name, fetch)
    result = new({ title: name, ensure: :present }.merge(fetch_to_hash(fetch)))
    result
  end

  def self.fetch_to_hash(fetch)
    {
      access: Google::Bigquery::Property::DatasetAccessArray.api_munge(
        fetch['access']
      ),
      creation_time:
        Google::Bigquery::Property::Integer.api_munge(fetch['creationTime']),
      dataset_reference:
        Google::Bigquery::Property::DatasetDatasetReferen.api_munge(
          fetch['datasetReference']
        ),
      default_table_expiration_ms:
        Google::Bigquery::Property::Integer.api_munge(
          fetch['defaultTableExpirationMs']
        ),
      description:
        Google::Bigquery::Property::String.api_munge(fetch['description']),
      friendly_name:
        Google::Bigquery::Property::String.api_munge(fetch['friendlyName']),
      id: Google::Bigquery::Property::String.api_munge(fetch['id']),
      labels: Google::Bigquery::Property::NameValues.api_munge(fetch['labels']),
      last_modified_time: Google::Bigquery::Property::Integer.api_munge(
        fetch['lastModifiedTime']
      ),
      location: Google::Bigquery::Property::String.api_munge(fetch['location'])
    }.reject { |_, v| v.nil? }
  end

  def exists?
    debug("exists? #{@property_hash[:ensure] == :present}")
    @property_hash[:ensure] == :present
  end

  def create
    debug('create')
    @created = true
    create_req = Google::Bigquery::Network::Post.new(collection(@resource),
                                                     fetch_auth(@resource),
                                                     'application/json',
                                                     resource_to_request)
    return_if_object create_req.send, 'bigquery#dataset'
    @property_hash[:ensure] = :present
  end

  def destroy
    debug('destroy')
    @deleted = true
    delete_req = Google::Bigquery::Network::Delete.new(self_link(@resource),
                                                       fetch_auth(@resource))
    return_if_object delete_req.send, 'bigquery#dataset'
    @property_hash[:ensure] = :absent
  end

  def flush
    debug('flush')
    # return on !@dirty is for aiding testing (puppet already guarantees that)
    return if @created || @deleted || !@dirty
    update_req = Google::Bigquery::Network::Put.new(self_link(@resource),
                                                    fetch_auth(@resource),
                                                    'application/json',
                                                    resource_to_request)
    return_if_object update_req.send, 'bigquery#dataset'
  end

  def dirty(field, from, to)
    @dirty = {} if @dirty.nil?
    @dirty[field] = {
      from: from,
      to: to
    }
  end

  private

  def self.resource_to_hash(resource)
    {
      project: resource[:project],
      name: resource[:name],
      kind: 'bigquery#dataset',
      access: resource[:access],
      creation_time: resource[:creation_time],
      dataset_reference: resource[:dataset_reference],
      default_table_expiration_ms: resource[:default_table_expiration_ms],
      description: resource[:description],
      friendly_name: resource[:friendly_name],
      id: resource[:id],
      labels: resource[:labels],
      last_modified_time: resource[:last_modified_time],
      location: resource[:location]
    }.reject { |_, v| v.nil? }
  end

  def resource_to_request
    request = {
      kind: 'bigquery#dataset',
      access: @resource[:access],
      datasetReference: @resource[:dataset_reference],
      defaultTableExpirationMs: @resource[:default_table_expiration_ms],
      description: @resource[:description],
      friendlyName: @resource[:friendly_name],
      labels: @resource[:labels],
      location: @resource[:location]
    }.reject { |_, v| v.nil? }
    debug "request: #{request}" unless ENV['PUPPET_HTTP_DEBUG'].nil?
    request.to_json
  end

  def fetch_auth(resource)
    self.class.fetch_auth(resource)
  end

  def self.fetch_auth(resource)
    Puppet::Type.type(:gauth_credential).fetch(resource)
  end

  def debug(message)
    puts("DEBUG: #{message}") if ENV['PUPPET_HTTP_VERBOSE']
    super(message)
  end

  def self.collection(data)
    URI.join(
      'https://www.googleapis.com/bigquery/v2/',
      expand_variables(
        'projects/{{project}}/datasets',
        data
      )
    )
  end

  def collection(data)
    self.class.collection(data)
  end

  def self.self_link(data)
    URI.join(
      'https://www.googleapis.com/bigquery/v2/',
      expand_variables(
        'projects/{{project}}/datasets/{{name}}',
        data
      )
    )
  end

  def self_link(data)
    self.class.self_link(data)
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def self.return_if_object(response, kind)
    raise "Bad response: #{response.body}" \
      if response.is_a?(Net::HTTPBadRequest)
    raise "Bad response: #{response}" \
      unless response.is_a?(Net::HTTPResponse)
    return if response.is_a?(Net::HTTPNotFound)
    return if response.is_a?(Net::HTTPNoContent)
    result = JSON.parse(response.body)
    raise_if_errors result, %w[error errors], 'message'
    raise "Bad response: #{response}" unless response.is_a?(Net::HTTPOK)
    raise "Incorrect result: #{result['kind']} (expected '#{kind}')" \
      unless result['kind'] == kind
    result
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  def return_if_object(response, kind)
    self.class.return_if_object(response, kind)
  end

  def self.extract_variables(template)
    template.scan(/{{[^}]*}}/).map { |v| v.gsub(/{{([^}]*)}}/, '\1') }
            .map(&:to_sym)
  end

  def self.expand_variables(template, var_data, extra_data = {})
    data = if var_data.class <= Hash
             var_data.merge(extra_data)
           else
             resource_to_hash(var_data).merge(extra_data)
           end
    extract_variables(template).each do |v|
      unless data.key?(v)
        raise "Missing variable :#{v} in #{data} on #{caller.join("\n")}}"
      end
      template.gsub!(/{{#{v}}}/, CGI.escape(data[v].to_s))
    end
    template
  end

  def self.fetch_resource(resource, self_link, kind)
    get_request = ::Google::Bigquery::Network::Get.new(
      self_link, fetch_auth(resource)
    )
    return_if_object get_request.send, kind
  end

  def self.raise_if_errors(response, err_path, msg_field)
    errors = ::Google::HashUtils.navigate(response, err_path)
    raise_error(errors, msg_field) unless errors.nil?
  end

  def self.raise_error(errors, msg_field)
    raise IOError, ['Operation failed:',
                    errors.map { |e| e[msg_field] }.join(', ')].join(' ')
  end
end