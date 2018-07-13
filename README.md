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
  ensure     => present,
  dataset_reference => {
    dataset_id => 'example_dataset'
  },
  project    => $project, # e.g. 'my-test-project'
  credential => 'mycred',
}

```


### Classes

#### Public classes

* [`gbigquery_dataset`][]:
    Datasets allow you to organize and control access to your tables.

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
  ensure     => present,
  dataset_reference => {
    dataset_id => 'example_dataset'
  },
  project    => $project, # e.g. 'my-test-project'
  credential => 'mycred',
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
  project                     => string,
  credential                  => reference to gauth_credential,
}
```

##### `access`

  Access controls on the bucket.

##### access[]/domain
  A domain to grant access to. Any users signed in with the domain specified
  will be granted the specified access

##### access[]/group_by_email
  An email address of a Google Group to grant access to

##### access[]/role
  Describes the rights granted to the user specified by the other member of the
  access object

##### access[]/special_group
  A special group to grant access to.

##### access[]/user_by_email
  An email address of a user to grant access to. For example: fred@example.com

##### access[]/view
  A view from a different dataset to grant access to. Queries executed against
  that view will have read access to tables in this dataset. The role field is
  not required when this field is set. If that view is updated by any user,
  access to the view needs to be granted again via an update operation.

##### access[]/view/dataset_id
Required.  The ID of the dataset containing this table.

##### access[]/view/project_id
Required.  The ID of the project containing this table.

##### access[]/view/table_id
Required.  The ID of the table. The ID must contain only letters (a-z, A-Z), numbers
  (0-9), or underscores (_). The maximum length is 1,024 characters.

##### `dataset_reference`

Required.  A reference that identifies the dataset.

##### dataset_reference/dataset_id
Required.  A unique ID for this dataset, without the project name. The ID must contain
  only letters (a-z, A-Z), numbers (0-9), or underscores (_). The maximum
  length is 1,024 characters.

##### dataset_reference/project_id
  The ID of the project containing this dataset.

##### `default_table_expiration_ms`

  The default lifetime of all tables in the dataset, in milliseconds

##### `description`

  A user-friendly description of the dataset

##### `friendly_name`

  A descriptive name for the dataset

##### `labels`

  The labels associated with this dataset. You can use these to organize and
  group your datasets

##### `location`

  The geographic location where the dataset should reside. Possible values
  include EU and US. The default value is US.


##### Output-only properties

* `creation_time`: Output only.
  The time when this dataset was created, in milliseconds since the epoch.

* `id`: Output only.
  The fully-qualified unique name of the dataset in the format
  projectId:datasetId. The dataset name without the project name is given in
  the datasetId field

* `last_modified_time`: Output only.
  The date when this dataset or any of its tables was last modified, in
  milliseconds since the epoch.


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
