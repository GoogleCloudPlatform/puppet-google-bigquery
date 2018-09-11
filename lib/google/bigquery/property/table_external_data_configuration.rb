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

require 'google/bigquery/property/base'

module Google
  module Bigquery
    module Data
      # A class to manage data for ExternalDataConfiguration for table.
      class TableExternalDataConfiguration
        include Comparable

        attr_reader :autodetect
        attr_reader :compression
        attr_reader :ignore_unknown_values
        attr_reader :max_bad_records
        attr_reader :source_format
        attr_reader :source_uris
        attr_reader :schema
        attr_reader :google_sheets_options
        attr_reader :csv_options
        attr_reader :bigtable_options

        def to_json(_arg = nil)
          {
            'autodetect' => autodetect,
            'compression' => compression,
            'ignoreUnknownValues' => ignore_unknown_values,
            'maxBadRecords' => max_bad_records,
            'sourceFormat' => source_format,
            'sourceUris' => source_uris,
            'schema' => schema,
            'googleSheetsOptions' => google_sheets_options,
            'csvOptions' => csv_options,
            'bigtableOptions' => bigtable_options
          }.reject { |_k, v| v.nil? }.to_json
        end

        def to_s
          {
            autodetect: autodetect,
            compression: compression,
            ignore_unknown_values: ignore_unknown_values,
            max_bad_records: max_bad_records,
            source_format: source_format,
            source_uris: source_uris,
            schema: schema,
            google_sheets_options: google_sheets_options,
            csv_options: csv_options,
            bigtable_options: bigtable_options
          }.reject { |_k, v| v.nil? }.map { |k, v| "#{k}: #{v}" }.join(', ')
        end

        def ==(other)
          return false unless other.is_a? TableExternalDataConfiguration
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            return false if compare[:self] != compare[:other]
          end
          true
        end

        def <=>(other)
          return false unless other.is_a? TableExternalDataConfiguration
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
            { self: autodetect, other: other.autodetect },
            { self: compression, other: other.compression },
            { self: ignore_unknown_values, other: other.ignore_unknown_values },
            { self: max_bad_records, other: other.max_bad_records },
            { self: source_format, other: other.source_format },
            { self: source_uris, other: other.source_uris },
            { self: schema, other: other.schema },
            { self: google_sheets_options, other: other.google_sheets_options },
            { self: csv_options, other: other.csv_options },
            { self: bigtable_options, other: other.bigtable_options }
          ]
        end
      end

      # Manages a TableExternalDataConfiguration nested object
      # Data is coming from the GCP API
      class TableExternalDataConfigurationApi < TableExternalDataConfiguration
        def initialize(args)
          @autodetect = Google::Bigquery::Property::Boolean.api_munge(args['autodetect'])
          @compression = Google::Bigquery::Property::Enum.api_munge(args['compression'])
          @ignore_unknown_values =
            Google::Bigquery::Property::Boolean.api_munge(args['ignoreUnknownValues'])
          @max_bad_records = Google::Bigquery::Property::Integer.api_munge(args['maxBadRecords'])
          @source_format = Google::Bigquery::Property::Enum.api_munge(args['sourceFormat'])
          @source_uris = Google::Bigquery::Property::StringArray.api_munge(args['sourceUris'])
          @schema = Google::Bigquery::Property::TableSchema.api_munge(args['schema'])
          @google_sheets_options = Google::Bigquery::Property::TableGoogleSheetsOptions.api_munge(
            args['googleSheetsOptions']
          )
          @csv_options = Google::Bigquery::Property::TableCsvOptions.api_munge(args['csvOptions'])
          @bigtable_options =
            Google::Bigquery::Property::TableBigtableOptions.api_munge(args['bigtableOptions'])
        end
      end

      # Manages a TableExternalDataConfiguration nested object
      # Data is coming from the Puppet manifest
      class TableExternalDataConfigurationCatalog < TableExternalDataConfiguration
        def initialize(args)
          @autodetect = Google::Bigquery::Property::Boolean.unsafe_munge(args['autodetect'])
          @compression = Google::Bigquery::Property::Enum.unsafe_munge(args['compression'])
          @ignore_unknown_values =
            Google::Bigquery::Property::Boolean.unsafe_munge(args['ignore_unknown_values'])
          @max_bad_records =
            Google::Bigquery::Property::Integer.unsafe_munge(args['max_bad_records'])
          @source_format = Google::Bigquery::Property::Enum.unsafe_munge(args['source_format'])
          @source_uris = Google::Bigquery::Property::StringArray.unsafe_munge(args['source_uris'])
          @schema = Google::Bigquery::Property::TableSchema.unsafe_munge(args['schema'])
          @google_sheets_options =
            Google::Bigquery::Property::TableGoogleSheetsOptions.unsafe_munge(
              args['google_sheets_options']
            )
          @csv_options =
            Google::Bigquery::Property::TableCsvOptions.unsafe_munge(args['csv_options'])
          @bigtable_options =
            Google::Bigquery::Property::TableBigtableOptions.unsafe_munge(args['bigtable_options'])
        end
      end
    end

    module Property
      # A class to manage input to ExternalDataConfiguration for table.
      class TableExternalDataConfiguration < Google::Bigquery::Property::Base
        # Used for parsing Puppet catalog
        def unsafe_munge(value)
          self.class.unsafe_munge(value)
        end

        # Used for parsing Puppet catalog
        def self.unsafe_munge(value)
          return if value.nil?
          Data::TableExternalDataConfigurationCatalog.new(value)
        end

        # Used for parsing GCP API responses
        def self.api_munge(value)
          return if value.nil?
          Data::TableExternalDataConfigurationApi.new(value)
        end
      end
    end
  end
end
