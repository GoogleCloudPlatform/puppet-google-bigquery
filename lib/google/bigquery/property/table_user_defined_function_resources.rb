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

require 'google/bigquery/property/array'
require 'google/bigquery/property/base'

module Google
  module Bigquery
    module Data
      # A class to manage data for UserDefinedFunctionResources for table.
      class TableUserDefinedFunctionResources
        include Comparable

        attr_reader :inline_code
        attr_reader :resource_uri

        def to_json(_arg = nil)
          {
            'inlineCode' => inline_code,
            'resourceUri' => resource_uri
          }.reject { |_k, v| v.nil? }.to_json
        end

        def to_s
          {
            inline_code: inline_code,
            resource_uri: resource_uri
          }.reject { |_k, v| v.nil? }.map { |k, v| "#{k}: #{v}" }.join(', ')
        end

        def ==(other)
          return false unless other.is_a? TableUserDefinedFunctionResources
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            return false if compare[:self] != compare[:other]
          end
          true
        end

        def <=>(other)
          return false unless other.is_a? TableUserDefinedFunctionResources
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            result = compare[:self] <=> compare[:other]
            return result unless result.zero?
          end
          0
        end

        private

        def compare_fields(other)
          [
            { self: inline_code, other: other.inline_code },
            { self: resource_uri, other: other.resource_uri }
          ]
        end
      end

      # Manages a TableUserDefinedFunctionResources nested object
      # Data is coming from the GCP API
      class TableUserDefinedFunctionResourcesApi < TableUserDefinedFunctionResources
        def initialize(args)
          @inline_code = Google::Bigquery::Property::String.api_munge(args['inlineCode'])
          @resource_uri = Google::Bigquery::Property::String.api_munge(args['resourceUri'])
        end
      end

      # Manages a TableUserDefinedFunctionResources nested object
      # Data is coming from the Puppet manifest
      class TableUserDefinedFunctionResourcesCatalog < TableUserDefinedFunctionResources
        def initialize(args)
          @inline_code = Google::Bigquery::Property::String.unsafe_munge(args['inline_code'])
          @resource_uri = Google::Bigquery::Property::String.unsafe_munge(args['resource_uri'])
        end
      end
    end

    module Property
      # A class to manage input to UserDefinedFunctionResources for table.
      class TableUserDefinedFunctionResources < Google::Bigquery::Property::Base
        # Used for parsing Puppet catalog
        def unsafe_munge(value)
          self.class.unsafe_munge(value)
        end

        # Used for parsing Puppet catalog
        def self.unsafe_munge(value)
          return if value.nil?
          Data::TableUserDefinedFunctionResourcesCatalog.new(value)
        end

        # Used for parsing GCP API responses
        def self.api_munge(value)
          return if value.nil?
          Data::TableUserDefinedFunctionResourcesApi.new(value)
        end
      end

      # A Puppet property that holds an integer
      class TableUserDefinedFunctionResourcesArray < Google::Bigquery::Property::Array
        # Used for parsing Puppet catalog
        def unsafe_munge(value)
          self.class.unsafe_munge(value)
        end

        # Used for parsing Puppet catalog
        def self.unsafe_munge(value)
          return if value.nil?
          return TableUserDefinedFunctionResources.unsafe_munge(value) \
            unless value.is_a?(::Array)
          value.map { |v| TableUserDefinedFunctionResources.unsafe_munge(v) }
        end

        # Used for parsing GCP API responses
        def self.api_munge(value)
          return if value.nil?
          return TableUserDefinedFunctionResources.api_munge(value) \
            unless value.is_a?(::Array)
          value.map { |v| TableUserDefinedFunctionResources.api_munge(v) }
        end
      end
    end
  end
end
