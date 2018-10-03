# Google Cloud BigQuery Puppet Module

[![Puppet Forge](http://img.shields.io/puppetforge/v/google/gbigquery.svg)](https://forge.puppetlabs.com/google/gbigquery)

#### Table of Contents

1. [Module Description - What the module does and why it is useful](
    #module-description)
2. [Setup - The basics of getting started with Google Cloud BigQuery](#setup)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](
   #reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Module Description

This Puppet module manages the resource of Google Cloud BigQuery.
You can manage its resources using standard Puppet DSL and the module will,
under the hood, ensure the state described will be reflected in the Google
Cloud Platform resources.

## Setup

To install this module on your Puppet Master (or Puppet Client/Agent), use the
Puppet module installer:

    puppet module install google-gbigquery

Optionally you can install support to _all_ Google Cloud Platform products at
once by installing our "bundle" [`google-cloud`][bundle-forge] module:

    puppet module install google-cloud

Since this module depends on the `googleauth` and `google-api-client` gems,
you will also need to install those, with

    /opt/puppetlabs/puppet/bin/gem install googleauth google-api-client

If you prefer, you could also add the following to your puppet manifest:

		package { [
				'googleauth',
				'google-api-client',
			]:
				ensure   => present,
				provider => puppet_gem,
		}

## Usage

### Credentials

All Google Cloud Platform modules use an unified authentication mechanism,
provided by the [`google-gauth`][] module. Don't worry, it is automatically
installed when you install this module.

```puppet
gauth_credential { 'mycred':
  path     => $cred_path, # e.g. '/home/nelsonjr/my_account.json'
  provider => serviceaccount,
  scopes   => [
    'https://www.googleapis.com/auth/bigquery',
  ],
}
```

Please refer to the [`google-gauth`][] module for further requirements, i.e.
required gems.

### Examples

#### `gbigquery_dataset`

```puppet
gbigquery_dataset { 'example_dataset':
  ensure            => present,
  dataset_reference => {
    dataset_id => 'example_dataset'
  },
  project           => $project, # e.g. 'my-test-project'
  credential        => 'mycred',
}

```

#### `gbigquery_table`

```puppet
gbigquery_dataset { 'example_dataset':
  ensure            => present,
  dataset_reference => {
    dataset_id => 'example_dataset'
  },
  project           => $project, # e.g. 'my-test-project'
  credential        => 'mycred',
}

gbigquery_table { 'example_table':
  ensure          => present,
  dataset         => 'example_dataset',
  table_reference => {
    dataset_id => 'example_dataset',
    project_id => $project,
    table_id   => 'example_table'
  },
  project         => $project, # e.g. 'my-test-project'
  credential      => 'mycred',
}

```


### Classes

#### Public classes

* [`gbigquery_dataset`][]:
    Datasets allow you to organize and control access to your tables.
* [`gbigquery_table`][]:
    A Table that belongs to a Dataset

### About output only properties

Some fields are output-only. It means you cannot set them because they are
provided by the Google Cloud Platform. Yet they are still useful to ensure the
value the API is assigning (or has assigned in the past) is still the value you
expect.

For example in a DNS the name servers are assigned by the Google Cloud DNS
service. Checking these values once created is useful to make sure your upstream
and/or root DNS masters are in sync.  Or if you decide to use the object ID,
e.g. the VM unique ID, for billing purposes. If the VM gets deleted and
recreated it will have a different ID, despite the name being the same. If that
detail is important to you you can verify that the ID of the object did not
change by asserting it in the manifest.

### Parameters

#### `gbigquery_dataset`

Datasets allow you to organize and control access to your tables.


#### Example

```puppet
gbigquery_dataset { 'example_dataset':
  ensure            => present,
  dataset_reference => {
    dataset_id => 'example_dataset'
  },
  project           => $project, # e.g. 'my-test-project'
  credential        => 'mycred',
}

```

#### Reference

```puppet
gbigquery_dataset { 'id-of-resource':
  access                      => [
    {
      domain         => string,
      group_by_email => string,
      role           => 'READER', 'WRITER' or 'OWNER',
      special_group  => string,
      user_by_email  => string,
      view           => {
        dataset_id => string,
        table_id   => string,
        project_id => string,
      },
    },
    ...
  ],
  creation_time               => integer,
  dataset_reference           => {
    dataset_id => string,
    project_id => string,
  },
  default_table_expiration_ms => integer,
  description                 => string,
  friendly_name               => string,
  id                          => string,
  labels                      => namevalues,
  last_modified_time          => integer,
  location                    => string,
  name                        => string,
  project                     => string,
  credential                  => reference to gauth_credential,
}
```

##### `name`

  Dataset name

##### `access`

  Access controls on the bucket.

##### access[]/domain
  A domain to grant access to. Any users signed in with the domain specified will be granted the
  specified access

##### access[]/group_by_email
  An email address of a Google Group to grant access to

##### access[]/role
  Describes the rights granted to the user specified by the other member of the access object

##### access[]/special_group
  A special group to grant access to.

##### access[]/user_by_email
  An email address of a user to grant access to. For example: fred@example.com

##### access[]/view
  A view from a different dataset to grant access to. Queries executed against that view will have
  read access to tables in this dataset. The role field is not required when this field is set. If
  that view is updated by any user, access to the view needs to be granted again via an update
  operation.

##### access[]/view/dataset_id
Required.  The ID of the dataset containing this table.

##### access[]/view/project_id
Required.  The ID of the project containing this table.

##### access[]/view/table_id
Required.  The ID of the table. The ID must contain only letters (a-z, A-Z), numbers (0-9), or underscores
  (_). The maximum length is 1,024 characters.

##### `dataset_reference`

Required.  A reference that identifies the dataset.

##### dataset_reference/dataset_id
Required.  A unique ID for this dataset, without the project name. The ID must contain only letters (a-z,
  A-Z), numbers (0-9), or underscores (_). The maximum length is 1,024 characters.

##### dataset_reference/project_id
  The ID of the project containing this dataset.

##### `default_table_expiration_ms`

  The default lifetime of all tables in the dataset, in milliseconds

##### `description`

  A user-friendly description of the dataset

##### `friendly_name`

  A descriptive name for the dataset

##### `labels`

  The labels associated with this dataset. You can use these to organize and group your datasets

##### `location`

  The geographic location where the dataset should reside. Possible values include EU and US. The
  default value is US.


##### Output-only properties

* `creation_time`: Output only.
  The time when this dataset was created, in milliseconds since the epoch.

* `id`: Output only.
  The fully-qualified unique name of the dataset in the format projectId:datasetId. The dataset
  name without the project name is given in the datasetId field

* `last_modified_time`: Output only.
  The date when this dataset or any of its tables was last modified, in milliseconds since the
  epoch.

#### `gbigquery_table`

A Table that belongs to a Dataset


#### Example

```puppet
gbigquery_dataset { 'example_dataset':
  ensure            => present,
  dataset_reference => {
    dataset_id => 'example_dataset'
  },
  project           => $project, # e.g. 'my-test-project'
  credential        => 'mycred',
}

gbigquery_table { 'example_table':
  ensure          => present,
  dataset         => 'example_dataset',
  table_reference => {
    dataset_id => 'example_dataset',
    project_id => $project,
    table_id   => 'example_table'
  },
  project         => $project, # e.g. 'my-test-project'
  credential      => 'mycred',
}

```

#### Reference

```puppet
gbigquery_table { 'id-of-resource':
  creation_time               => integer,
  dataset                     => string,
  description                 => string,
  encryption_configuration    => {
    kms_key_name => string,
  },
  expiration_time             => integer,
  external_data_configuration => {
    autodetect            => boolean,
    bigtable_options      => {
      column_families                    => [
        {
          columns          => [
            {
              encoding         => 'TEXT' or 'BINARY',
              field_name       => string,
              only_read_latest => boolean,
              qualifier_string => string,
              type             => 'BYTES', 'STRING', 'INTEGER', 'FLOAT' or 'BOOLEAN',
            },
            ...
          ],
          encoding         => 'TEXT' or 'BINARY',
          family_id        => string,
          only_read_latest => boolean,
          type             => 'BYTES', 'STRING', 'INTEGER', 'FLOAT' or 'BOOLEAN',
        },
        ...
      ],
      ignore_unspecified_column_families => boolean,
      read_rowkey_as_string              => boolean,
    },
    compression           => 'GZIP' or 'NONE',
    csv_options           => {
      allow_jagged_rows     => boolean,
      allow_quoted_newlines => boolean,
      encoding              => 'UTF-8' or 'ISO-8859-1',
      field_delimiter       => string,
      quote                 => string,
      skip_leading_rows     => integer,
    },
    google_sheets_options => {
      skip_leading_rows => integer,
    },
    ignore_unknown_values => boolean,
    max_bad_records       => integer,
    schema                => {
      fields => [
        {
          description => string,
          fields      => [
            string,
            ...
          ],
          mode        => 'NULLABLE', 'REQUIRED' or 'REPEATED',
          name        => string,
          type        => 'STRING', 'BYTES', 'INTEGER', 'FLOAT', 'TIMESTAMP', 'DATE', 'TIME', 'DATETIME' or 'RECORD',
        },
        ...
      ],
    },
    source_format         => 'CSV', 'GOOGLE_SHEETS', 'NEWLINE_DELIMITED_JSON', 'AVRO', 'DATASTORE_BACKUP' or 'BIGTABLE',
    source_uris           => [
      string,
      ...
    ],
  },
  friendly_name               => string,
  id                          => string,
  labels                      => namevalues,
  last_modified_time          => integer,
  location                    => string,
  num_bytes                   => integer,
  num_long_term_bytes         => integer,
  num_rows                    => integer,
  schema                      => {
    fields => [
      {
        description => string,
        fields      => [
          string,
          ...
        ],
        mode        => 'NULLABLE', 'REQUIRED' or 'REPEATED',
        name        => string,
        type        => 'STRING', 'BYTES', 'INTEGER', 'FLOAT', 'TIMESTAMP', 'DATE', 'TIME', 'DATETIME' or 'RECORD',
      },
      ...
    ],
  },
  streaming_buffer            => {
    estimated_bytes   => integer,
    estimated_rows    => integer,
    oldest_entry_time => integer,
  },
  table_reference             => {
    dataset_id => string,
    table_id   => string,
    projectid  => string,
  },
  time_partitioning           => {
    expiration_ms => integer,
    type          => DAY,
  },
  type                        => 'TABLE', 'VIEW' or 'EXTERNAL',
  view                        => {
    use_legacy_sql                  => boolean,
    user_defined_function_resources => [
      {
        inline_code  => string,
        resource_uri => string,
      },
      ...
    ],
  },
  project                     => string,
  credential                  => reference to gauth_credential,
}
```

##### `table_reference`

  Reference describing the ID of this table

##### table_reference/dataset_id
  The ID of the dataset containing this table

##### table_reference/projectid
  The ID of the project containing this table

##### table_reference/table_id
  The ID of the the table

##### `description`

  A user-friendly description of the dataset

##### `friendly_name`

  A descriptive name for this table

##### `labels`

  The labels associated with this dataset. You can use these to organize and group your datasets

##### `view`

  The view definition.

##### view/use_legacy_sql
  Specifies whether to use BigQuery's legacy SQL for this view

##### view/user_defined_function_resources
  Describes user-defined function resources used in the query.

##### view/user_defined_function_resources[]/inline_code
  An inline resource that contains code for a user-defined function (UDF). Providing a inline code
  resource is equivalent to providing a URI for a file containing the same code.

##### view/user_defined_function_resources[]/resource_uri
  A code resource to load from a Google Cloud Storage URI (gs://bucket/path).

##### `time_partitioning`

  If specified, configures time-based partitioning for this table.

##### time_partitioning/expiration_ms
  Number of milliseconds for which to keep the storage for a partition.

##### time_partitioning/type
  The only type supported is DAY, which will generate one partition per day.

##### `schema`

  Describes the schema of this table

##### schema/fields
  Describes the fields in a table.

##### schema/fields[]/description
  The field description. The maximum length is 1,024 characters.

##### schema/fields[]/fields
  Describes the nested schema fields if the type property is set to RECORD.

##### schema/fields[]/mode
  The field mode

##### schema/fields[]/name
  The field name

##### schema/fields[]/type
  The field data type

##### `encryption_configuration`

  Custom encryption configuration

##### encryption_configuration/kms_key_name
  Describes the Cloud KMS encryption key that will be used to protect destination BigQuery table.
  The BigQuery Service Account associated with your project requires access to this encryption key.

##### `expiration_time`

  The time when this table expires, in milliseconds since the epoch. If not present, the table will
  persist indefinitely.

##### `external_data_configuration`

  Describes the data format, location, and other properties of a table stored outside of BigQuery.
  By defining these properties, the data source can then be queried as if it were a standard
  BigQuery table.

##### external_data_configuration/autodetect
  Try to detect schema and format options automatically. Any option specified explicitly will be
  honored.

##### external_data_configuration/compression
  The compression type of the data source

##### external_data_configuration/ignore_unknown_values
  Indicates if BigQuery should allow extra values that are not represented in the table schema

##### external_data_configuration/max_bad_records
  The maximum number of bad records that BigQuery can ignore when reading data

##### external_data_configuration/source_format
  The data format

##### external_data_configuration/source_uris
  The fully-qualified URIs that point to your data in Google Cloud. For Google Cloud Storage URIs:
  Each URI can contain one '*' wildcard character and it must come after the 'bucket' name. Size
  limits related to load jobs apply to external data sources. For Google Cloud Bigtable URIs:
  Exactly one URI can be specified and it has be a fully specified and valid HTTPS URL for a Google
  Cloud Bigtable table. For Google Cloud Datastore backups, exactly one URI can be specified. Also,
  the '*' wildcard character is not allowed.

##### external_data_configuration/schema
  The schema for the data. Schema is required for CSV and JSON formats

##### external_data_configuration/schema/fields
  Describes the fields in a table.

##### external_data_configuration/schema/fields[]/description
  The field description

##### external_data_configuration/schema/fields[]/fields
  Describes the nested schema fields if the type property is set to RECORD

##### external_data_configuration/schema/fields[]/mode
  Field mode.

##### external_data_configuration/schema/fields[]/name
  Field name

##### external_data_configuration/schema/fields[]/type
  Field data type

##### external_data_configuration/google_sheets_options
  Additional options if sourceFormat is set to GOOGLE_SHEETS.

##### external_data_configuration/google_sheets_options/skip_leading_rows
  The number of rows at the top of a Google Sheet that BigQuery will skip when reading the data.

##### external_data_configuration/csv_options
  Additional properties to set if sourceFormat is set to CSV.

##### external_data_configuration/csv_options/allow_jagged_rows
  Indicates if BigQuery should accept rows that are missing trailing optional columns

##### external_data_configuration/csv_options/allow_quoted_newlines
  Indicates if BigQuery should allow quoted data sections that contain newline characters in a CSV
  file

##### external_data_configuration/csv_options/encoding
  The character encoding of the data

##### external_data_configuration/csv_options/field_delimiter
  The separator for fields in a CSV file

##### external_data_configuration/csv_options/quote
  The value that is used to quote data sections in a CSV file

##### external_data_configuration/csv_options/skip_leading_rows
  The number of rows at the top of a CSV file that BigQuery will skip when reading the data.

##### external_data_configuration/bigtable_options
  Additional options if sourceFormat is set to BIGTABLE.

##### external_data_configuration/bigtable_options/ignore_unspecified_column_families
  If field is true, then the column families that are not specified in columnFamilies list are not
  exposed in the table schema

##### external_data_configuration/bigtable_options/read_rowkey_as_string
  If field is true, then the rowkey column families will be read and converted to string.

##### external_data_configuration/bigtable_options/column_families
  List of column families to expose in the table schema along with their types.

##### external_data_configuration/bigtable_options/column_families[]/columns
  Lists of columns that should be exposed as individual fields as opposed to a list of (column
  name, value) pairs.

##### external_data_configuration/bigtable_options/column_families[]/columns[]/encoding
  The encoding of the values when the type is not STRING

##### external_data_configuration/bigtable_options/column_families[]/columns[]/field_name
  If the qualifier is not a valid BigQuery field identifier, a valid identifier must be provided as
  the column field name and is used as field name in queries.

##### external_data_configuration/bigtable_options/column_families[]/columns[]/only_read_latest
  If this is set, only the latest version of value in this column are exposed

##### external_data_configuration/bigtable_options/column_families[]/columns[]/qualifier_string
Required.  Qualifier of the column

##### external_data_configuration/bigtable_options/column_families[]/columns[]/type
  The type to convert the value in cells of this column

##### external_data_configuration/bigtable_options/column_families[]/encoding
  The encoding of the values when the type is not STRING

##### external_data_configuration/bigtable_options/column_families[]/family_id
  Identifier of the column family.

##### external_data_configuration/bigtable_options/column_families[]/only_read_latest
  If this is set only the latest version of value are exposed for all columns in this column family

##### external_data_configuration/bigtable_options/column_families[]/type
  The type to convert the value in cells of this column family

##### `dataset`

  Name of the dataset


##### Output-only properties

* `creation_time`: Output only.
  The time when this dataset was created, in milliseconds since the epoch.

* `id`: Output only.
  An opaque ID uniquely identifying the table.

* `last_modified_time`: Output only.
  The time when this table was last modified, in milliseconds since the epoch.

* `location`: Output only.
  The geographic location where the table resides. This value is inherited from the dataset.

* `num_bytes`: Output only.
  The size of this table in bytes, excluding any data in the streaming buffer.

* `num_long_term_bytes`: Output only.
  The number of bytes in the table that are considered "long-term storage".

* `num_rows`: Output only.
  The number of rows of data in this table, excluding any data in the streaming buffer.

* `type`: Output only.
  Describes the table type

* `streaming_buffer`: Output only.
  Contains information regarding this table's streaming buffer, if one is present. This field will
  be absent if the table is not being streamed to or if there is no data in the streaming buffer.

##### streaming_buffer/estimated_bytes
Output only.  A lower-bound estimate of the number of bytes currently in the streaming buffer.

##### streaming_buffer/estimated_rows
Output only.  A lower-bound estimate of the number of rows currently in the streaming buffer.

##### streaming_buffer/oldest_entry_time
Output only.  Contains the timestamp of the oldest entry in the streaming buffer, in milliseconds since the
  epoch, if the streaming buffer is available.


## Limitations

This module has been tested on:

* RedHat 6, 7
* CentOS 6, 7
* Debian 7, 8
* Ubuntu 12.04, 14.04, 16.04, 16.10
* SLES 11-sp4, 12-sp2
* openSUSE 13
* Windows Server 2008 R2, 2012 R2, 2012 R2 Core, 2016 R2, 2016 R2 Core

Testing on other platforms has been minimal and cannot be guaranteed.

## Development

### Automatically Generated Files

Some files in this package are automatically generated by
[Magic Modules][magic-modules].

We use a code compiler to produce this module in order to avoid repetitive tasks
and improve code quality. This means all Google Cloud Platform Puppet modules
use the same underlying authentication, logic, test generation, style checks,
etc.

Learn more about the way to change autogenerated files by reading the
[CONTRIBUTING.md][] file.

### Contributing

Contributions to this library are always welcome and highly encouraged.

See [CONTRIBUTING.md][] for more information on how to get
started.

### Running tests

This project contains tests for [rspec][], [rspec-puppet][] and [rubocop][] to
verify functionality. For detailed information on using these tools, please see
their respective documentation.

#### Testing quickstart: Ruby > 2.0.0

```
gem install bundler
bundle install
bundle exec rspec
bundle exec rubocop
```

#### Debugging Tests

In case you need to debug tests in this module you can set the following
variables to increase verbose output:

Variable                | Side Effect
------------------------|---------------------------------------------------
`PUPPET_HTTP_VERBOSE=1` | Prints network access information by Puppet provier.
`PUPPET_HTTP_DEBUG=1`   | Prints the payload of network calls being made.
`GOOGLE_HTTP_VERBOSE=1` | Prints debug related to the network calls being made.
`GOOGLE_HTTP_DEBUG=1`   | Prints the payload of network calls being made.

During test runs (using [rspec][]) you can also set:

Variable                | Side Effect
------------------------|---------------------------------------------------
`RSPEC_DEBUG=1`         | Prints debug related to the tests being run.
`RSPEC_HTTP_VERBOSE=1`  | Prints network expectations and access.

[magic-modules]: https://github.com/GoogleCloudPlatform/magic-modules
[CONTRIBUTING.md]: CONTRIBUTING.md
[bundle-forge]: https://forge.puppet.com/google/cloud
[`google-gauth`]: https://github.com/GoogleCloudPlatform/puppet-google-auth
[rspec]: http://rspec.info/
[rspec-puppet]: http://rspec-puppet.com/
[rubocop]: https://rubocop.readthedocs.io/en/latest/
[`gbigquery_dataset`]: #gbigquery_dataset
[`gbigquery_table`]: #gbigquery_table
